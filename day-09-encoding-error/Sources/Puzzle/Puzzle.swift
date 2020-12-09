import AdventKit
import Foundation

public class Puzzle {
    public var preambleLength = 25

    let input: [Int]
    public init(input: String) {
        self.input = input.intArray
    }

    public func part1() -> Int {
        var preamble = Array(input[..<preambleLength])
        let xmas = input[preambleLength...]

        for data in xmas {
            var containsMatch = false
            for i in 0 ..< preambleLength {
                for j in i ..< preambleLength {
                    if preamble[i] + preamble[j] == data {
                        containsMatch = true
                    }
                }
            }
            if !containsMatch {
                return data
            }
            preamble.removeFirst()
            preamble.append(data)
        }
        return -1
    }

    public func part2() -> Int {
        let invalidNumber = part1()

        for i in 0 ..< input.count {
            var set = Set<Int>()
            var sum = 0
            var j = i
            while sum < invalidNumber {
                sum += input[j]
                set.insert(input[j])
                j += 1
            }

            if sum == invalidNumber {
                return set.min()! + set.max()!
            }
        }

        return -1
    }
}
