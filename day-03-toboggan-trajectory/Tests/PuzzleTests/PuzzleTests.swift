@testable import Puzzle
import XCTest

final class PuzzleTests: XCTestCase {
    let example = """
    ..##.......
    #...#...#..
    .#....#..#.
    ..#.#...#.#
    .#...##..#.
    ..#.##.....
    .#.#.#....#
    .#........#
    #.##...#...
    #...##....#
    .#..#...#.#
    """

    func testExample1() throws {
        let puzzle = Puzzle(input: example)
        XCTAssertEqual(puzzle.part1(), 7)
    }

    func testExample2() throws {
        let puzzle = Puzzle(input: example)
        XCTAssertEqual(puzzle.part2(), 336)
    }

    static var allTests = [
        ("testExample1", testExample1),
        ("testExample2", testExample2),
    ]
}
