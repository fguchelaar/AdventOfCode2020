@testable import Puzzle
import XCTest

final class PuzzleTests: XCTestCase {
    let example1 = """
    mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
    mem[8] = 11
    mem[7] = 101
    mem[8] = 0
    """

    let example2 = """
    mask = 000000000000000000000000000000X1001X
    mem[42] = 100
    mask = 00000000000000000000000000000000X0XX
    mem[26] = 1
    """

    func testExample1() throws {
        let puzzle = Puzzle(input: example1)
        XCTAssertEqual(puzzle.part1(), 165)
    }

    func testExample2() throws {
        let puzzle = Puzzle(input: example2)
        XCTAssertEqual(puzzle.part2(), 208)
    }

    static var allTests = [
        ("testExample1", testExample1),
        ("testExample2", testExample2),
    ]
}
