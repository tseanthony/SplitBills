//
//  Bill.swift
//  SplitBills
//
//  Created by Anthony Tse on 1/13/19.
//  Copyright © 2019 Anthony Tse. All rights reserved.
//

import UIKit

class Bill {
    
    var amount: Double
    var name: String
    var date: String
    var description: String
    
    init?(amount: Double, name: String, date: String, description: String) {
        
        if amount <= 0 {
            return nil
        }
        
        self.amount = amount
        self.name = name
        self.date = date
        self.description = description
    }
    
    
}
