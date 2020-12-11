import AdventKit
import Foundation

// MARK: - helpers for the Point stuff

let toPoint: (Int, Int) -> Point = { i, c in
    Point(x: i % c, y: i / c)
}

let toIndex: (Point, Int) -> Int = { p, c in
    p.y * c + p.x
}

let n8: (Point) -> [Point] = { p in
    [
        Point(x: p.x - 1, y: p.y - 1),
        Point(x: p.x, y: p.y - 1),
        Point(x: p.x + 1, y: p.y - 1),

        Point(x: p.x - 1, y: p.y),
        Point(x: p.x + 1, y: p.y),

        Point(x: p.x - 1, y: p.y + 1),
        Point(x: p.x, y: p.y + 1),
        Point(x: p.x + 1, y: p.y + 1),
    ]
}

let inBounds: (Point, Int, Int) -> Bool = { p, r, c in
    (p.x >= 0 && p.x < c)
        && (p.y >= 0 && p.y < r)
}

// MARK: - actual solution

public class Puzzle {
    let input: [Character]
    let rows, columns: Int
    public init(input: String) {
        let split = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)

        rows = split.count
        columns = split[0].count
        self.input = split.joined().map { $0 }
    }

    /// Calculates the seating layout based on these rules:
    /// * If a seat is empty (L) and there are no occupied seats adjacent to it, the seat becomes occupied.
    /// * If a seat is occupied (#) and four or more seats adjacent to it are also occupied, the seat becomes empty.
    /// * Otherwise, the seat's state does not change.
    public func part1() -> Int {
        var layout = input
        var state = [Character]()

        while layout != state {
            state = layout
            let changed = layout.enumerated().map { (i, e) -> Character in
                if e == "." {
                    return e
                }

                let occupied = n8(toPoint(i, columns))
                    .filter { inBounds($0, rows, columns) && layout[toIndex($0, columns)] == "#" }
                    .count

                if e == "L", occupied == 0 {
                    return "#"
                } else if e == "#", occupied >= 4 {
                    return "L"
                } else {
                    return e
                }
            }

            layout = changed
        }

        return layout.filter { $0 == "#" }.count
    }

    public func part2() -> Int {
        var neighbors = [Point: [Point]]()

        let find: (_ grid: [Character], _ start: Point, _ dx: Int, _ dy: Int) -> Point? = { [self] g, s, x, y in

            var test = Point(x: s.x + x, y: s.y + y)

            while inBounds(test, rows, columns), g[toIndex(test, columns)] == "." {
                test = Point(x: test.x + x, y: test.y + y)
            }

            return inBounds(test, rows, columns) ? test : nil
        }

        let n8_2: (_ grid: [Character], _ start: Point) -> [Point] = { g, p in
            if let nb = neighbors[p] {
                return nb
            } else {
                let nb = [
                    find(g, p, -1, -1),
                    find(g, p, 0, -1),
                    find(g, p, 1, -1),
                    find(g, p, -1, 0),
                    find(g, p, 1, 0),
                    find(g, p, -1, 1),
                    find(g, p, 0, 1),
                    find(g, p, 1, 1),
                ].compactMap { $0 }
                neighbors[p] = nb
                return nb
            }
        }

        var layout = input
        var state = [Character]()

        while layout != state {
            state = layout
            let changed = layout.enumerated().map { (i, e) -> Character in
                if e == "." {
                    return e
                }

                let occupied = n8_2(layout, toPoint(i, columns))
                    .filter { inBounds($0, rows, columns) && layout[toIndex($0, columns)] == "#" }
                    .count

                if e == "L", occupied == 0 {
                    return "#"
                } else if e == "#", occupied >= 5 {
                    return "L"
                } else {
                    return e
                }
            }

            layout = changed
        }

        return layout.filter { $0 == "#" }.count
    }
}
