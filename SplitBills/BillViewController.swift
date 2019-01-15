//
//  BillViewController.swift
//  SplitBills
//
//  Created by Anthony Tse on 1/12/19.
//  Copyright © 2019 Anthony Tse. All rights reserved.
//

import UIKit
import os.log


class BillViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: properties
    @IBOutlet weak var billCost: UITextField!
    @IBOutlet weak var billDate: UITextField!
    @IBOutlet weak var billPayer: UITextField!
    @IBOutlet weak var billDescription: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    let datePicker = UIDatePicker()
    
    /*
     This value is either passed by `BillTableViewController` in `prepare(for:sender:)`
     or constructed as part of adding a new bill.
     */
    var bill: Bill?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        billCost.delegate = self
        billPayer.delegate = self
        billDescription.delegate = self
        billDate.delegate = self
        
        // Populate text fields if coming from ShowDetail Segue
        if let bill = bill {
            billCost.text = bill.amount
            billPayer.text = bill.name
            billDate.text = bill.date
            billDescription.text = bill.description
        }
        
        // Set up UIDatePicker for billDate (Programmatically)
        self.datePicker.datePickerMode = .date
      
        // Set up UIToolBar for billDate (Programmatically)
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(BillViewController.cancelClick))
        let currentButton = UIBarButtonItem(title: "Today", style: .plain, target: self, action: #selector(BillViewController.todayClick))
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(BillViewController.doneClick))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([cancelButton, spacer, currentButton, spacer, doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        billDate.inputView = datePicker
        billDate.inputAccessoryView = toolbar
        
        // Update saveButton on load
        updateSaveButtonState()
    }
    

    //MARK: UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled = false
    }
    
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
        
        updateSaveButtonState()
    }
    
    //MARK: Navigation
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddBillMode = presentingViewController is UINavigationController
        
        if isPresentingInAddBillMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The BillViewController is not inside a navigation controller.")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let cost = billCost.text ?? "error"
        let date = billDate.text ?? "error"
        let payer = billPayer.text ?? "error"
        let description = billDescription.text ?? "error"
        
        bill = Bill(amount: cost, name: payer, date: date, description: description)
    }
    
    
    //MARK: Actions
    
    //This button is redundant
    @IBAction func setCurrentDate(_ sender: UIButton) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        billDate.text = dateFormatter.string(from: Date())
        view.endEditing(true)
    }
    
    //MARK: Private Methods
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let nametext = billCost.text ?? ""
        let billtext = billPayer.text ?? ""
        let datetext = billDate.text ?? ""
        
        
        saveButton.isEnabled =  !nametext.isEmpty &&
                                !billtext.isEmpty &&
                                !datetext.isEmpty
    }
    
    @objc private func cancelClick() {
        billDate.resignFirstResponder()
    }
    
    @objc private func todayClick() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        billDate.text = dateFormatter.string(from: Date())
        view.endEditing(true)
        
        billDate.resignFirstResponder()
    }
    
    @objc private func doneClick() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        billDate.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(true)
        
        billDate.resignFirstResponder()
    }
}
