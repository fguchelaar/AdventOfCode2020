import AdventKit
import Foundation

public class Puzzle {
    let bags: [String: [String: Int]]
    public init(input: String) {
        bags = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .reduce(into: [String: [String: Int]]()) { dict, line in

                let parts = line.components(separatedBy: " bags contain ")
                let color = parts[0]
                let contents = parts[1]

                if contents.contains("no other bags") {
                    dict[color] = [String: Int]()
                } else {
                    dict[color] = contents
                        .components(separatedBy: ",")
                        .reduce(into: [String: Int]()) { dict, descr in

                            let temp = descr.replacingOccurrences(of: #"bag(s)?(\.)?"#, with: "", options: .regularExpression)
                                .trimmingCharacters(in: .whitespaces)
                                .components(separatedBy: " ")

                            let value = Int(temp[0])!
                            let key = temp.dropFirst().joined(separator: " ")
                            dict[key] = value
                        }
                }
            }
    }

    func contains(_ color: String, _ query: String, _ dict: [String: [String: Int]]) -> Bool {
        dict[color]!.keys.contains(query)
            || dict[color]!.keys.contains { contains($0, query, dict) }
    }

    public func part1() -> Int {
        bags
            .filter { contains($0.key, "shiny gold", bags) }
            .count
    }

    func count(_ color: String, _ dict: [String: [String: Int]]) -> Int {
        dict[color]!
            .reduce(0) { a, b in
                a + b.value + (b.value * count(b.key, dict))
            }
    }

    public func part2() -> Int {
        count("shiny gold", bags)
    }
}
