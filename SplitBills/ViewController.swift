//
//  ViewController.swift
//  SplitBills
//
//  Created by Anthony Tse on 1/12/19.
//  Copyright © 2019 Anthony Tse. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: properties
    @IBOutlet weak var billCost: UITextField!
    @IBOutlet weak var billDate: UITextField!
    @IBOutlet weak var billPayer: UITextField!
    @IBOutlet weak var billDescription: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        billCost.delegate = self
        billPayer.delegate = self
        billDescription.delegate = self
        
    }
    
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if billCost.isFirstResponder {
            billCost.text = textField.text
        } else if billDate.isFirstResponder {
            billDate.text = textField.text
        } else if billPayer.isFirstResponder {
            billPayer.text = textField.text
        } else if billDescription.isFirstResponder {
            billDescription.text = textField.text
        }
    }
    
    //MARK: Actions
    @IBAction func setCurrentDate(_ sender: UIButton) {
        
        billDate.text = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .none)
    }
    
    
}
