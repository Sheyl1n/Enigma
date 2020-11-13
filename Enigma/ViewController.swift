//
//  ViewController.swift
//  Enigma
//
//  Created by Christian Bollig on 07.07.20.
//  Copyright © 2020 SevenPrinciples. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let config = Config(rotors: [.I,.II,.III], reflector:.UKW_B, setting: [0,0,0]) else {
            return
        }
        let engine = Enigma(withConfig: config)
        print(engine.encrypt(message: "Hello World"))
    }


}

