//
//  Bill.swift
//  SplitBills
//
//  Created by Anthony Tse on 1/13/19.
//  Copyright © 2019 Anthony Tse. All rights reserved.
//

import UIKit
import os.log

class Bill: NSObject, NSCoding {

    //MARK: Properties
    var amount: Double
    var name: String
    var date: String
    var billdescription: String
    
    struct PropertyKey {
        static let amount = "amount"
        static let name = "name"
        static let date = "date"
        static let billdescription = "billdescription"
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(amount, forKey: PropertyKey.amount)
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(date, forKey: PropertyKey.date)
        aCoder.encode(billdescription, forKey: PropertyKey.billdescription)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let amount = aDecoder.decodeDouble(forKey: PropertyKey.amount)
        
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Person object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let date = aDecoder.decodeObject(forKey: PropertyKey.date) as? String  else {
            os_log("Unable to decode the name for a Person object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let billdescription = aDecoder.decodeObject(forKey: PropertyKey.billdescription) as? String  else {
            os_log("Unable to decode the name for a Person object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        self.init(amount: amount, name: name, date: date, billdescription: billdescription)
    }
    
    init?(amount: Double, name: String, date: String, billdescription: String) {
        
//        guard amount > 0  else {
//            return nil
//        }
        
        guard !name.isEmpty else {
            return nil
        }
        
        self.amount = amount
        self.name = name
        self.date = date
        self.billdescription = billdescription
    }
    
    
}
