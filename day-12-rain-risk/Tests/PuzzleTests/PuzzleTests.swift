@testable import Puzzle
import XCTest

final class PuzzleTests: XCTestCase {
    let example = """
    F10
    N3
    F7
    R90
    F11
    """

    func testExample1() throws {
        let puzzle = Puzzle(input: example)
        XCTAssertEqual(puzzle.part1(), 25)
    }

    func testExample2() throws {
        let puzzle = Puzzle(input: example)
        XCTAssertEqual(puzzle.part2(), 286)
    }

    static var allTests = [
        ("testExample1", testExample1),
        ("testExample2", testExample2),
    ]
}
