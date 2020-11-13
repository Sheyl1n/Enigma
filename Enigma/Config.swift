//
//  Config.swift
//  Enigma
//
//  Created by Christian Bollig on 13.11.20.
//  Copyright © 2020 SevenPrinciples. All rights reserved.
//

import UIKit

enum ReflectorKey {
    case UKW_B
    case UKW_C

    var replacement: String {
        switch self {

        case .UKW_B:
            return "YRUHQSLDPXNGOKMIEBFZCWVJAT"
        case .UKW_C:
            return "FVPJIAOYEDRZXWGCTKUQSBNMHL"
        }
    }
}

enum RotorKey {
    case I
    case II
    case III
    case IV
    case V
    case VI
    case VII
    case VIII

    var replacement: String {
        switch self {
        case .I:
            return "EKMFLGDQVZNTOWYHXUSPAIBRCJ"
        case .II:
            return "AJDKSIRUXBLHWTMCQGZNPYFVOE"
        case .III:
            return "BDFHJLCPRTXVZNYEIWGAKMUSQO"
        case .IV:
            return "ESOVPZJAYQUIRHXLNFTGKDCMWB"
        case .V:
            return "VZBRGITYUPSDNHLXAWMJQOFECK"
        case .VI:
            return "JPGVOUMFYQBENHZRDKASXLICTW"
        case .VII:
            return "NZJHGRCXMYSWBOUFAIVLPEKQDT"
        case .VIII:
            return "FKQHTLXOCBJSPDZRAMEWNIUYGV"
        }
    }

    //Der Übertrag erfolgt, wenn diese Walze sich von dem genannten Buchstaben auf den nächsten fortdreht
    var stepKeys: String {
        switch self {
        case .I:
            return "Q"
        case .II:
            return "E"
        case .III:
            return "V"
        case .IV:
            return "J"
        case .V:
            return "Z"
        case .VI:
            return "ZM"
        case .VII:
            return "ZM"
        case .VIII:
            return "ZM"
        }
    }
}

class Config: NSObject {

    let rotors: [RotorKey]
    let setting: [Int]
    let reflector: ReflectorKey

    init?(rotors: [RotorKey], reflector: ReflectorKey, setting: [Int]) {
        if rotors.count != setting.count || rotors.isEmpty {
            return nil
        }

        self.rotors = rotors
        self.setting = setting
        self.reflector = reflector
    }
}
