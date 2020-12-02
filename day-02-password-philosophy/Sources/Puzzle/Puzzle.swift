import AdventKit
import Foundation

struct Password {
    private var i1, i2: Int
    private var letter: Character
    private var password: String

    init(_ string: String) {
        let parts = string
            .components(separatedBy: CharacterSet(charactersIn: "-: "))
            .filter { !$0.isEmpty }
        i1 = Int(parts[0])!
        i2 = Int(parts[1])!
        letter = Character(parts[2])
        password = parts[3]
    }

    var isValidPart1: Bool {
        let count = password.filter { $0 == letter }.count
        return count >= i1 && count <= i2
    }

    var isValidPart2: Bool {
        (password[i1 - 1] == letter) != (password[i2 - 1] == letter)
    }
}

public class Puzzle {
    let input: [String]
    public init(input: String) {
        self.input = input
            .trimmingCharacters(in: .newlines)
            .components(separatedBy: .newlines)
    }

    public func part1() -> Int {
        input
            .map(Password.init)
            .filter { $0.isValidPart1 }
            .count
    }

    public func part2() -> Int {
        input
            .map(Password.init)
            .filter { $0.isValidPart2 }
            .count
    }
}
