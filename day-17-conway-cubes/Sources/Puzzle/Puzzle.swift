import AdventKit
import Foundation

struct Point3d: Hashable {
    var x, y, z: Int

    var n26: [Point3d] {
        // quick and dirty imperative style
        var neighbors = [Point3d]()
        (x - 1 ... x + 1).forEach { x in
            (y - 1 ... y + 1).forEach { y in
                (z - 1 ... z + 1).forEach { z in
                    if x != self.x || y != self.y || z != self.z {
                        neighbors.append(Point3d(x: x, y: y, z: z))
                    }
                }
            }
        }
        return neighbors
    }
}

struct Point4d: Hashable {
    var x, y, z, w: Int

    var n80: [Point4d] {
        // quick and dirty imperative style
        var neighbors = [Point4d]()
        (x - 1 ... x + 1).forEach { x in
            (y - 1 ... y + 1).forEach { y in
                (z - 1 ... z + 1).forEach { z in
                    (w - 1 ... w + 1).forEach { w in
                        if x != self.x || y != self.y || z != self.z || w != self.w {
                            neighbors.append(Point4d(x: x, y: y, z: z, w: w))
                        }
                    }
                }
            }
        }
        return neighbors
    }
}

public class Puzzle {
    let space3d: Set<Point3d>
    let space4d: Set<Point4d>
    public init(input: String) {
        // quick and dirty imperative style
        let rows = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)

        var space3d = Set<Point3d>()
        var space4d = Set<Point4d>()
        (0 ..< rows.count).forEach { row in
            (0 ..< rows[row].count).forEach { col in
                if rows[row][col] == "#" {
                    space3d.insert(Point3d(x: col, y: row, z: 0))
                    space4d.insert(Point4d(x: col, y: row, z: 0, w: 0))
                }
            }
        }
        self.space3d = space3d
        self.space4d = space4d
    }

    public func part1() -> Int {
        func minmax(space: Set<Point3d>) -> (min: Point3d, max: Point3d) {
            var minx = 0, miny = 0, minz = 0, maxx = 0, maxy = 0, maxz = 0

            space.forEach { p in
                minx = min(minx, p.x)
                miny = min(miny, p.y)
                minz = min(minz, p.z)
                maxx = max(maxx, p.x)
                maxy = max(maxy, p.y)
                maxz = max(maxz, p.z)
            }

            return (Point3d(x: minx, y: miny, z: minz), Point3d(x: maxx, y: maxy, z: maxz))
        }

        var space = space3d

        // perform 6 cycles
        (0 ..< 6).forEach { _ in
            var temp = space
            let bounds = minmax(space: space)
            (bounds.min.x - 1 ... bounds.max.x + 1).forEach { x in
                (bounds.min.y - 1 ... bounds.max.y + 1).forEach { y in
                    (bounds.min.z - 1 ... bounds.max.z + 1).forEach { z in
                        let p = Point3d(x: x, y: y, z: z)
                        let isActive = space.contains(p)

                        let n_count = p.n26.filter { space.contains($0) }.count

                        if isActive, !(n_count == 2 || n_count == 3) {
                            temp.remove(p)
                        } else if !isActive, n_count == 3 {
                            temp.insert(p)
                        }
                    }
                }
            }
            space = temp
        }
        return space.count
    }

    public func part2() -> Int {
        func minmax(space: Set<Point4d>) -> (min: Point4d, max: Point4d) {
            var minx = 0, miny = 0, minz = 0, minw = 0, maxx = 0, maxy = 0, maxz = 0, maxw = 0

            space.forEach { p in
                minx = min(minx, p.x)
                miny = min(miny, p.y)
                minz = min(minz, p.z)
                minw = min(minw, p.w)
                maxx = max(maxx, p.x)
                maxy = max(maxy, p.y)
                maxz = max(maxz, p.z)
                maxw = max(maxw, p.w)
            }

            return (Point4d(x: minx, y: miny, z: minz, w: minw), Point4d(x: maxx, y: maxy, z: maxz, w: maxw))
        }

        var space4d = self.space4d

        // perform 6 cycles
        (0 ..< 6).forEach { _ in
            var temp = space4d
            let bounds = minmax(space: space4d)
            (bounds.min.x - 1 ... bounds.max.x + 1).forEach { x in
                (bounds.min.y - 1 ... bounds.max.y + 1).forEach { y in
                    (bounds.min.z - 1 ... bounds.max.z + 1).forEach { z in
                        (bounds.min.w - 1 ... bounds.max.w + 1).forEach { w in
                            let p = Point4d(x: x, y: y, z: z, w: w)
                            let isActive = space4d.contains(p)

                            let n_count = p.n80.filter { space4d.contains($0) }.count

                            if isActive, !(n_count == 2 || n_count == 3) {
                                temp.remove(p)
                            } else if !isActive, n_count == 3 {
                                temp.insert(p)
                            }
                        }
                    }
                }
            }
            space4d = temp
        }
        return space4d.count
    }
}
