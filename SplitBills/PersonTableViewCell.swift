//
//  PersonTableViewCell.swift
//  SplitBills
//
//  Created by Anthony Tse on 1/18/19.
//  Copyright © 2019 Anthony Tse. All rights reserved.
//

import UIKit

class PersonTableViewCell: UITableViewCell {

    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var personName: UILabel!
    @IBOutlet weak var personPhoneNumber: UILabel!
    @IBOutlet weak var personEmail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
