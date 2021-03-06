import CHyperscan
import Foundation

public class Hyperscan {
    
    typealias MatchHandler = (UInt32, UInt64, UInt64, UInt32, UnsafeMutableRawPointer?) -> Int32
    
    public init() {
    }
    
    public func scan(_ input: String, for pattern: String, options: MatchingOptions = [.dotAll]) -> MatchResult? {
        
        var matchResult = MatchResult(pattern: pattern, input: input)
        
        let result = pattern.withCString { patternPtr in
            input.withCString { inputPtr in
                blockScan(patternPtr, inputPtr, UInt32(input.utf8CString.count), options, &matchResult)
            }
        }
        
        return result ? matchResult : nil
    }
    
    func blockScan(_ patternPtr: UnsafePointer<Int8>,
                   _ inputPtr: UnsafePointer<Int8>,
                   _ length: UInt32,
                   _ matchingOptions: MatchingOptions,
                   _ matchResult: inout MatchResult) -> Bool {
        
        let context = Context()
        defer { context.releaseMemory() }
        
        do {
            try compile(context, patternPtr, matchingOptions, [.block])
            
            let scratch = try allocScratch(context)
            defer {
                hs_free_scratch(scratch.pointee.scratch)
                scratch.deallocate()
            }
            
            try scan(context, scratch, inputPtr, length, &matchResult)
        } catch {
            Debug.run { print(error, to: &standardError) }
            return false
        }
        
        return true
    }
    
    func compile(_ context: Context,
                 _ patternPtr: UnsafePointer<Int8>,
                 _ matchingOptions: MatchingOptions,
                 _ compileOptions: CompileOptions) throws {
        
        let result = run(swift_hs_compile(patternPtr,
                                          matchingOptions.rawValue,
                                          compileOptions.rawValue,
                                          context.platformInfoPtr,
                                          context.databasePtr,
                                          context.compileErrorPtr))
        
        if result != HSResult.success {
            Debug.run { swift_print_compile_error(context.compileErrorPtr) }
            throw result
        }
    }
    
    func scan(_ context: Context,
              _ scratch: UnsafeMutablePointer<swift_hs_scratch_t>,
              _ inputPtr: UnsafePointer<Int8>,
              _ length: UInt32,
              _ matchResult: inout MatchResult) throws {
        
        func eventHandler(id: UInt32, from: UInt64, to: UInt64, flags: UInt32,
                          context: UnsafeMutableRawPointer?) -> Int32 {
            
            if let ptr = context?.assumingMemoryBound(to: MatchResult.self) {
                let matchResult = ptr.pointee
                matchResult.matches.append(Match(from: from, to: to))
            }
            
            return 0
        }
        
        let result = run(swift_hs_scan(context.databasePtr,
                                       inputPtr,
                                       length,
                                       scratch,
                                       eventHandler,
                                       &matchResult))
        
        if result != HSResult.success {
            throw result
        }
    }
    
    func allocScratch(_ context: Context) throws -> UnsafeMutablePointer<swift_hs_scratch_t> {
        var scratch = swift_hs_scracth(scratch: nil)
        let result = run(swift_hs_alloc_scratch(context.databasePtr, &scratch))
        
        if result != HSResult.success {
            throw result
        }
        
        let ptr =  UnsafeMutablePointer<swift_hs_scratch_t>.allocate(capacity: 1)
        ptr.initialize(to: scratch)
        return ptr
    }
    
    @inline(__always)
    func run(_ procedure: @autoclosure () -> hs_error_t) -> HSResult {
        let rawResult = procedure()
        guard let result = HSResult(rawValue: rawResult) else {
            fatalError("ERROR: Unknown hs_error_t type = \(rawResult)")
        }
        
        return result
    }
}
