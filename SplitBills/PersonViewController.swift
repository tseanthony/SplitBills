//
//  PersonViewController.swift
//  SplitBills
//
//  Created by Anthony Tse on 1/14/19.
//  Copyright © 2019 Anthony Tse. All rights reserved.
//

import UIKit

class PersonViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var personName: UITextField!
    @IBOutlet weak var personPhoneNumber: UITextField!
    @IBOutlet weak var personEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        personName.delegate = self
        personPhoneNumber.delegate = self
        personEmail.delegate = self
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if personName.isFirstResponder {
            personName.text = textField.text
        } else if personPhoneNumber.isFirstResponder {
            personPhoneNumber.text = textField.text
        } else if personEmail.isFirstResponder {
            personEmail.text = textField.text
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
