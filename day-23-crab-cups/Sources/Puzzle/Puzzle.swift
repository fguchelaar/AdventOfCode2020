import AdventKit
import Foundation

class Cup {
    let label: Int

    var next: Cup!

    init(_ label: Character) {
        self.label = Int("\(label)")!
        next = self
    }

    init(_ label: Int) {
        self.label = label
        next = self
    }
}

extension Cup: Equatable {
    static func == (lhs: Cup, rhs: Cup) -> Bool {
        lhs.label == rhs.label
    }
}

public class Puzzle {
    let input: String
    public init(input: String) {
        self.input = input.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    public func part1() -> String {
        let head = Cup(input[0])
        var current = head
        for i in 1 ..< input.count {
            let cup = Cup(input[i])
            cup.next = head
            current.next = cup
            current = cup
        }
        current = head

        for _ in 0 ..< 100 {
            let t1 = current.next!
            let t2 = t1.next!
            let t3 = t2.next!

            current.next = t3.next

            var label = current.label == 1 ? 9 : current.label - 1
            while label == t1.label || label == t2.label || label == t3.label {
                label = label == 1 ? 9 : label - 1
            }
            var destination = current.next!
            while destination.label != label {
                destination = destination.next!
            }
            t3.next = destination.next
            destination.next = t1

            current = current.next
        }

        var oneCup = current
        while oneCup.label != 1 {
            oneCup = oneCup.next
        }

        current = oneCup.next
        var output = [Int]()
        repeat {
            output.append(current.label)
            current = current.next
        } while current != oneCup

        return output.map(String.init).joined()
    }

    public func part2() -> Int {
        var map = [Int: Int]()

        for i in 0 ..< input.count - 1 {
            let cup = Int(String(input[i]))!
            let next = Int(String(input[i + 1]))!
            map[cup] = next
        }
        map[Int(String(input.last!))!] = 10

        let max = 1_000_000

        for i in 10 ..< max {
            map[i] = i + 1
        }
        map[max] = Int(String(input.first!))!

        var current = Int(String(input.first!))!
        for _ in 0 ..< 10_000_000 {
            let t1 = map[current]!
            let t2 = map[t1]!
            let t3 = map[t2]!

            var destination = current == 1 ? map.count : current - 1
            while [t1, t2, t3].contains(destination) {
                destination = destination == 1 ? map.count : destination - 1
            }
            map[current] = map[t3]!
            current = map[current]!

            map[t3] = map[destination]!
            map[destination] = t1
        }

        let t1 = map[1]!
        let t2 = map[t1]!

        return t1 * t2
    }
}
