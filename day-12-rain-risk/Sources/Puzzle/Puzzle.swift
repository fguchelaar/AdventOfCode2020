import AdventKit
import Foundation

class Ship {
    static let headings = ["E", "S", "W", "N"]
    var heading = 0

    var x = 0, y = 0

    func handle(instruction: String) {
        let action = instruction[0]
        let value = Int(instruction.dropFirst())!
        switch action {
        case "N":
            y += value
        case "S":
            y -= value
        case "E":
            x += value
        case "W":
            x -= value
        case "L":
            heading = (heading - (value / 90) + 4) % 4
        case "R":
            heading = (heading + (value / 90)) % 4
        case "F":
            handle(instruction: "\(Ship.headings[heading])\(value)")
        default:
            fatalError()
        }
    }

    var wx = 10
    var wy = 1

    func handle2(instruction: String) {
        let action = instruction[0]
        let value = Int(instruction.dropFirst())!
        switch action {
        case "N":
            wy += value
        case "S":
            wy -= value
        case "E":
            wx += value
        case "W":
            wx -= value
        case "L":
            for _ in 0 ..< (value / 90) {
                let tx = wx
                wx = -wy
                wy = tx
            }
        case "R":
            for _ in 0 ..< (value / 90) {
                let tx = wx
                wx = wy
                wy = -tx
            }
        case "F":
            x = x + value * wx
            y = y + value * wy
        default:
            fatalError()
        }
    }
}

public class Puzzle {
    let input: [String]
    public init(input: String) {
        self.input = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
    }

    public func part1() -> Int {
        let ship = Ship()
        input.forEach { ship.handle(instruction: $0) }
        return abs(ship.x) + abs(ship.y)
    }

    public func part2() -> Int {
        let ship = Ship()
        input.forEach { ship.handle2(instruction: $0) }
        return abs(ship.x) + abs(ship.y)
    }
}
