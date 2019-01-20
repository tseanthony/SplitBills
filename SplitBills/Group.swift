//
//  Group.swift
//  SplitBills
//
//  Created by Anthony Tse on 1/14/19.
//  Copyright © 2019 Anthony Tse. All rights reserved.
//

import UIKit

class Group {
    
    var name: String
    var members: [String]   //will serve as key for picker, and individualTotal dict
    var individualTotal: [String: Double]
    var total: Double
   
    var membersInfo: [Person]
    var bills: [Bill]
    
    
    init?(name: String) {
        
        guard !name.isEmpty else{
            return nil
        }
        
        self.name = name
        self.members = [String]()
        self.membersInfo = [Person]()
        self.bills = [Bill]()
        self.individualTotal = [String:Double]()
        self.total = 0.0
    }
}

