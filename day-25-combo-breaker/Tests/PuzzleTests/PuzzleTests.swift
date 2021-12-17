@testable import Puzzle
import XCTest

final class PuzzleTests: XCTestCase {
    let input = """
    5764801
    17807724
    """

    func testPart1() throws {
        let puzzle = Puzzle(input: input)
        XCTAssertEqual(puzzle.part1(), 14897079)
    }
}
