@testable import Puzzle
import XCTest

final class PuzzleTests: XCTestCase {
    func testExample() throws {
        let puzzle = Puzzle(input: "")
        XCTAssertEqual(puzzle.part1(), "")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
