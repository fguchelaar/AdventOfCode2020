@testable import Puzzle
import XCTest

final class PuzzleTests: XCTestCase {
    func testExample1() throws {
        let puzzle = Puzzle(input: [0,3,6])
        XCTAssertEqual(puzzle.part1(), 436)
    }

    func testExample2() throws {
        let puzzle = Puzzle(input: [0,3,6])
        XCTAssertEqual(puzzle.part2(), 175594)
    }

    static var allTests = [
        ("testExample", testExample1),
    ]
}
