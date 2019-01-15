//
//  BillTableViewCell.swift
//  SplitBills
//
//  Created by Anthony Tse on 1/13/19.
//  Copyright © 2019 Anthony Tse. All rights reserved.
//

import UIKit

class BillTableViewCell: UITableViewCell {

    //MARK: Properties

    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
