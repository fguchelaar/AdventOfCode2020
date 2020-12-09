@testable import Puzzle
import XCTest

final class PuzzleTests: XCTestCase {
    let example = """
    35
    20
    15
    25
    47
    40
    62
    55
    65
    95
    102
    117
    150
    182
    127
    219
    299
    277
    309
    576
    """

    func testExample1() throws {
        let puzzle = Puzzle(input: example)
        puzzle.preambleLength = 5
        XCTAssertEqual(puzzle.part1(), 127)
    }

    func testExample2() throws {
        let puzzle = Puzzle(input: example)
        puzzle.preambleLength = 5
        XCTAssertEqual(puzzle.part2(), 62)
    }

    static var allTests = [
        ("testExample1", testExample1),
        ("testExample2", testExample2),
    ]
}
