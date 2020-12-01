import AdventKit
import Algorithms
import Foundation

public class Puzzle {
    let input: [Int]
    public init(input: String) {
        self.input = input
            .components(separatedBy: .whitespacesAndNewlines)
            .compactMap(Int.init)
    }

    public func part1() -> Int {
        solve(with: 2, for: 2020)
    }

    public func part2() -> Int {
        solve(with: 3, for: 2020)
    }

    private func solve(with count: Int, for result: Int) -> Int {
        input
            .combinations(ofCount: count)
            .first { $0.reduce(0, +) == result }!
            .reduce(1, *)
    }
}
