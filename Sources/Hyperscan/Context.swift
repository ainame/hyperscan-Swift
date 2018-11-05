import Foundation
import CHyperscan

struct Context {
    let databasePtr = UnsafeMutablePointer<swift_hs_database_t>.allocate(capacity: 1)
    let compileErrorPtr = UnsafeMutablePointer<swift_hs_compile_error_t>.allocate(capacity: 1)
    let platformInfoPtr = UnsafeMutablePointer<hs_platform_info_t>.allocate(capacity: 1)
    
    init() {
        hs_populate_platform(platformInfoPtr)
    }
    
    var database: swift_hs_database_t {
        return databasePtr.pointee
    }
    
    var compileError: swift_hs_compile_error_t {
        return compileErrorPtr.pointee
    }
    
    var platformInfo: hs_platform_info_t {
        return platformInfoPtr.pointee
    }
    
    func releaseMemory() {
        hs_free_database(database.database)
        databasePtr.deallocate()
        
        hs_free_compile_error(compileError.error)
        compileErrorPtr.deallocate()
        
        platformInfoPtr.deallocate()
    }
}

