import AdventKit
import Foundation

public class Puzzle {
    let input: [String]
    public init(input: String) {
        self.input = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
    }

    public func part1() -> Int {
        var ip = 0
        var set = Set<Int>()
        var acc = 0

        while !set.contains(ip) {
            set.insert(ip)

            let line = input[ip].components(separatedBy: " ")
            switch line[0] {
            case "acc":
                acc += Int(line[1])!
                ip += 1
            case "jmp":
                ip += Int(line[1])!
            case "nop":
                ip += 1
            default:
                fatalError()
            }
        }
        return acc
    }

    public func part2() -> Int {
        var toggled = Set<Int>()

        while true {
            // reset state
            var set = Set<Int>()
            var acc = 0
            var ip = 0
            var didToggle = false

            while ip < input.count, !set.contains(ip) {
                set.insert(ip)

                let line = input[ip].components(separatedBy: " ")
                var instruction = line[0]

                if instruction != "acc", !toggled.contains(ip), !didToggle {
                    instruction = instruction == "nop" ? "jmp" : "nop"
                    didToggle = true
                    toggled.insert(ip)
                }

                switch instruction {
                case "acc":
                    acc += Int(line[1])!
                    ip += 1
                case "jmp":
                    ip += Int(line[1])!
                case "nop":
                    ip += 1
                default:
                    fatalError()
                }
            }
            if ip >= input.count {
                return acc
            }
        }
    }
}
