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

    func sanitiseIndex(_ index: Int) -> Int {
        var returnIndex = index % alphabet.count
        if index < 0 {
            returnIndex = index + alphabet.count
        }
        return returnIndex
    }

    func wayIn(letter: Character) -> Character {
        print("Incoming Letter: \(letter)")
        let alphabetIndex = sanitiseIndex((getAlphabetIndex(letter: letter)! + index))
        let normalizedIncomingLetter = Array(alphabet)[alphabetIndex]
        print("Normalized Incoming Letter: \(normalizedIncomingLetter)")
        let transformedLetter = Array(replacement)[alphabetIndex]
        print("Transformed Letter: \(transformedLetter)")
        let transformedIndex = sanitiseIndex((getAlphabetIndex(letter: transformedLetter)! - index))
        let normalizedOutgoingLetter = Array(alphabet)[transformedIndex]
        print("Normalized Outgoing Letter: \(normalizedOutgoingLetter)")
        print("===========================================")
       return normalizedOutgoingLetter
    }
    
    func wayOut(letter: Character) -> Character {
        print("Incoming Letter: \(letter)")
        let alphabetIndex = sanitiseIndex((getAlphabetIndex(letter: letter)! + index))
        let normalizedIncomingLetter = Array(alphabet)[alphabetIndex]
        print("Normalized Incoming Letter: \(normalizedIncomingLetter)")
        let replacementIndex = sanitiseIndex(getReplacementIndex(letter: normalizedIncomingLetter)!)
        let transformedLetter = Array(alphabet)[replacementIndex]
        print("Transformed Letter: \(transformedLetter)")
        let transformedIndex = sanitiseIndex((getAlphabetIndex(letter: transformedLetter)! - index))
        let normalizedOutgoingLetter = Array(alphabet)[transformedIndex]
        print("Normalized Outgoing Letter: \(normalizedOutgoingLetter)")
        print("===========================================")
        return normalizedOutgoingLetter
    }

    func step() -> Bool {
        index += 1
        return steps.contains(Array(alphabet)[index-1])
    }
}
