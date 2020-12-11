@testable import Puzzle
import XCTest

final class PuzzleTests: XCTestCase {
    let example = """
    L.LL.LL.LL
    LLLLLLL.LL
    L.L.L..L..
    LLLL.LL.LL
    L.LL.LL.LL
    L.LLLLL.LL
    ..L.L.....
    LLLLLLLLLL
    L.LLLLLL.L
    L.LLLLL.LL
    """

    func testExample1() throws {
        let puzzle = Puzzle(input: example)
        XCTAssertEqual(puzzle.part1(), 37)
    }

    func testExample2() throws {
        let puzzle = Puzzle(input: example)
        XCTAssertEqual(puzzle.part2(), 26)
    }

    static var allTests = [
        ("testExample1", testExample1),
        ("testExample2", testExample2),
    ]
}
