@testable import Puzzle
import XCTest

final class PuzzleTests: XCTestCase {
    let example = """
    class: 1-3 or 5-7
    row: 6-11 or 33-44
    seat: 13-40 or 45-50

    your ticket:
    7,1,14

    nearby tickets:
    7,3,47
    40,4,50
    55,2,20
    38,6,12
    """

    func testExample() throws {
        let puzzle = Puzzle(input: example)
        XCTAssertEqual(puzzle.part1(), 71)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
