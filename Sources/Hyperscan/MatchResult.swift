import Foundation

public class MatchResult {
    public let pattern: String
    public let input: String
    public var matches = [Match]()
    
    public init(pattern: String, input: String, matches: [Match] = []) {
        self.pattern = pattern
        self.input = input
        self.matches = matches
    }
}

