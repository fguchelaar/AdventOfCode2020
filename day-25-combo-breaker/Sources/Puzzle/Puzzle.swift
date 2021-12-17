import AdventKit
import Foundation

public class Puzzle {
    let input: [Int]
    public init(input: String) {
        self.input = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .compactMap(Int.init)
    }

    public func part1() -> Int {
        handshake(loopSize: findLoopSize(for: input[0]), subjectNumber: input[1])
    }

    func findLoopSize(for key: Int) -> Int {
        var value = 1
        for loop in 0... {
            value = (value * 7) % 20201227
            if value == key {
                return loop
            }
        }
        return -1
    }

    func handshake(loopSize: Int, subjectNumber: Int) -> Int {
        (0 ..< loopSize).reduce(subjectNumber) { v, l in
            return (v * subjectNumber) % 20201227
        }
    }
}
