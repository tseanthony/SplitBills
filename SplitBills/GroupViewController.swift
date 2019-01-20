//
//  GroupViewController.swift
//  SplitBills
//
//  Created by Anthony Tse on 1/15/19.
//  Copyright © 2019 Anthony Tse. All rights reserved.
//

import UIKit
import os.log

class GroupViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var groupTableView: UITableView!
  
    var modelcontroller: ModelController!
    var groups = [Group]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navBar.shadowImage = UIImage()
        groupTableView.dataSource = self
        groupTableView.delegate = self
        //Temporary until I get persistent data
        loadSampleGroups()
        modelcontroller.groups = self.groups
    
    }

    //MARK: Table View Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelcontroller.groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "GroupTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? GroupTableViewCell else { fatalError("The dequeued cell is not an instance of BillTableViewCell.")
        }
        
        let group = modelcontroller.groups[indexPath.row]
        cell.nameLabel.text = group.name
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            modelcontroller.groups.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? ""){
        
        case "pickGroup":
            
            guard let barViewController = segue.destination as? UITabBarController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            //Bar Tab 1
            
            guard let SumViewNav = barViewController.viewControllers?[0] as? UINavigationController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let SumViewController = SumViewNav.viewControllers[0] as? SummaryViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            //Bar Tab 2
            guard let BillListNav = barViewController.viewControllers?[1] as? UINavigationController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let BillListCont = BillListNav.viewControllers[0] as? BillTableViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedGroupCell = sender as? GroupTableViewCell else {
                fatalError("Unexpected sender: \(sender.debugDescription)")
            }
            
            guard let indexPath = groupTableView.indexPath(for: selectedGroupCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            //Bar Tab 3
            guard let MemInfoNavController = barViewController.viewControllers?[2] as? UINavigationController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let MemInfoController = MemInfoNavController.viewControllers[0] as? MembersInfoTableViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            //Deliver references
            let selectedGroup = modelcontroller.groups[indexPath.row]
            SumViewController.group = selectedGroup
            BillListCont.group = selectedGroup
            MemInfoController.group = selectedGroup
         
        case "addGroup": break
            
        default:
                fatalError("Unexpected Segue Identifier; \(segue.debugDescription)")
        }
        // Pass the selected object to the new view controller.
    }
    
    @IBAction func unwindToGroupView(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? AddGroupViewController, let group = sourceViewController.group {
            
            let newIndexPath = IndexPath(row: modelcontroller.groups.count, section: 0)
        
            modelcontroller.groups.append(group)
            groupTableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
    

    //MARK: private methods
    private func loadSampleGroups(){
        
        //set up bills
        guard let bill1 = Bill(amount: 12.73, name: "Anthony", date: "01/13/2019", description: "Pizza \u{1F355}") else {
            fatalError("Unable to instantiate bill1")
        }
        guard let bill2 = Bill(amount: 49.83, name: "Ram", date: "12/13/2018", description: "Electric Bill \u{1F4A1}") else {
            fatalError("Unable to instantiate bill2")
        }
        guard let bill3 = Bill(amount: 18.94, name: "Sarah", date: "12/13/2014", description: "Uber to Brooklyn \u{1F695}") else {
            fatalError("Unable to instantiate bill3")
        }
        
        let bills = [bill1, bill2, bill3]
        
        guard let group1 = Group(name: "Team Bills") else {
            fatalError("Unable to instantiate bill3")
        }
        guard let group2 = Group(name: "Patriots") else {
            fatalError("Unable to instantiate bill3")
        }
        guard let group3 = Group(name: "Chiefs") else {
            fatalError("Unable to instantiate bill3")
        }
        
        
        group1.members = ["Anthony", "Ram", "Stephanie"]
        group1.bills = bills
        group1.individualTotal = ["Anthony": 12.73, "Ram":49.83, "Stephanie": 18.94 ]
        group1.total = 12.73 + 49.83 + 18.94
        //will do .membersInfo later
        
        group2.members = ["Anthony", "Ram", "Stephanie"]
        group2.bills = bills
        group2.individualTotal = ["Anthony": 12.73, "Ram":49.83, "Stephanie": 18.94 ]
        group2.total = 12.73 + 49.83 + 18.94
        //will do .membersInfo later
        
        group3.members = ["Anthony", "Ram", "Stephanie"]
        group3.bills = bills
        group3.individualTotal = ["Anthony": 12.73, "Ram":49.83, "Stephanie": 18.94 ]
        group3.total = 12.73 + 49.83 + 18.94
        //will do .membersInfo later
        
        
        groups += [group1, group2, group3]
    
    }
}
