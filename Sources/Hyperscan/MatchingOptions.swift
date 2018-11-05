import Foundation

public struct MatchingOptions: OptionSet {
    public let rawValue: UInt32
    
    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }
    
    // HS_FLAG_CASELESS - Matching will be performed case-insensitively.
    public static let caseless = MatchingOptions(rawValue: 1 << 0)
    
    // HS_FLAG_DOTALL - Matching a `.` will not exclude newlines.
    public static let dotAll = MatchingOptions(rawValue: 1 << 1)
    
    // HS_FLAG_MULTILINE - `^` and `$` anchors match any newlines in data.
    public static let multiline = MatchingOptions(rawValue: 1 << 2)
    
    // HS_FLAG_SINGLEMATCH - Only one match will be generated for the expression per stream.
    public static let singleMatch = MatchingOptions(rawValue: 1 << 3)
    
    // HS_FLAG_ALLOWEMPTY - Allow expressions which can match against an empty string, such as `.*`.
    public static let allowEmpty = MatchingOptions(rawValue: 1 << 4)
    
    // HS_FLAG_UTF8 - Treat this pattern as a sequence of UTF-8 characters.
    public static let utf8 = MatchingOptions(rawValue: 1 << 5)
    
    // HS_FLAG_UCP - Use Unicode properties for character classes.
    public static let ucp = MatchingOptions(rawValue: 1 << 6)
    
    // HS_FLAG_PREFILTER - Compile pattern in prefiltering mode.
    public static let perfilter = MatchingOptions(rawValue: 1 << 7)
    
    // HS_FLAG_SOM_LEFTMOST - Report the leftmost start of match offset when a match is found.
    public static let somLeftmost = MatchingOptions(rawValue: 1 << 8)
}
