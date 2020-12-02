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
}
