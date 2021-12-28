import AdventKit
import Foundation

public class Puzzle {
    let foods: [Food]
    public init(input: String) {
        foods = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .map(Food.init)
    }

    public func part1() -> Int {
        let allAllergens = foods.flatMap { $0.allergens }
        var candidates = Set<String>()

        for allergen in allAllergens {
            let ingredients = foods
                .filter { $0.allergens.contains(allergen) }
                .map { $0.ingredients }
            var intersection = Set(ingredients[0])
            for list in ingredients.dropFirst() {
                intersection = intersection.intersection(Set(list))
            }
            intersection.forEach { candidates.insert($0) }
        }

        return foods
            .flatMap { $0.ingredients }
            .filter { !candidates.contains($0) }
            .count
    }

    public func part2() -> String {
        let allAllergens = foods.flatMap { $0.allergens }
        var candidates = [String: Set<String>]()

        for allergen in allAllergens {
            let ingredients = foods
                .filter { $0.allergens.contains(allergen) }
                .map { $0.ingredients }
            var intersection = Set(ingredients[0])
            for list in ingredients.dropFirst() {
                intersection = intersection.intersection(Set(list))
            }
            candidates[allergen] = intersection
        }

        while !candidates.filter({ $0.value.count > 1 }).isEmpty {
            for candidate in candidates.filter({ $0.value.count == 1 }) {
                for other in candidates.filter({ $0.value.count > 1 }) {
                    candidates[other.key] = other.value.subtracting(candidate.value)
                }
            }
        }

        return candidates
            .sorted { $0.key < $1.key }
            .compactMap { $0.value.first }
            .joined(separator: ",")
    }
}
