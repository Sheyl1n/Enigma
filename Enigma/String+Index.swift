//
//  String+Index.swift
//  Enigma
//
//  Created by Christian Bollig on 13.11.20.
//  Copyright © 2020 SevenPrinciples. All rights reserved.
//

import Foundation

public extension String {
    func indexInt(of char: Character) -> Int? {
        return firstIndex(of: char)?.utf16Offset(in: self)
    }
}
