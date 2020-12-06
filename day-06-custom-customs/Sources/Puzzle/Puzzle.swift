import AdventKit
import Foundation

public class Puzzle {
    let input: [String]
    public init(input: String) {
        self.input = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: "\n\n")
    }

    public func part1() -> Int {
        input
            .map { $0.replacingOccurrences(of: "\n", with: "") }
            .map { Set($0).count }
            .reduce(0, +)
    }

    public func part2() -> Int {
        input
            .map { group in
                group.components(separatedBy: .newlines)
                    .map { Set($0) }
                    .reduce(Set("abcdefghijklmnopqrstuvwxyz")) { a, b in
                        a.intersection(b)
                    }.count
            }
            .reduce(0, +)
    }
}
