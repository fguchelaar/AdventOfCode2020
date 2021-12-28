import AdventKit
import Foundation

extension String {
    func isMatch(pattern: String) -> Bool {
        !matches(pattern: pattern).isEmpty
    }

    func matches(pattern: String) -> [String] {
        let regex = try! NSRegularExpression(pattern: pattern)
        let range = NSRange(startIndex..., in: self)
        let matches = regex.matches(in: self, range: range)
        return matches.map { String(self[Range($0.range, in: self)!]) }
    }

    func ranges(pattern: String) -> [Range<String.Index>] {
        let regex = try! NSRegularExpression(pattern: pattern)
        let range = NSRange(startIndex..., in: self)
        let matches = regex.matches(in: self, range: range)
        return matches.map { Range($0.range, in: self)! }
    }
}

public class Puzzle {
    var rules: [Int: String]
    let messages: [String]
    public init(input: String) {
        let parts = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: "\n\n")

        rules = parts[0].components(separatedBy: .newlines).reduce(into: [:]) { dict, line in

            let split = line.split(separator: ":")
            let ruleNo = Int(split[0])!
            // sanitize "a" and "b"
            // also add an extra space at the end, that helps with the string-replacing when
            // constructing the regex
            let rule = String(split[1])
                .replacingOccurrences(of: #""a""#, with: "a")
                .replacingOccurrences(of: #""b""#, with: "b")
                .appending(" ")

            // append parentheses around the rules with an 'or' operator
            dict[ruleNo] = rule.contains("|") ? " ( \(rule) ) " : rule
        }

        messages = parts[1].components(separatedBy: .newlines)
    }

    func createRegEx() -> String {
        var unresolved = rules
        var resolved = rules.filter { !$0.value.contains(where: { "0123456789".contains($0) }) }
        resolved.forEach { unresolved.removeValue(forKey: $0.key) }

        // we're just going to loop-the-loop until we've replaced all references
        while !unresolved.isEmpty {
            for todo in unresolved {
                var value = todo.value
                for done in resolved {
                    value = value.replacingOccurrences(of: " \(done.key) ", with: done.value)
                }
                if value.contains(where: { "0123456789".contains($0) }) {
                    unresolved[todo.key] = value
                } else {
                    resolved[todo.key] = value
                }
            }
            resolved.forEach { unresolved.removeValue(forKey: $0.key) }
        }
        return resolved[0]!
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: "!", with: "1")
            .replacingOccurrences(of: "@", with: "2")
            .replacingOccurrences(of: "#", with: "3")
            .replacingOccurrences(of: "$", with: "4")
            .replacingOccurrences(of: "%", with: "5")
            .replacingOccurrences(of: "^", with: "6")
    }

    public func part1() -> Int {
        let regex = "^\(createRegEx())$"
        return messages.filter { $0.isMatch(pattern: regex) }.count
    }

    public func part2() -> Int {
        // 8: 42 | 42 8
        // 11: 42 31 | 42 11 31
        rules[8] = " 42 + "
        rules[11] = " ( 42 {!} 31 {!} | 42 {@} 31 {@} | 42 {#} 31 {#} | 42 {$} 31 {$} | 42 {%} 31 {%} | 42 {^} 31 {^} )"
        let regex = "^\(createRegEx())$"
        return messages.filter { $0.isMatch(pattern: regex) }.count
    }
}
