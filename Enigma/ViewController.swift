//
//  ViewController.swift
//  Enigma
//
//  Created by Christian Bollig on 07.07.20.
//  Copyright © 2020 SevenPrinciples. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var idLabel: UILabel?
    @IBOutlet var textField: UITextField?
    @IBOutlet var recieverField: UITextField?

    @IBAction func sendAction() {
        guard let msg = textField?.text, let reciever = recieverField?.text, let sender = id else {
            return
        }

        guard let config = Config(rotors: [.I,.II,.III], reflector:.UKW_B, setting: [0,0,0]) else {
            return
        }
        let engine = Enigma(withConfig: config)
        let encryptedMSG = engine.encrypt(message: msg)

        RequestAdapter.current.sendMSG(msg: encryptedMSG, sender: sender, reciever: reciever) { (result) in
            switch result {

            case .success((let response, let data)):
                self.textField?.text = ""
            case .failure(let error):
                self.textField?.backgroundColor = UIColor.red
            }
        }
    }

    @IBAction func recieveAction() {
        
    }

    var id: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        getID()
    }

    func getID() {
        RequestAdapter.current.getID { (result) in
            switch result {

            case .success((let response, let data)):
                print(response)
                guard let object = try? JSONSerialization.jsonObject(with: (data as Data?)!, options: []),
                    let dict = object as? [String: Any] else {
                        return
                }

                self.id = dict["id"] as? String
                self.idLabel?.text = "ID: \(self.id ?? "Failed")"

            case .failure(let error):
                print(error)
            }
        }
    }

}

