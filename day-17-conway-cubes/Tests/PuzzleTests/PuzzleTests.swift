@testable import Puzzle
import XCTest

final class PuzzleTests: XCTestCase {
    func testExample1() throws {
        let puzzle = Puzzle(input: """
        .#.
        ..#
        ###
        """)
        XCTAssertEqual(puzzle.part1(), 112)
    }

    func testExample2() throws {
        let puzzle = Puzzle(input: """
        .#.
        ..#
        ###
        """)
        XCTAssertEqual(puzzle.part2(), 848)
    }

    static var allTests = [
        ("testExample1", testExample1),
        ("testExample2", testExample2),
    ]
}
