//
//  Enigma.swift
//  Enigma
//
//  Created by Christian Bollig on 13.11.20.
//  Copyright © 2020 SevenPrinciples. All rights reserved.
//

import UIKit

class Enigma: NSObject {

    let rotors: [Rotor]
    let reflector: Rotor

    init(withConfig config: Config) {

        var i: Int = 0
        var tempRotors: [Rotor] = []
        while i < config.rotors.count {
            tempRotors.append(Rotor(replacement: config.rotors[i].replacement, index: config.setting[i], steps: config.rotors[i].stepKeys))
            i += 1
        }

        rotors = tempRotors
        reflector = Rotor(replacement: config.reflector.replacement, index: 0, steps: "")
    }

    func sanitiseString(string: String) -> String {
        let returnValue = string.uppercased()
        let alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ "
        return returnValue.filter(alphabet.contains)
    }

    func encrypt(message: String) -> String {
        print("Encrypting Message: \(message)")
        let sanitisedString = sanitiseString(string: message)
        var encryptedString = ""
        for letter in Array(sanitisedString) {
            //Skip blanks for better usability
            if letter == " " {
                encryptedString.append(letter)
            } else {

                print("Encrypting letter: \(letter)")
                step()
                var encryptedLetter = letter
                for rotor in rotors {
                    encryptedLetter = rotor.wayIn(letter: encryptedLetter)
                }

                encryptedLetter = reflector.wayIn(letter: encryptedLetter)

                for rotor in rotors.reversed() {
                    encryptedLetter = rotor.wayOut(letter: encryptedLetter)
                }
                encryptedString.append(encryptedLetter)
                print("Encrypted letter: \(encryptedLetter)")
                print("===========================================")
            }
        }
        print("Encrypted Result: \(encryptedString)")
        return encryptedString
    }

    func step() {
        for rotor in rotors {
            if !rotor.step() {
                print("Rotor\(rotor) will not turn next")
                break
            }
            print("Rotor\(rotor) will turn next")
        }
    }
}
