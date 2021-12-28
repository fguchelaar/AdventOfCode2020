@testable import Puzzle
import XCTest

final class PuzzleTests: XCTestCase {

    let input = """
    mxmxvkd kfcds sqjhc nhms (contains dairy, fish)
    trh fvjkl sbzzf mxmxvkd (contains dairy)
    sqjhc fvjkl (contains soy)
    sqjhc mxmxvkd sbzzf (contains fish)
    """

    func testPart1() throws {
        let puzzle = Puzzle(input: input)
        XCTAssertEqual(puzzle.part1(), 5)
    }

    func testPart2() throws {
        let puzzle = Puzzle(input: input)
        XCTAssertEqual(puzzle.part2(), "mxmxvkd,sqjhc,fvjkl")
    }
}
