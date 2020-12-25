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
        case "*":
            return op1 * op2
        default:
            fatalError()
        }
    }


    /// Finds the String.Index of the matching closing parentheses, starting at
    /// the provided String.Index
    private func findClosingParentheses(in string: String, startIndex: String.Index) -> String.Index {
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

    /// Finds the String.Index of the matching opening parentheses, starting at
    /// the provided String.Index; going backwards
    private func findOpeningParentheses(in string: String, startIndex: String.Index) -> String.Index {
        var count = 1
        var pos = startIndex
        repeat {
            if string[pos] == ")" {
                count += 1
            } else if string[pos] == "(" {
                count -= 1
            }
            pos = string.index(before: pos)
        } while count > 1 && pos != string.startIndex
        return string.index(after: pos)
    }


    /// Evaluates the provided expression and ignores operator-precedence. When
    /// parentheses are encountered the function is called recursively for that
    /// part.
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
                let endIndex = findClosingParentheses(in: expression, startIndex: pos)

                // eval the expression within the parentheses
                let start = expression.index(after: pos)
                let end = expression.index(before: endIndex)

                // then use it as a value for the containing expression
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
        if waitingOperand != nil, waitingOperator != nil {
            return calc(waitingOperand!, waitingOperator!, Int(current)!)
        } else {
            return Int(current)!
        }
    }

    /// Finds the String.Index of the 'left part' of a sub-expression. When the
    /// left part is in parentheses, find the opening index.
    private func findLeft(_ expression: String, startIndex: String.Index) -> String.Index {
        var pos = expression.index(startIndex, offsetBy: -2)

        while pos > expression.startIndex {
            let char = expression[pos]

            if char == " " || char == "(" {
                return expression.index(after: pos)
            } else if char == ")" {
                return findOpeningParentheses(in: expression, startIndex: pos)
            }

            pos = expression.index(before: pos)
        }
        return pos
    }

    /// Finds the String.Index of the 'right part' of a sub-expression. When the
    /// left part is in parentheses, find the closing index.
    private func findRight(_ expression: String, startIndex: String.Index) -> String.Index {
        var pos = expression.index(startIndex, offsetBy: 2)

        while pos < expression.endIndex {
            let char = expression[pos]

            if char == " " || char == ")" {
                return pos
            } else if char == "(" {
                return findClosingParentheses(in: expression, startIndex: pos)
            }

            pos = expression.index(after: pos)
        }
        return expression.endIndex
    }

    /// To give addition order of precedence over multiplication, this function
    /// puts all addition-expressions in parentheses.
    private func prepare(_ expression: String) -> String {
        // create a mutable copy of the provided expression
        var expression = expression

        var pos = expression.endIndex

        while pos > expression.startIndex {
            pos = expression.index(before: pos)
            let char = expression[pos]

            if char == "+" {
                let right = findRight(expression, startIndex: pos)
                expression.insert(")", at: right)
                let left = findLeft(expression, startIndex: pos)
                expression.insert("(", at: left)
            }
        }
        return expression
    }

    public func part1() -> Int {
        expressions
            .map(eval)
            .reduce(0, +)
    }

    public func part2() -> Int {
        expressions
            .map(prepare)
            .map(eval)
            .reduce(0, +)
    }
}
