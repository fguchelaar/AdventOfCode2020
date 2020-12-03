import AdventKit
import Foundation

public class Puzzle {
    let input: [String]
    public init(input: String) {
        self.input = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
    }

    func trees(for slope: Point) -> Int {
        let rows = input.count
        let columns = input[0].count

        var position = Point(x: 0, y: 0)
        var trees = 0

        repeat {
            position = position + slope
            if input[position.y][position.x % columns] == Character("#") {
                trees += 1
            }
        } while position.y < rows - 1

        return trees
    }

    public func part1() -> Int {
        trees(for: Point(x: 3, y: 1))
    }

    public func part2() -> Int {
        [
            Point(x: 1, y: 1),
            Point(x: 3, y: 1),
            Point(x: 5, y: 1),
            Point(x: 7, y: 1),
            Point(x: 1, y: 2),
        ]
        .map(trees(for:))
        .reduce(1, *)
    }
}
