import AdventKit
import Foundation

struct Passport {
    let fields: [String: String]

    init(_ string: String) {
        fields = string
            .components(separatedBy: .whitespacesAndNewlines)
            .reduce(into: [String: String]()) { dict, record in
                let pair = record.components(separatedBy: ":")
                dict[pair[0]] = pair[1]
            }
    }

    var containsRequiredFields: Bool {
        Set(["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"])
            .isSubset(of: fields.keys)
    }

    var isValid: Bool {
        containsRequiredFields
            && fields.allSatisfy {
                switch $0.key {
                case "byr":
                    return (1920 ... 2002).contains(Int($0.value) ?? -1)
                case "iyr":
                    return (2010 ... 2020).contains(Int($0.value) ?? -1)
                case "eyr":
                    return (2020 ... 2030).contains(Int($0.value) ?? -1)
                case "hgt":
                    let number =
                        Int($0.value.trimmingCharacters(in: .letters)) ?? -1

                    return ($0.value.hasSuffix("cm") && (150 ... 193).contains(number)
                        || $0.value.hasSuffix("in") && (59 ... 76).contains(number))
                case "hcl":
                    return $0.value.range(of: #"^#[0-9a-f]{6}$"#, options: .regularExpression) != nil
                case "ecl":
                    return $0.value.range(of: #"^(amb|blu|brn|gry|grn|hzl|oth)$"#, options: .regularExpression) != nil
                case "pid":
                    return $0.value.range(of: #"^\d{9}$"#, options: .regularExpression) != nil
                case "cid":
                    return true
                default:
                    return false
                }
            }
    }
}

public class Puzzle {
    let passports: [Passport]
    public init(input: String) {
        passports = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: "\n\n")
            .map(Passport.init)
    }

    public func part1() -> Int {
        passports
            .filter { $0.containsRequiredFields }
            .count
    }

    public func part2() -> Int {
        passports
            .filter { $0.isValid }
            .count
    }
}
