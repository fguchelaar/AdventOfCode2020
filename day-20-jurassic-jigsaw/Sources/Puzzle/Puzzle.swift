import AdventKit
import Foundation

public class Puzzle {
    let tiles: [Tile]
    public init(input: String) {
        self.tiles = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: "\n\n")
            .map(Tile.init)
    }

    public func part1() -> Int {
        var corners = [Tile]()

        for outer in 0..<tiles.count {
            let tile = tiles[outer]
            let tileEdges = Set([tile.topBorder(), tile.rightBorder(), tile.bottomBorder(), tile.leftBorder()])

            let otherEdges = Set(tiles.filter { $0.id != tile.id }.flatMap { $0.allBorders() })

            let intersection = tileEdges.intersection(otherEdges)
            if intersection.count == 2 {
                corners.append(tile)
            }
        }
        return corners.map { $0.id }.reduce(1, *)
    }

    public func part2() -> Int {
        var image = [Point: Tile]()
        var tilesLeft = Set(tiles)
        var corners = Set<Tile>()
        var edges = Set<Tile>()

        for outer in 0..<tiles.count {
            let tile = tiles[outer]
            let borders = Set([tile.topBorder(), tile.rightBorder(), tile.bottomBorder(), tile.leftBorder()])

            let otherBorders = Set(tiles.filter { $0.id != tile.id }.flatMap { $0.allBorders() })

            let intersection = borders.intersection(otherBorders)
            if intersection.count == 2 {
                corners.insert(tile)
            } else if intersection.count == 3 {
                edges.insert(tile)
            }
        }

        tilesLeft = tilesLeft.subtracting(corners).subtracting(edges)

        // Get a corner-tile and rotate it so it fits in the top-left position
        let c1 = corners.removeFirst()
        let edgeBorders = Set(edges.flatMap { $0.allBorders() })
        let c1Correct = c1.allOrientations().first { t in
            let borders = Set([t.topBorder(), t.leftBorder()])
            return borders.intersection(edgeBorders).isEmpty
        }!
        image[Point(x: 0, y: 0)] = c1Correct

        // how many tiles per row do we need?
        let tilesPerRow = Int(sqrt(Double(tiles.count)))

        // let's create the outer border first
        // top-row
        for col in 1..<tilesPerRow - 1 {
            let left = image[Point(x: col - 1, y: 0)]
            findEdge: for edge in edges {
                for right in edge.allOrientations() {
                    if left?.rightBorder() == right.leftBorder() {
                        image[Point(x: col, y: 0)] = right
                        edges.remove(edge)
                        break findEdge
                    }
                }
            }
        }

        findCorner: for corner in corners {
            for right in corner.allOrientations() {
                let left = image[Point(x: tilesPerRow - 2, y: 0)]
                if left?.rightBorder() == right.leftBorder() {
                    image[Point(x: tilesPerRow - 1, y: 0)] = right
                    corners.remove(corner)
                    break findCorner
                }
            }
        }

        // left-column
        for row in 1..<tilesPerRow - 1 {
            let top = image[Point(x: 0, y: row - 1)]
            findEdge: for edge in edges {
                for bottom in edge.allOrientations() {
                    if top?.bottomBorder() == bottom.topBorder() {
                        image[Point(x: 0, y: row)] = bottom
                        edges.remove(edge)
                        break findEdge
                    }
                }
            }
        }

        findCorner: for corner in corners {
            for bottom in corner.allOrientations() {
                let top = image[Point(x: 0, y: tilesPerRow - 2)]
                if top?.bottomBorder() == bottom.topBorder() {
                    image[Point(x: 0, y: tilesPerRow - 1)] = bottom
                    corners.remove(corner)
                    break findCorner
                }
            }
        }

        // right-column
        for row in 1..<tilesPerRow - 1 {
            let top = image[Point(x: tilesPerRow - 1, y: row - 1)]
            findEdge: for edge in edges {
                for bottom in edge.allOrientations() {
                    if top?.bottomBorder() == bottom.topBorder() {
                        image[Point(x: tilesPerRow - 1, y: row)] = bottom
                        edges.remove(edge)
                        break findEdge
                    }
                }
            }
        }

        findCorner: for corner in corners {
            for bottom in corner.allOrientations() {
                let top = image[Point(x: tilesPerRow - 1, y: tilesPerRow - 2)]
                if top?.bottomBorder() == bottom.topBorder() {
                    image[Point(x: tilesPerRow - 1, y: tilesPerRow - 1)] = bottom
                    corners.remove(corner)
                    break findCorner
                }
            }
        }

        // bottom-row
        for col in 1..<tilesPerRow - 1 {
            let left = image[Point(x: col - 1, y: tilesPerRow - 1)]
            findEdge: for edge in edges {
                for right in edge.allOrientations() {
                    if left?.rightBorder() == right.leftBorder() {
                        image[Point(x: col, y: tilesPerRow - 1)] = right
                        edges.remove(edge)
                        break findEdge
                    }
                }
            }
        }

        // now, fill in the blanks
        for col in 1..<tilesPerRow - 1 {
            for row in 1..<tilesPerRow - 1 {
                let top = image[Point(x: col, y: row - 1)]!
                let left = image[Point(x: col - 1, y: row)]!

                findTile: for tile in tilesLeft {
                    for rtile in tile.allOrientations() {
                        if left.rightBorder() == rtile.leftBorder(),
                           top.bottomBorder() == rtile.topBorder()
                        {
                            image[Point(x: col, y: row)] = rtile
                            tilesLeft.remove(tile)
                            break findTile
                        }
                    }
                }
            }
        }

        // Next step: merge it into one big image
        var merged = [Point: Character]()
        for row in 0..<tilesPerRow {
            for trow in 1..<9 {
                for col in 0..<tilesPerRow {
                    if let tile = image[Point(x: col, y: row)] {
                        for tcol in 1..<9 {
                            let x = (tcol - 1) + (col * 8)
                            let y = (trow - 1) + (row * 8)
                            let point = Point(x: x, y: y)
                            merged[point] = tile.data[Point(x: tcol, y: trow), default: "x"]
                        }
                    }
                }
            }
        }
        var lines = ["Tile: 1"]
        for y in 0..<(tilesPerRow * 8) {
            var line = ""
            for x in 0..<(tilesPerRow * 8) {
                line += String(merged[Point(x: x, y: y), default: "X"])
            }
            lines.append(line)
        }

        let finalTile = Tile(lines.joined(separator: "\n"))

        func isMonster(at: Point, in image: [Point: Character]) -> Bool {
            let points = [
                Point(x: at.x + 18, y: at.y),
                Point(x: at.x, y: at.y + 1),
                Point(x: at.x + 5, y: at.y + 1),
                Point(x: at.x + 6, y: at.y + 1),
                Point(x: at.x + 11, y: at.y + 1),
                Point(x: at.x + 12, y: at.y + 1),
                Point(x: at.x + 17, y: at.y + 1),
                Point(x: at.x + 18, y: at.y + 1),
                Point(x: at.x + 19, y: at.y + 1),
                Point(x: at.x + 1, y: at.y + 2),
                Point(x: at.x + 4, y: at.y + 2),
                Point(x: at.x + 7, y: at.y + 2),
                Point(x: at.x + 10, y: at.y + 2),
                Point(x: at.x + 13, y: at.y + 2),
                Point(x: at.x + 16, y: at.y + 2),
            ]
            return points.allSatisfy { point in
                image[point, default: "X"] == "#"
            }
        }

        for rot in finalTile.allOrientations() {
            var monsters = 0
            for row in 0..<(tilesPerRow * 8) {
                for col in 0..<(tilesPerRow * 8) {
                    if isMonster(at: Point(x: col, y: row), in: rot.data) {
                        monsters += 1
                    }
                }
            }
            if monsters > 0 {
                return merged
                    .filter { $0.value == "#" }
                    .count - (monsters * 15)
            }
        }
        return -1
    }
}
