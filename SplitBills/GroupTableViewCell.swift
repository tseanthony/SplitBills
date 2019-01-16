//
//  GroupTableViewCell.swift
//  SplitBills
//
//  Created by Anthony Tse on 1/15/19.
//  Copyright © 2019 Anthony Tse. All rights reserved.
//

import UIKit

class GroupTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
