import AdventKit
import Foundation

public class Puzzle {
    let input: [String]
    public init(input: String) {
        self.input = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
    }

    func or(from mask: String) -> UInt64 {
        UInt64(mask.replacingOccurrences(of: "X", with: "0"), radix: 2)!
    }

    func and(from mask: String) -> UInt64 {
        UInt64(mask.replacingOccurrences(of: "X", with: "1"), radix: 2)!
    }

    public func part1() -> UInt64 {
        var orMask: UInt64 = 0
        var andMask: UInt64 = 0
        var registers = [String: UInt64]()

        input.forEach { line in

            let parts = line.components(separatedBy: " = ")

            let instruction = parts[0]
            let value = parts[1]

            if instruction == "mask" {
                orMask = or(from: value)
                andMask = and(from: value)
            } else {
                let result = (UInt64(value)! | orMask) & andMask
                registers[instruction] = result
            }
        }

        return registers.values.reduce(0,+)
    }

    /// Creates a mask to `0` all bits at X positions, but keep the ones that are `1`. Use the
    /// bitwise `&` operator to prepare the address
    func base(from mask: String) -> UInt64 {
        UInt64(mask
            .replacingOccurrences(of: "0", with: "1")
            .replacingOccurrences(of: "X", with: "0"),
            radix: 2)!
    }

    /// Creates 2^(count of X) masks for the floating X's. Use the bitwise `|` operator to
    /// get the addresses
    func floating(from mask: String) -> [UInt64] {
        // first `0` all the `1`'s
        let temp = mask.replacingOccurrences(of: "1", with: "0")

        // number of masks is 2^(count of X's)
        let xCount = mask.filter { $0 == "X" }.count
        let count = Int(pow(2.0, Double(xCount)))

        // create the permutations
        let masks = (0 ..< count).map { c -> String in
            let xs = temp.enumerated().filter { $0.element == "X" }
            let bits = String(c, radix: 2).padLeft(toLength: xs.count, withPad: "0")

            var mask = Array(temp)
            xs.enumerated().forEach { wrapped in
                mask[wrapped.element.offset] = bits[wrapped.offset]
            }
            return String(mask)
        }

        return masks.compactMap { UInt64($0, radix: 2) }
    }

    public func part2() -> UInt64 {
        var orMask: UInt64 = 0
        var baseMask: UInt64 = 0
        var floatingMasks: [UInt64] = []

        var registers = [UInt64: UInt64]()

        input.forEach { line in

            let parts = line.components(separatedBy: " = ")

            let instruction = parts[0]
            let value = parts[1]

            if instruction == "mask" {
                orMask = or(from: value)
                baseMask = base(from: value)
                floatingMasks = floating(from: value)
            } else {
                let address = UInt64(instruction
                    .trimmingCharacters(in: CharacterSet.letters.union(.punctuationCharacters)))!
                let baseAddress = (address | orMask) & baseMask

                floatingMasks.forEach { mask in
                    registers[baseAddress | mask] = UInt64(value)!
                }
            }
        }
        return registers.values.reduce(0,+)
    }
}
