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

    static func rotorForInt(_ int: Int) -> RotorKey {
        if int == 1 {
            return .I
        }
        if int == 2 {
            return .II
        }
        if int == 3 {
            return .III
        }
        if int == 4 {
            return .IV
        }
        if int == 5 {
            return .V
        }
        if int == 6 {
            return .VI
        }
        if int == 7 {
            return .VII
        }
        if int == 8 {
            return .VIII
        }
        return .I
    }

    var title: String {
        switch self {
        case .I:
            return "I"
        case .II:
            return "II"
        case .III:
            return "III"
        case .IV:
            return "IV"
        case .V:
            return "V"
        case .VI:
            return "VI"
        case .VII:
            return "VII"
        case .VIII:
            return "VIII"
        }
    }

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

    var next: RotorKey {
        switch self {
        case .I:
            return .II
        case .II:
            return .III
        case .III:
            return .IV
        case .IV:
            return .V
        case .V:
            return .VI
        case .VI:
            return .VII
        case .VII:
            return .VIII
        case .VIII:
            return .I
        }
    }

    var last: RotorKey {
        switch self {
        case .I:
            return .VIII
        case .II:
            return .I
        case .III:
            return .II
        case .IV:
            return .III
        case .V:
            return .IV
        case .VI:
            return .V
        case .VII:
            return .VI
        case .VIII:
            return .VII
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
