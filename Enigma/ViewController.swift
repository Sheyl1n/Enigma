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

    var rotor1Setting = 0
    var rotor2Setting = 0
    var rotor3Setting = 0

    @IBAction func copyID() {
        UIPasteboard.general.string = id
    }

    @IBAction func sendAction() {
        guard let msg = textField?.text, msg != "", let reciever = recieverField?.text, reciever != "", let sender = id else {
            return
        }

         RequestAdapter.current.sendMSG(msg: msg, sender: sender, reciever: reciever) { (result) in
            switch result {

            case .success(( _,  _)):
                self.textField?.text = ""
            case .failure( _):
                self.textField?.backgroundColor = UIColor.red
            }
        }
    }

    @IBAction func recieveAction() {
        guard let reciever = id else {
            return
        }
        RequestAdapter.current.getMessage(reciever: reciever) { (result) in
            switch result {

            case .success((let response, let data)):
                print(response)
                guard let object = try? JSONSerialization.jsonObject(with: (data as Data?)!, options: []),
                    let dict = object as? [String: Any] else {
                        return
                }

                self.recieverField?.text = dict["senderId"] as? String
                self.textField?.text = dict["text"] as? String

            case .failure(_):
                self.textField?.backgroundColor = UIColor.red
            }
        }
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

    @IBAction func encrypt() {
        guard let msg = textField?.text, msg != "" else {
            return
        }


        guard let config = Config(rotors: [RotorKey.rotorForInt(Int(rotor1Stepper!.value)),
                                           RotorKey.rotorForInt(Int(rotor2Stepper!.value)),
                                           RotorKey.rotorForInt(Int(rotor3Stepper!.value))], reflector:.UKW_B, setting: [rotor1Setting,rotor2Setting,rotor3Setting]) else {
                                            return
        }
        let engine = Enigma(withConfig: config)
        let encryptedMSG = engine.encrypt(message: msg)

        textField?.text = encryptedMSG
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

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            rotor1Setting = row
        }
        if pickerView.tag == 2 {
            rotor2Setting = row
        }
        if pickerView.tag == 3 {
            rotor3Setting = row
        }
    }
}

