@testable import Puzzle
import XCTest

final class PuzzleTests: XCTestCase {
    func testExamples1() throws {
        XCTAssertEqual(Puzzle(input: "1 + 2 * 3 + 4 * 5 + 6").part1(), 71)
        XCTAssertEqual(Puzzle(input: "2 * 3 + (4 * 5)").part1(), 26)
        XCTAssertEqual(Puzzle(input: "5 + (8 * 3 + 9 + 3 * 4 * 3)").part1(), 437)
        XCTAssertEqual(Puzzle(input: "5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))").part1(), 12240)
        XCTAssertEqual(Puzzle(input: "((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2").part1(), 13632)
    }

    func testExamples2() throws {
        XCTAssertEqual(Puzzle(input: "1 + 2 * 3 + 4 * 5 + 6").part2(), 231)
        XCTAssertEqual(Puzzle(input: "1 + (2 * 3) + (4 * (5 + 6))").part2(), 51)
        XCTAssertEqual(Puzzle(input: "2 * 3 + (4 * 5)").part2(), 46)
        XCTAssertEqual(Puzzle(input: "5 + (8 * 3 + 9 + 3 * 4 * 3)").part2(), 1445)
        XCTAssertEqual(Puzzle(input: "5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))").part2(), 669_060)
        XCTAssertEqual(Puzzle(input: "((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2").part2(), 23340)
    }

    static var allTests = [
        ("testExamples1", testExamples1),
        ("testExamples2", testExamples2),
    ]
}
