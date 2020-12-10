import AdventKit
import Foundation

public class Puzzle {
    let adapters: [Int]
    public init(input: String) {
        let adapters = input.intArray.sorted()
        self.adapters = adapters + [adapters.last! + 3]
    }

    public func part1() -> Int {
        let max = adapters.max()!
        let count = adapters.count
        let threeJolts = (max - count) / 2
        return threeJolts * (count - threeJolts)
    }

    func trib(_ n: Int) -> Int {
        n < 1 ? 1
            : n == 1 ? 2
            : n == 2 ? 4
            : trib(n - 1) + trib(n - 2) + trib(n - 3)
    }

    public func part2() -> Int {
        var set = [Int]()

        var count = 0
        var current = 0
        for rating in adapters {
            let diff = rating - current
            if diff == 1 {
                count += 1
            } else if diff == 3 {
                if count > 0 {
                    set.append(count)
                    count = 0
                }
            }
            current = rating
        }

        return set.map { trib($0 - 1) }.reduce(1, *)
    }
}
