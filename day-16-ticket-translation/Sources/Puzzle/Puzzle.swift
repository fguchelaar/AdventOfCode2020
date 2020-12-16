import AdventKit
import Foundation

struct Rule {
    let key: String
    let lower1, lower2, upper1, upper2: Int

    init(_ str: String) {
        key = String(str.prefix { $0 != ":" })

        let regex = try! NSRegularExpression(pattern: #"\d+"#)
        let range = NSRange(location: 0, length: str.utf16.count)
        let matches = regex.matches(in: str, options: [], range: range)
        lower1 = Int(str[Range(matches[0].range, in: str)!])!
        upper1 = Int(str[Range(matches[1].range, in: str)!])!
        lower2 = Int(str[Range(matches[2].range, in: str)!])!
        upper2 = Int(str[Range(matches[3].range, in: str)!])!
    }

    func isValid(_ int: Int) -> Bool {
        (int >= lower1 && int <= upper1) || (int >= lower2 && int <= upper2)
    }
}

public class Puzzle {
    let rules: [Rule]
    let ticket: [Int]
    let nearby: [[Int]]

    public init(input: String) {
        let parts = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: "\n\n")

        rules = parts[0].components(separatedBy: .newlines).map(Rule.init)

        ticket = parts[1]
            .components(separatedBy: .newlines)
            .last!
            .components(separatedBy: ",")
            .compactMap(Int.init)

        nearby = parts[2]
            .components(separatedBy: .newlines)
            .dropFirst()
            .map {
                $0.components(separatedBy: ",").compactMap(Int.init)
            }
    }

    public func part1() -> Int {
        nearby
            .flatMap { $0 }
            .filter { value in !rules.contains { rule in rule.isValid(value) } }
            .reduce(0, +)
    }

    public func part2() -> String {
        ""
    }
}
