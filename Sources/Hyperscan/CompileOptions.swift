import Foundation

public struct CompileOptions: OptionSet {
    public let rawValue: UInt32
    
    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }
    
    /**
     * Compiler mode flag: Block scan (non-streaming) database.
     */
    public static let block = CompileOptions(rawValue: 1 << 0)
    
    /**
     * Compiler mode flag: Alias for @ref HS_MODE_BLOCK.
     */
    public static let nostream = CompileOptions(rawValue: 1 << 0)
    
    /**
     * Compiler mode flag: Streaming database.
     */
    public static let stream = CompileOptions(rawValue: 1 << 1)

    /**
     * Compiler mode flag: Vectored scanning database.
     */
    public static let vectored = CompileOptions(rawValue: 1 << 2)
    
    /**
     * Compiler mode flag: use full precision to track start of match offsets in
     * stream state.
     *
     * This mode will use the most stream state per pattern, but will always return
     * an accurate start of match offset regardless of how far back in the past it
     * was found.
     *
     * One of the SOM_HORIZON modes must be selected to use the @ref
     * HS_FLAG_SOM_LEFTMOST expression flag.
     */
    public static let somHorizonLarge = CompileOptions(rawValue: 1 << 24)
    
    /**
     * Compiler mode flag: use medium precision to track start of match offsets in
     * stream state.
     *
     * This mode will use less stream state than @ref HS_MODE_SOM_HORIZON_LARGE and
     * will limit start of match accuracy to offsets within 2^32 bytes of the
     * end of match offset reported.
     *
     * One of the SOM_HORIZON modes must be selected to use the @ref
     * HS_FLAG_SOM_LEFTMOST expression flag.
     */
    public static let somHorizonMedium = CompileOptions(rawValue: 1 << 25)
    
    /**
     * Compiler mode flag: use limited precision to track start of match offsets in
     * stream state.
     *
     * This mode will use less stream state than @ref HS_MODE_SOM_HORIZON_LARGE and
     * will limit start of match accuracy to offsets within 2^16 bytes of the
     * end of match offset reported.
     *
     * One of the SOM_HORIZON modes must be selected to use the @ref
     * HS_FLAG_SOM_LEFTMOST expression flag.
     */
    public static let somHorizonSmall = CompileOptions(rawValue: 1 << 26)
}
