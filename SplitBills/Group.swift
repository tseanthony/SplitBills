//
//  Group.swift
//  SplitBills
//
//  Created by Anthony Tse on 1/14/19.
//  Copyright © 2019 Anthony Tse. All rights reserved.
//

import UIKit

class Group {
    
    var groupName: String
    var groupMembers: [Person]
    
    var bills: [Bill]
    
    var individualTotal: [String: Int]
    var total: Int
    
    init?(groupName: String) {
        
        guard !groupName.isEmpty else{
            return nil
        }
        
        self.groupName = groupName
        self.groupMembers = []
        self.bills = []
        self.individualTotal = [:]
        self.total = 0
    }
}

