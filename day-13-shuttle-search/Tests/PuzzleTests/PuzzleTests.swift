@testable import Puzzle
import XCTest

final class PuzzleTests: XCTestCase {
    let example = """
    939
    7,13,x,x,59,x,31,19
    """

    func testExample1() throws {
        let puzzle = Puzzle(input: example)
        XCTAssertEqual(puzzle.part1(), 295)
    }

    func testExample2_a() throws {
        let puzzle = Puzzle(input: example)
        XCTAssertEqual(puzzle.part2(), 1_068_781)
    }

    func testExample2_b() throws {
        let puzzle = Puzzle(input: """
        1
        17,x,13,19
        """)
        XCTAssertEqual(puzzle.part2(), 3417)
    }

    func testExample2_c() throws {
        let puzzle = Puzzle(input: """
        1
        67,7,59,61
        """)
        XCTAssertEqual(puzzle.part2(), 754_018)
    }

    func testExample2_d() throws {
        let puzzle = Puzzle(input: """
        1
        67,x,7,59,61
        """)
        XCTAssertEqual(puzzle.part2(), 779_210)
    }

    func testExample2_e() throws {
        let puzzle = Puzzle(input: """
        1
        67,7,x,59,61
        """)
        XCTAssertEqual(puzzle.part2(), 1_261_476)
    }

    func testExample2_f() throws {
        let puzzle = Puzzle(input: """
        1
        1789,37,47,1889
        """)
        XCTAssertEqual(puzzle.part2(), 1_202_161_486)
    }

    static var allTests = [
        ("testExample1", testExample1),
        ("testExample2_a", testExample2_a),
        ("testExample2_b", testExample2_b),
        ("testExample2_c", testExample2_c),
        ("testExample2_d", testExample2_d),
        ("testExample2_e", testExample2_e),
        ("testExample2_f", testExample2_f),
    ]
}
