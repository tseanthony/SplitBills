//
//  BillTableViewController.swift
//  SplitBills
//
//  Created by Anthony Tse on 1/13/19.
//  Copyright © 2019 Anthony Tse. All rights reserved.
//

import UIKit
import os.log

class BillTableViewController: UITableViewController {

    //MARK: Properties
    var bills = [Bill]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem
        
        loadSampleBills()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return bills.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "BillTableViewCell"

        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? BillTableViewCell else {
            fatalError("The dequeued cell is not an instance of BillTableViewCell.")
        }

        let bill = bills[indexPath.row]

        // Configure the cell...
        cell.amountLabel.text = "$" + bill.amount
        cell.nameLabel.text = bill.name
        cell.dateLabel.text = bill.date
        cell.descriptionLabel.text = bill.description

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            bills.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "AddItem":
            os_log("Adding a new bill.", log: OSLog.default, type: .debug)
            
        case "ShowDetail":
            guard let billDetailViewController = segue.destination as? BillViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedBillCell = sender as? BillTableViewCell else {
                fatalError("Unexpected sender: \(sender.debugDescription)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedBillCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedBill = bills[indexPath.row]
            billDetailViewController.bill = selectedBill
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.debugDescription)")
        }
        
        // Pass the selected object to the new view controller.
    }


    //MARK: Actions
    @IBAction func unwindToBillList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? BillViewController, let bill = sourceViewController.bill {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing meal.
                bills[selectedIndexPath.row] = bill
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                // Add a new bill.
                let newIndexPath = IndexPath(row: bills.count, section: 0)
                
                bills.append(bill)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            
        }
    }
    
    
    
    //MARK: Private Methods
    
    private func loadSampleBills() {
        guard let bill1 = Bill(amount: "12.73", name: "Anthony", date: "01/13/2019", description: "Pizza \u{1F355}") else {
            fatalError("Unable to instantiate bill1")
        }
        guard let bill2 = Bill(amount: "49.83", name: "Ram", date: "12/13/2018", description: "Electric Bill \u{1F4A1}") else {
            fatalError("Unable to instantiate bill2")
        }
        guard let bill3 = Bill(amount: "18.94", name: "Trisha", date: "12/13/2014", description: "Uber to Brooklyn \u{1F695}") else {
            fatalError("Unable to instantiate bill3")
        }
        
        bills += [bill1, bill2, bill3]
    }
    
}
