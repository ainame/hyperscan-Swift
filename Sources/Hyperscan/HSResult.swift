import Foundation

enum HSResult: Int32, Swift.Error {
    /**
     * The engine completed normally.
     */
    case success = 0
    
    /**
     * A parameter passed to this function was invalid.
     *
     * This error is only returned in cases where the function can detect an
     * invalid parameter -- it cannot be relied upon to detect (for example)
     * pointers to freed memory or other invalid data.
     */
    case invalid = -1
    
    /**
     * A memory allocation failed.
     */
    case noMemory = -2
    
    /**
     * The engine was terminated by callback.
     *
     * This return value indicates that the target buffer was partially scanned,
     * but that the callback function requested that scanning cease after a match
     * was located.
     */
    case scanTerminated = -3
    
    /**
     * The pattern compiler failed, and the @ref hs_compile_error_t should be
     * inspected for more detail.
     */
    case compilerError = -4
    
    /**
     * The given database was built for a different version of Hyperscan.
     */
    case dbVersionError = -5
    
    /**
     * The given database was built for a different platform (i.e., CPU type).
     */
    case dbPlatformError = -6
    
    /**
     * The given database was built for a different mode of operation. This error
     * is returned when streaming calls are used with a block or vectored database
     * and vice versa.
     */
    case dbModeError = -7
    
    /**
     * A parameter passed to this function was not correctly aligned.
     */
    case badAlign = -8
    
    /**
     * The memory allocator (either malloc() or the allocator set with @ref
     * hs_set_allocator()) did not correctly return memory suitably aligned for the
     * largest representable data type on this platform.
     */
    case badAlloc = -9
    
    /**
     * The scratch region was already in use.
     *
     * This error is returned when Hyperscan is able to detect that the scratch
     * region given is already in use by another Hyperscan API call.
     *
     * A separate scratch region, allocated with @ref hs_alloc_scratch() or @ref
     * hs_clone_scratch(), is required for every concurrent caller of the Hyperscan
     * API.
     *
     * For example, this error might be returned when @ref hs_scan() has been
     * called inside a callback delivered by a currently-executing @ref hs_scan()
     * call using the same scratch region.
     *
     * Note: Not all concurrent uses of scratch regions may be detected. This error
     * is intended as a best-effort debugging tool, not a guarantee.
     */
    case scratchInUse = -10
    
    /**
     * Unsupported CPU architecture.
     *
     * This error is returned when Hyperscan is able to detect that the current
     * system does not support the required instruction set.
     *
     * At a minimum, Hyperscan requires Supplemental Streaming SIMD Extensions 3
     * (SSSE3).
     */
    case archError = -11
    
    /**
     * Provided buffer was too small.
     *
     * This error indicates that there was insufficient space in the buffer. The
     * call should be repeated with a larger provided buffer.
     *
     * Note: in this situation, it is normal for the amount of space required to be
     * returned in the same manner as the used space would have been returned if the
     * call was successful.
     */
    case insufficientSpace = -12
}
