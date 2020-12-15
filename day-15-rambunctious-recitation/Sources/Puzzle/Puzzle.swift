import AdventKit
import Foundation

public class Puzzle {
    let input: [Int]
    public init(input: [Int]) {
        self.input = input
    }

    func solve(numbers: [Int], rounds: Int) -> Int {
        var spoken: [Int: Int] = numbers.enumerated().dropLast().reduce(into: [Int: Int]()) {
            $0[$1.element] = $1.offset
        }
        var last = -1
        var next = input.last!
        (spoken.count ..< rounds).forEach { i in
            last = next
            if let previous = spoken[last] {
                next = i - previous
            } else {
                next = 0
            }
            spoken[last] = i
        }
        return last
    }

    public func part1() -> Int {
        solve(numbers: input, rounds: 2020)
    }

    public func part2() -> Int {
        solve(numbers: input, rounds: 30_000_000)
    }
}
