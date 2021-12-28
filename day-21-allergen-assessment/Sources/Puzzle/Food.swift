import Foundation

struct Food {
    let ingredients: [String]
    let allergens: [String]

    init(_ string: String) {
        let idx = string.firstIndex(of: "(")!
        let allIngredients = string.prefix(upTo: idx)
        ingredients = allIngredients.split(separator: " ", omittingEmptySubsequences: true).map(String.init)

        let aIdx = string.index(idx, offsetBy: 10)
        let allAllergens = string.suffix(from: aIdx).dropLast()
        allergens = allAllergens.split(separator: ",").map { String($0).trimmingCharacters(in: .whitespaces) }
    }
}
