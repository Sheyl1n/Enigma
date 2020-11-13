//
//  Rotor.swift
//  Enigma
//
//  Created by Christian Bollig on 13.11.20.
//  Copyright © 2020 SevenPrinciples. All rights reserved.
//

import UIKit

class Rotor: NSObject {

    let alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

    let replacement: String
    let steps: String
    var index: Int

    init(replacement: String, index: Int, steps: String) {
        self.replacement = replacement
        self.index = index
        self.steps = steps
    }

    func getAlphabetIndex(letter: Character) -> Int? {
        return alphabet.indexInt(of: letter)
    }

    func getReplacementIndex(letter: Character) -> Int? {
        return replacement.indexInt(of: letter)
    }

    func wayIn(letter: Character) -> Character {
        let alphabetIndex = getAlphabetIndex(letter: letter)!
        return Array(replacement)[alphabetIndex]
    }
    
    func wayOut(letter: Character) -> Character {
        let replacementIndex = getReplacementIndex(letter: letter)!
        return Array(alphabet)[replacementIndex]
    }
}
