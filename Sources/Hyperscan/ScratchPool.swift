import Foundation
import CHyperscan

class ScratchPool {
    
    static let key = "tokyo.ainame.hyperscan.scratch"
    
    init() {
    }
    
    func allocateScratchOnCurrentThread(_ context: Context) {
        let scratch: swift_hs_scratch_t? = nil
        // swift_hs_allocate_scratch(context.dbPtr, &scratch)
        Thread.current.threadDictionary[ScratchPool.key] = scratch
    }
    
    var currentScratch: swift_hs_scratch_t {
        return Thread.current.threadDictionary[ScratchPool.key] as! swift_hs_scratch_t
    }
    
}

