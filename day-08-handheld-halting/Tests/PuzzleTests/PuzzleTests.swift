@testable import Puzzle
import XCTest

final class PuzzleTests: XCTestCase {
    func testExample1() throws {
        let puzzle = Puzzle(input: """
        nop +0
        acc +1
        jmp +4
        acc +3
        jmp -3
        acc -99
        acc +1
        jmp -4
        acc +6
        """)
        XCTAssertEqual(puzzle.part1(), 5)
    }

    func testExample2() throws {
        let puzzle = Puzzle(input: """
        nop +0
        acc +1
        jmp +4
        acc +3
        jmp -3
        acc -99
        acc +1
        jmp -4
        acc +6
        """)
        XCTAssertEqual(puzzle.part2(), 8)
    }

    static var allTests = [
        ("testExample1", testExample1),
        ("testExample2", testExample2),
    ]
}
