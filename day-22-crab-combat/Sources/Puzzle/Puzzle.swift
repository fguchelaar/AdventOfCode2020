
import AdventKit
import Foundation

public class Puzzle {
    let player1Cards: [Int]
    let player2Cards: [Int]

    public init(input: String) {
        let decks = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: "\n\n")

        player1Cards = decks[0].components(separatedBy: .newlines).dropFirst().compactMap(Int.init)
        player2Cards = decks[1].components(separatedBy: .newlines).dropFirst().compactMap(Int.init)
    }

    public func part1() -> Int {
        var deck1 = player1Cards.reduce(into: Queue()) { $0.enqueue($1) }
        var deck2 = player2Cards.reduce(into: Queue()) { $0.enqueue($1) }

        while !deck1.isEmpty, !deck2.isEmpty {
            let c1 = deck1.dequeue()!
            let c2 = deck2.dequeue()!
            if c1 > c2 {
                deck1.enqueue(c1)
                deck1.enqueue(c2)
            } else {
                deck2.enqueue(c2)
                deck2.enqueue(c1)
            }
        }
        var winner = deck1.isEmpty ? deck2 : deck1

        return stride(from: winner.count, to: 0, by: -1).reduce(0) {
            $0 + $1 * winner.dequeue()!
        }
    }

    public func part2() -> Int {
        let result = play(deck1: player1Cards, deck2: player2Cards)

        let winner = result.deck1.isEmpty ? result.deck2 : result.deck1
        return winner.reversed().enumerated().reduce(0) {
            $0 + ($1.offset + 1) * $1.element
        }
    }

    func play(deck1: [Int], deck2: [Int]) -> (deck1: [Int], deck2: [Int]) {
        var deck1 = deck1
        var deck2 = deck2
        var deck1History = Set<[Int]>()
        var deck2History = Set<[Int]>()

        while !deck1.isEmpty, !deck2.isEmpty {
            guard deck1History.insert(deck1).inserted || deck2History.insert(deck2).inserted
            else {
                return ([1], [])
            }

            let c1 = deck1.removeFirst()
            let c2 = deck2.removeFirst()

            if c1 <= deck1.count, c2 <= deck2.count {
                let subgame = play(deck1: Array(deck1.prefix(c1)), deck2: Array(deck2.prefix(c2)))
                if subgame.deck1.count >= subgame.deck2.count {
                    deck1.append(c1)
                    deck1.append(c2)
                } else {
                    deck2.append(c2)
                    deck2.append(c1)
                }
            } else {
                if c1 > c2 {
                    deck1.append(c1)
                    deck1.append(c2)
                } else {
                    deck2.append(c2)
                    deck2.append(c1)
                }
            }
        }
        return (deck1, deck2)
    }
}
