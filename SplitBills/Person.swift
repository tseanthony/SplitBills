//
//  Person.swift
//  SplitBills
//
//  Created by Anthony Tse on 1/14/19.
//  Copyright © 2019 Anthony Tse. All rights reserved.
//

import UIKit
import os.log

class Person: NSObject, NSCoding {
    
    //MARK: Properties
    var image: UIImage?
    var name: String
    var phonenumber: String
    var email: String

    struct PropertyKey {
        static let image = "image"
        static let name = "name"
        static let phonenumber = "phonenumber"
        static let email = "email"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(image, forKey: PropertyKey.image)
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(phonenumber, forKey: PropertyKey.phonenumber)
        aCoder.encode(email, forKey: PropertyKey.email)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Person object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        let image = aDecoder.decodeObject(forKey: PropertyKey.image) as? UIImage
        
        guard let phonenumber = aDecoder.decodeObject(forKey: PropertyKey.phonenumber) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let email = aDecoder.decodeObject(forKey: PropertyKey.email) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Must call designated initializer.
        self.init(image: image, name: name, phonenumber: phonenumber, email: email)
    }
    
    init?(image: UIImage?, name: String, phonenumber: String, email: String) {
        
        guard !name.isEmpty else {
            return nil
        }
        
        self.image = image
        self.name = name
        self.phonenumber = phonenumber
        self.email = email
    }
}
