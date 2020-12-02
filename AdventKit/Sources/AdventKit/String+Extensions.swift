import Foundation

public extension String {
    func array<T>(
        separatedBy characterSet: CharacterSet, using function: (String) -> T?
    ) -> [T] {
        trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: characterSet)
            .compactMap(function)
    }

    var intArray: [Int] {
        trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .compactMap(Int.init)
    }

    func extractInts() -> [Int] {
        return split(whereSeparator: { !"-1234567890".contains($0) }).compactMap { Int($0) }
    }
}
