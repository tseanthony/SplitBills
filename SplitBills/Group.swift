//
//  Group.swift
//  SplitBills
//
//  Created by Anthony Tse on 1/14/19.
//  Copyright © 2019 Anthony Tse. All rights reserved.
//

import UIKit
import os.log

class Group: NSObject, NSCoding {

    //MARK: Properties
    var name: String
    var members: [String]   //will serve as key for picker, and individualTotal dict
    var individualTotal: [String: Double]
    var total: Double
    var membersInfo: [Person]
    var bills: [Bill]
    
    struct PropertyKey {
        static let name = "name"
        static let members = "members"
        static let individualTotal = "individualTotal"
        static let total = "total"
        static let membersInfo = "membersInfo"
        static let bills = "bills"
    }
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("Groups")
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(members, forKey: PropertyKey.members)
        aCoder.encode(individualTotal, forKey: PropertyKey.individualTotal)
        aCoder.encode(total, forKey: PropertyKey.total)
        aCoder.encode(membersInfo, forKey: PropertyKey.membersInfo)
        aCoder.encode(bills, forKey: PropertyKey.bills)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Group object.", log: OSLog.default, type: .debug)
            return nil
        } 
        
        guard let members = aDecoder.decodeObject(forKey: PropertyKey.members) as? [String] else {
            os_log("Unable to decode the name for a Group object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let individualTotal = aDecoder.decodeObject(forKey: PropertyKey.individualTotal) as? [String: Double] else {
            os_log("Unable to decode the name for a Group object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        let total = aDecoder.decodeDouble(forKey: PropertyKey.total)
        
        guard let membersInfo = aDecoder.decodeObject(forKey: PropertyKey.membersInfo) as? [Person] else {
            os_log("Unable to decode the name for a Group object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let bills = aDecoder.decodeObject(forKey: PropertyKey.bills) as? [Bill] else {
            os_log("Unable to decode the name for a Group object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        self.init(name: name)
        self.members = members
        self.individualTotal = individualTotal
        self.total = total
        self.membersInfo = membersInfo
        self.bills = bills
    }
    
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

