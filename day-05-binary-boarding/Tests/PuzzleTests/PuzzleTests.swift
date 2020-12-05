@testable import Puzzle
import XCTest

final class PuzzleTests: XCTestCase {
    func testExample() throws {
        let puzzle = Puzzle(input: """
        BFFFBBFRRR
        FFFBBBFRRR
        BBFFBBFRLL
        """)
        XCTAssertEqual(puzzle.part1(), 820)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
