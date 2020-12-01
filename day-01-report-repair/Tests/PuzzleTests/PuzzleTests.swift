@testable import Puzzle
import XCTest

final class PuzzleTests: XCTestCase {

    func testExample() throws {
        let input = """
            1721
            979
            366
            299
            675
            1456
        """

        let puzzle = Puzzle(input: input)
        XCTAssertEqual(puzzle.part1(), 514579)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
