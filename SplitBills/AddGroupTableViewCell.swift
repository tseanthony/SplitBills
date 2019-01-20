//
//  AddGroupTableViewCell.swift
//  SplitBills
//
//  Created by Anthony Tse on 1/19/19.
//  Copyright © 2019 Anthony Tse. All rights reserved.
//

import UIKit

class AddGroupTableViewCell: UITableViewCell {

    
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var personName: UITextField!
    @IBOutlet weak var personPhoneNumber: UITextField!
    @IBOutlet weak var personEmail: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
