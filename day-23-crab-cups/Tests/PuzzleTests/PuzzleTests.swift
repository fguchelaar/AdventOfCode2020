@testable import Puzzle
import XCTest

final class PuzzleTests: XCTestCase {
    let input = "389125467"

    func testPart1() throws {
        let puzzle = Puzzle(input: input)
        XCTAssertEqual(puzzle.part1(), "67384529")
    }

    func testPart2() throws {
        let puzzle = Puzzle(input: input)
        XCTAssertEqual(puzzle.part2(), 149245887792)
    }
}
