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
        let x = ids
            .enumerated().filter { $0.element != nil }

        let max = x.max { $0.element! < $1.element! }!
        let tail = x.filter { $0.element != max.element }

        var cycles = 0
        let a = stride(from: max.element! * (526_090_310_999_410 / max.element!), to: Int.max, by: max.element!).first { ts in
//        let a = stride(from: max.element!, to: Int.max, by: max.element!).first { ts in
            cycles += 1
            if cycles % 1_000_000 == 0 {
                print("\(cycles):\t\(ts)")
            }
            return tail.allSatisfy { s in
                (ts + (s.offset - max.offset)) % s.element! == 0
            }
        }

        return a! - max.offset
    }
}
