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
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        billCost.delegate = self
        billPayer.delegate = self
        billDescription.delegate = self
        billDate.delegate = self
        
        // Set up UIDatePicker for billDate (Programmatically)
        self.datePicker.datePickerMode = .date
      
        // Set up UIToolBar for billDate (Programmatically)
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(ViewController.cancelClick))
        let currentButton = UIBarButtonItem(title: "Today", style: .plain, target: self, action: #selector(ViewController.todayClick))
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(ViewController.doneClick))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([cancelButton, spacer, currentButton, spacer, doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        billDate.inputView = datePicker
        billDate.inputAccessoryView = toolbar
    }
    
    @objc func cancelClick() {
        billDate.resignFirstResponder()
    }
    
    @objc func todayClick() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        billDate.text = dateFormatter.string(from: Date())
        view.endEditing(true)
        
        billDate.resignFirstResponder()
    }
    
    @objc func doneClick() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        billDate.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(true)
        
        billDate.resignFirstResponder()
    }
    
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if billCost.isFirstResponder {
            billCost.text = textField.text
        } else if billPayer.isFirstResponder {
            billPayer.text = textField.text
        } else if billDescription.isFirstResponder {
            billDescription.text = textField.text
        }
    }
    
    //MARK: Actions
    
    //This Button is redundant
    @IBAction func setCurrentDate(_ sender: UIButton) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        billDate.text = dateFormatter.string(from: Date())
        view.endEditing(true)
    }
}
