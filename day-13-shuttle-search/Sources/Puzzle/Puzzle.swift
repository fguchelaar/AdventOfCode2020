import AdventKit
import Foundation

public class Puzzle {
    let estimate: Int
    let ids: [Int?]
    public init(input: String) {
        let parts = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)

        estimate = Int(parts[0])!
        ids = parts[1]
            .components(separatedBy: ",")
            .map { Int($0) }
    }

    public func part1() -> Int {
        let shuttle = ids
            .compactMap { $0 }
            .map { ($0, $0 - (estimate % $0)) }
            .min { $0.1 < $1.1 }!

        return shuttle.0 * shuttle.1
    }

    public func part2() -> Int {
        let shuttles = ids.enumerated()
            .filter { $0.element != nil }
            .map { ($0.element!, $0.offset) }

        var interval = shuttles[0].0
        var ts = interval

        shuttles.dropFirst().forEach { shuttle in
            while (ts + shuttle.1) % shuttle.0 != 0 {
                ts += interval
            }
            interval = lcm(interval, shuttle.0)
        }
        return ts
    }
}
