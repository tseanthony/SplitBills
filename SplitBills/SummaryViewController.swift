//
//  SummaryViewController.swift
//  SplitBills
//
//  Created by Anthony Tse on 1/17/19.
//  Copyright © 2019 Anthony Tse. All rights reserved.
//

import UIKit
import os.log

class SummaryViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var memberTableView: UITableView!
    
    var group: Group?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memberTableView.dataSource = self
        NameLabel.text = group?.name
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.memberTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return group?.members.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            // Table view cells are reused and should be dequeued using a cell identifier.
            let cellIdentifier = "SummaryTableViewCell"
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? SummaryTableViewCell else { fatalError("The dequeued cell is not an instance of SummaryTableViewCell.")
            }
            
        let member = group?.members[indexPath.row]
        cell.nameLabel.text = member
        cell.debtLabel.text = group?.individualTotal[member ?? "nil"]?.description
        
        return cell
        
    }

    @IBAction func done(_ sender: UIBarButtonItem) {
        
        guard let tabController = self.tabBarController else {
            fatalError("no uiTabbarcontroller")
        }
        
        
//        for controller in tabController.viewControllers! {
//            if controller is UINavigationController {
//                guard let navcontroller = controller as? UINavigationController else{
//                    fatalError("Controller to be popped is not a UINavigationController")
//                }
//                navcontroller.popToRootViewController(animated: false)
//            }
//        }
        
        tabController.dismiss(animated: true, completion: nil)

    }
    
    
    
    /*
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
