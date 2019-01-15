//
//  Bill.swift
//  SplitBills
//
//  Created by Anthony Tse on 1/13/19.
//  Copyright © 2019 Anthony Tse. All rights reserved.
//

import UIKit

class Bill {
    
    var amount: String
    var name: String
    var date: String
    var description: String
    
    init?(amount: String, name: String, date: String, description: String) {
        
//        guard amount > 0  else {
//            return nil
//        }
        
        guard !name.isEmpty else {
            return nil
        }
        
        self.amount = amount
        self.name = name
        self.date = date
        self.description = description
    }
    
    
}
