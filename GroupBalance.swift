//
//  GroupBalance.swift
//  SplitBills
//
//  Created by Anthony Tse on 1/12/19.
//  Copyright © 2019 Anthony Tse. All rights reserved.
//

import UIKit

class GroupBalance {
    var cost: Double
    var payer: String
    var date: String
    var description: String
    
    init?(cost: Double, payer: String, date: String, description: String) {
        
        if cost <= 0 || payer.isEmpty {
            return nil
        }
        self.cost = cost
        self.payer = payer
        self.date = date
        self.description = description
        
    }
}
