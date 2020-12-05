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
        Int(boardingPass
            .replacingOccurrences(of: "B", with: "1")
            .replacingOccurrences(of: "F", with: "0")
            .replacingOccurrences(of: "R", with: "1")
            .replacingOccurrences(of: "L", with: "0"),
            radix: 2)!
    }

    public func part1() -> Int {
        input
            .map(id(for:))
            .max()!
    }

    public func part2() -> Int {
        let ids = input
            .map(id(for:))

        let mySeatId = (8...).first {
            ids.contains($0 - 1)
                && !ids.contains($0)
                && ids.contains($0 + 1)
        }
        return mySeatId!
    }
}
