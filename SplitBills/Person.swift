//
//  Person.swift
//  SplitBills
//
//  Created by Anthony Tse on 1/14/19.
//  Copyright © 2019 Anthony Tse. All rights reserved.
//

import UIKit

class Person {
    
    var image: UIImage?
    var name: String
    var phonenumber: String
    var email: String
    
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
