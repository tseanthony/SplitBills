//
//  AddGroupViewController.swift
//  SplitBills
//
//  Created by Anthony Tse on 1/18/19.
//  Copyright © 2019 Anthony Tse. All rights reserved.
//

import UIKit
import os.log

class AddGroupViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var groupNameTextField: UITextField!
    @IBOutlet weak var memberTable: UITableView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var group = Group(name: "error")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        groupNameTextField.delegate = self
        memberTable.dataSource = self
        memberTable.delegate = self
        
        updateSaveButtonState()

    }
    
    //MARK: UITextFieldDelagate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        groupNameTextField.text = textField.text
        group?.name = textField.text ?? ""
        updateSaveButtonState()
    }
    
    //MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (group?.membersInfo.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "AddGroupTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? AddGroupTableViewCell else { fatalError("The dequeued cell is not an instance of AddGroupTableViewCell.")
        }
        
        if let memberToUpdate = group?.membersInfo[indexPath.row] {
            cell.personName.text = memberToUpdate.name
            cell.personImage.image = memberToUpdate.image
            cell.personEmail.text = memberToUpdate.email
            cell.personPhoneNumber.text = memberToUpdate.phonenumber
        }
        
        return cell
    }
    
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            if let removename = group?.members[indexPath.row] {
                group?.individualTotal.removeValue(forKey: removename)
            }
            
            group?.members.remove(at: indexPath.row)
            group?.membersInfo.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "addMember":
            os_log("Adding a new member.", log: OSLog.default, type: .debug)

        case "showDetail":
            guard let personViewController = segue.destination as? PersonViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedPersonCell = sender as? AddGroupTableViewCell else {
                fatalError("Unexpected sender: \(sender.debugDescription)")
            }
            
            guard let indexPath = memberTable.indexPath(for: selectedPersonCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedPerson = group?.membersInfo[indexPath.row]
            personViewController.person = selectedPerson
            
        default: break
//            fatalError("Unexpected Segue Identifier; \(segue.debugDescription)")
        }
    }
    
    @IBAction func unwindToMemberList(sender: UIStoryboardSegue) {
        
        if let sourceViewController = sender.source as? PersonViewController, let person = sourceViewController.person {
            
            if let selectedIndexPath = memberTable.indexPathForSelectedRow {
                // Update an existing member
                
                if let removename = group?.members[selectedIndexPath.row] {
                    group?.individualTotal.removeValue(forKey: removename)
                }
                
                group?.individualTotal[person.name] = 0
                group?.members[selectedIndexPath.row] = person.name
                group?.membersInfo[selectedIndexPath.row] = person
                
                memberTable.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
            // Add a new member
                let newIndexPath = IndexPath(row: (group?.membersInfo.count)!, section: 0)
                
                group?.members.append(person.name)
                group?.individualTotal[person.name] = 0
                group?.membersInfo.append(person)
                
                memberTable.insertRows(at: [newIndexPath], with: .automatic)
                updateSaveButtonState()
            }

        }
        
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Private Methods
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let nametext = groupNameTextField.text ?? ""
        
        saveButton.isEnabled = !nametext.isEmpty
        
    }
    
}


