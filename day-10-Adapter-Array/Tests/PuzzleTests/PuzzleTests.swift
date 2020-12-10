@testable import Puzzle
import XCTest

final class PuzzleTests: XCTestCase {
    let example1 = """
    16
    10
    15
    5
    1
    11
    7
    19
    6
    12
    4
    """

    let example2 = """
    28
    33
    18
    42
    31
    14
    46
    20
    48
    47
    24
    23
    49
    45
    19
    38
    39
    11
    1
    32
    25
    35
    8
    17
    7
    9
    4
    2
    34
    10
    3
    """

    func testPart1Example1() throws {
        let puzzle = Puzzle(input: example1)
        XCTAssertEqual(puzzle.part1(), 35)
    }

    func testPart1Example2() throws {
        let puzzle = Puzzle(input: example2)
        XCTAssertEqual(puzzle.part1(), 220)
    }

    func testPart2Example1() throws {
        let puzzle = Puzzle(input: example1)
        XCTAssertEqual(puzzle.part2(), 8)
    }

    func testPart2Example2() throws {
        let puzzle = Puzzle(input: example2)
        XCTAssertEqual(puzzle.part2(), 19208)
    }

    static var allTests = [
        ("testPart1Example1", testPart1Example1),
        ("testPart1Example2", testPart1Example2),
        ("testPart2Example1", testPart2Example1),
        ("testPart2Example2", testPart2Example2),
    ]
}
