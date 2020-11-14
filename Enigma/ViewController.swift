//
//  ViewController.swift
//  Enigma
//
//  Created by Christian Bollig on 07.07.20.
//  Copyright © 2020 SevenPrinciples. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    var id: String?

    @IBOutlet var idLabel: UILabel?
    @IBOutlet var textField: UITextField?
    @IBOutlet var recieverField: UITextField?

    @IBOutlet var rotor1Label: UILabel?
    @IBOutlet var rotor2Label: UILabel?
    @IBOutlet var rotor3Label: UILabel?

    @IBOutlet var rotor1Stepper: UIStepper?
    @IBOutlet var rotor2Stepper: UIStepper?
    @IBOutlet var rotor3Stepper: UIStepper?

    @IBAction func sendAction() {
        guard let msg = textField?.text, let reciever = recieverField?.text, let sender = id else {
            return
        }

        guard let config = Config(rotors: [RotorKey.rotorForInt(Int(rotor1Stepper!.value)),
                                           RotorKey.rotorForInt(Int(rotor2Stepper!.value)),
                                           RotorKey.rotorForInt(Int(rotor3Stepper!.value))], reflector:.UKW_B, setting: [0,0,0]) else {
            return
        }
        let engine = Enigma(withConfig: config)
        let encryptedMSG = engine.encrypt(message: msg)

        RequestAdapter.current.sendMSG(msg: encryptedMSG, sender: sender, reciever: reciever) { (result) in
            switch result {

            case .success((let _, let _)):
                self.textField?.text = ""
            case .failure(let _):
                self.textField?.backgroundColor = UIColor.red
            }
        }
    }

    @IBAction func recieveAction() {
        
    }

    @IBAction func changeRotors() {
        layoutRotors()
    }

    func layoutRotors() {
        rotor1Label?.text = RotorKey.rotorForInt(Int(rotor1Stepper!.value)).title
        rotor2Label?.text = RotorKey.rotorForInt(Int(rotor2Stepper!.value)).title
        rotor3Label?.text = RotorKey.rotorForInt(Int(rotor3Stepper!.value)).title
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getID()

        rotor1Stepper?.value = 1
        rotor2Stepper?.value = 2
        rotor3Stepper?.value = 3

        layoutRotors()
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

    //MARK: -
    //MARK: UIPickerViewDataSource

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 26
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")[row])
    }
}

