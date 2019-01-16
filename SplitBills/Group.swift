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
    //will serve as key for picker, and individualTotal dict
    var members: [String]
   
    var membersInfo: [Person]
    var bills: [Bill]
    var individualTotal: [String: Double]
    var total: Double
    
    init?(name: String) {
        
        guard !name.isEmpty else{
            return nil
        }
        
        self.name = name
        self.members = []
        self.membersInfo = []
        self.bills = []
        self.individualTotal = [:]
        self.total = 0.0
    }
}

