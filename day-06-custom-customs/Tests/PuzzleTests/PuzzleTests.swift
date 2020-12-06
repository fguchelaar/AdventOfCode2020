@testable import Puzzle
import XCTest

final class PuzzleTests: XCTestCase {
    let example = """
    abc

    a
    b
    c

    ab
    ac

    a
    a
    a
    a

    b
    """

    func testExample1() throws {
        let puzzle = Puzzle(input: example)
        XCTAssertEqual(puzzle.part1(), 11)
    }

    func testExample2() throws {
        let puzzle = Puzzle(input: example)
        XCTAssertEqual(puzzle.part2(), 6)
    }

    static var allTests = [
        ("testExample1", testExample1),
        ("testExample2", testExample2),
    ]
}
