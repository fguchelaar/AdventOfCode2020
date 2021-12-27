import AdventKit
import Foundation

struct Tile {
    let id: Int
    let data: [Point: Character]
    let width: Int
    let height: Int

    init(_ id: Int, data: [Point: Character], width: Int, height: Int) {
        self.id = id
        self.data = data
        self.width = width
        self.height = height
    }

    init(_ string: String) {
        let lines = string.components(separatedBy: .newlines)
        id = Int(lines[0].trimmingCharacters(in: .decimalDigits.inverted))!
        height = lines.count - 1
        width = lines[1].count
        var data = [Point: Character]()
        for row in lines.dropFirst().enumerated() {
            for col in row.element.enumerated() {
                data[Point(x: col.offset, y: row.offset)] = col.element
            }
        }
        self.data = data
    }

    /// all 8 orientations for the tile
    func allOrientations() -> [Tile] {
        let r90 = rotate90()
        let r90f = r90.flipHorizontal()
        let r180 = r90.rotate90()
        let r180f = r180.flipHorizontal()
        let r270 = r180.rotate90()
        let r270f = r270.flipHorizontal()
        return [
            self,
            flipHorizontal(),
            r90,
            r90f,
            r180,
            r180f,
            r270,
            r270f,
        ]
    }

    func rotate90() -> Tile {
        var rotated = [Point: Character]()
        for y in 0..<height {
            for x in 0..<width {
                let p = Point(x: width - y - 1, y: x)
                rotated[p] = data[Point(x: x, y: y)]
            }
        }
        return Tile(id, data: rotated, width: height, height: width)
    }

    func flipHorizontal() -> Tile {
        var flipped = [Point: Character]()
        for y in 0..<height {
            for x in 0..<width {
                let p = Point(x: width - x - 1, y: y)
                flipped[p] = data[Point(x: x, y: y)]
            }
        }
        return Tile(id, data: flipped, width: height, height: width)
    }

    func allBorders() -> [String] {
        [
            topBorder(),
            String(topBorder().reversed()),
            rightBorder(),
            String(rightBorder().reversed()),
            bottomBorder(),
            String(bottomBorder().reversed()),
            leftBorder(),
            String(leftBorder().reversed()),
        ]
    }

    func topBorder() -> String {
        (0..<width).compactMap { "\(data[Point(x: $0, y: 0)]!)" }.joined()
    }

    func rightBorder() -> String {
        (0..<height).compactMap { "\(data[Point(x: width - 1, y: $0)]!)" }.joined()
    }

    func bottomBorder() -> String {
        (0..<width).compactMap { "\(data[Point(x: $0, y: height - 1)]!)" }.joined()
    }

    func leftBorder() -> String {
        (0..<height).compactMap { "\(data[Point(x: 0, y: $0)]!)" }.joined()
    }
}

extension Tile: Hashable {}

extension Tile: CustomStringConvertible {
    var description: String {
        var lines = [String]()
        for y in 0..<height {
            var line = ""
            for x in 0..<width {
                line += String(data[Point(x: x, y: y), default: "X"])
            }
            lines.append(line)
        }
        return lines.joined(separator: "\n")
    }
}
