@testable import Puzzle
import XCTest

final class PuzzleTests: XCTestCase {
    let testInput = """
    1-3 a: abcde
    1-3 b: cdefg
    2-9 c: ccccccccc
    """

    func testPart1() throws {
        let puzzle = Puzzle(input: testInput)
        XCTAssertEqual(puzzle.part1(), 2)
    }

    func testPart2() throws {
        let puzzle = Puzzle(input: testInput)
        XCTAssertEqual(puzzle.part2(), 1)
    }

    static var allTests = [
        ("testPart1", testPart1),
        ("testPart2", testPart2),
    ]
}
