import AdventKit
import Foundation

struct HexTile {
    let x: Int
    let y: Int
    let z: Int

    var e: HexTile { HexTile(x: x + 1, y: y - 1, z: z) }
    var se: HexTile { HexTile(x: x + 1, y: y, z: z - 1) }
    var sw: HexTile { HexTile(x: x, y: y + 1, z: z - 1) }
    var w: HexTile { HexTile(x: x - 1, y: y + 1, z: z) }
    var nw: HexTile { HexTile(x: x - 1, y: y, z: z + 1) }
    var ne: HexTile { HexTile(x: x, y: y - 1, z: z + 1) }

    var n6: [HexTile] {
        [e, se, sw, w, nw, ne]
    }
}

extension HexTile: Hashable {}

public class Puzzle {
    let input: [String]
    public init(input: String) {
        self.input = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .trimmingCharacters(in: .newlines)
            .components(separatedBy: .newlines)
    }

    public func part1() -> Int {
        constructGrid().values.filter { $0 }.count
    }

    public func part2() -> Int {
        var grid = constructGrid()

        for _ in 0 ..< 100 {
            var toFlip = [HexTile]()

            // black tiles
            let blackTiles = grid.filter { $0.value }.map { $0.key }
            for tile in blackTiles {
                let neigbours = tile.n6.filter { grid[$0, default: false] }.count
                if neigbours == 0 || neigbours > 2 {
                    toFlip.append(tile)
                }
            }

            // white tiles
            let whiteTiles = Set(blackTiles.flatMap { $0.n6 }.filter { !grid[$0, default: false] })
            for tile in whiteTiles {
                let neigbours = tile.n6.filter { grid[$0, default: false] }.count
                if neigbours == 2 {
                    toFlip.append(tile)
                }
            }

            toFlip.forEach { tile in
                grid[tile, default: false].toggle()
            }
        }

        return grid.values.filter { $0 }.count
    }

    func constructGrid() -> [HexTile: Bool] {
        input
            .reduce(into: [HexTile: Bool]()) { g, i in
                var i = i
                var tile = HexTile(x: 0, y: 0, z: 0)
                while !i.isEmpty {
                    if i.starts(with: "e") {
                        tile = tile.e
                        i = String(i.dropFirst())
                    } else if i.starts(with: "se") {
                        tile = tile.se
                        i = String(i.dropFirst(2))
                    } else if i.starts(with: "sw") {
                        tile = tile.sw
                        i = String(i.dropFirst(2))
                    } else if i.starts(with: "w") {
                        tile = tile.w
                        i = String(i.dropFirst())
                    } else if i.starts(with: "nw") {
                        tile = tile.nw
                        i = String(i.dropFirst(2))
                    } else if i.starts(with: "ne") {
                        tile = tile.ne
                        i = String(i.dropFirst(2))
                    }
                }
                g[tile, default: false].toggle()
            }
    }
}
