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
    var group: Group?
 
    //   var bills = [Bill]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem
        
        //loadSampleBills()
        //bills = group?.bills ?? []

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
        return group?.bills.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "BillTableViewCell"

        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? BillTableViewCell else {
            fatalError("The dequeued cell is not an instance of BillTableViewCell.")
        }

        let bill = group?.bills[indexPath.row]

        // Configure the cell...
        
        
        cell.amountLabel.text = "$" + (bill?.amount.description)!
        cell.nameLabel.text = bill?.name
        cell.dateLabel.text = bill?.date
        cell.descriptionLabel.text = bill?.description

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
            group?.bills.remove(at: indexPath.row)
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
            guard let nav = segue.destination as? UINavigationController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let billDetailViewController = nav.viewControllers[0] as? BillViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            //for UIPicker
            billDetailViewController.choices = group?.members ?? []
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
            
            let selectedBill = group?.bills[indexPath.row]
            billDetailViewController.bill = selectedBill
            
            //for UIPicker
            billDetailViewController.choices = group?.members ?? []
            
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
 
                let newval = bill.amount
                
                // "unsafely" unwrap optionals, possibly address.
                let oldval = group!.bills[selectedIndexPath.row].amount
                let currentdebt = group!.individualTotal[bill.name]
                
                let update = (currentdebt! - oldval + newval)
                group?.individualTotal[bill.name] = update
                
                group?.bills[selectedIndexPath.row] = bill
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                // Add a new bill.
                let newIndexPath = IndexPath(row: (group?.bills.count)!, section: 0)
                
                group?.bills.append(bill)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
                
                //Update individual debt
                let newval = bill.amount
                let currentdebt = group!.individualTotal[bill.name]
                let update = (currentdebt! + newval)
                group?.individualTotal[bill.name] = update
                
                
            }
        }
    }
}
