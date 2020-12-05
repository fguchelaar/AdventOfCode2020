import AdventKit
import Foundation

public class Puzzle {
    let input: [String]
    public init(input: String) {
        self.input = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
    }

    func id(for boardingPass: String) -> Int {
        let s = boardingPass
            .replacingOccurrences(of: "B", with: "1")
            .replacingOccurrences(of: "F", with: "0")
            .replacingOccurrences(of: "R", with: "1")
            .replacingOccurrences(of: "L", with: "0")

        let row = Int(s.prefix(7), radix: 2)!
        let column = Int(s.suffix(3), radix: 2)!
        return row * 8 + column
    }

    public func part1() -> Int {
        input
            .map(id(for:))
            .max()!
    }

    public func part2() -> String {
        ""
    }
}
