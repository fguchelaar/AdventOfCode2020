//
//  File.swift
//
//
//  Created by Frank Guchelaar on 02/12/2020.
//

import Foundation

public extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }

    func padLeft(toLength: Int, withPad character: Character) -> String {
        let stringLength = count
        if stringLength < toLength {
            return String(repeatElement(character, count: toLength - stringLength)) + self
        } else {
            return String(suffix(toLength))
        }
    }
}
