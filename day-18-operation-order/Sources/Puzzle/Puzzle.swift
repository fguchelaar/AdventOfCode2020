import AdventKit
import Foundation

public class Puzzle {
    let expressions: [String]
    public init(input: String) {
        expressions = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
    }

    private func calc(_ op1: Int, _ oper: String, _ op2: Int) -> Int {
        switch oper {
        case "+":
            return op1 + op2
        case "-":
            return op1 - op2
        case "*":
            return op1 * op2
        case "/":
            return op1 / op2
        default:
            fatalError()
        }
    }

    private func findMatchingParentheses(in string: String, startIndex: String.Index) -> String.Index {
        var count = 1
        var pos = startIndex
        repeat {
            if string[pos] == "(" {
                count += 1
            } else if string[pos] == ")" {
                count -= 1
            }
            pos = string.index(after: pos)
        } while count > 1
        return pos
    }

    private func eval(_ expression: String) -> Int {
        // create a mutable copy of the provided expression
        var expression = expression

        var waitingOperand: Int?
        var waitingOperator: String?

        var pos = expression.startIndex
        var current = ""

        while pos < expression.endIndex {
            let char = expression[pos]

            if char == "(" { // go and find the matching parentheses
                let endIndex = findMatchingParentheses(in: expression, startIndex: pos)

                // eval the expression within the parentheses
                // then use it as a value for the containing expression
                let start = expression.index(after: pos)
                let end = expression.index(before: endIndex)

                let sub = eval(String(expression[start ..< end]))
                expression.replaceSubrange(pos ..< endIndex, with: String(sub))
            } else {
                if char != " " {
                    current.append(char)
                } else {
                    if let value = Int(current) {
                        if let oper = waitingOperator {
                            waitingOperand = calc(waitingOperand!, oper, value)
                            waitingOperator = nil
                        } else {
                            waitingOperand = value
                        }
                    } else {
                        waitingOperator = current
                    }
                    current = ""
                }
                pos = expression.index(after: pos)
            }
        }
        return calc(waitingOperand!, waitingOperator!, Int(current)!)
    }

    public func part1() -> Int {
        expressions
            .map(eval)
            .reduce(0, +)
    }

    public func part2() -> String {
        ""
    }
}
