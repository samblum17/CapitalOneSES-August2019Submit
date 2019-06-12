//
//  MoreInfoTableViewCell.swift
//  CapitalOneSES-August2019Submit
//
//  Created by Sam Blum on 6/12/19.
//  Copyright © 2019 Sam Blum. All rights reserved.
//

import UIKit

class MoreInfoTableViewCell: UITableViewCell {

    @IBOutlet var topSectionHeaderLabel: UILabel!
    @IBOutlet var topSectionTextLabel: UILabel!
    @IBOutlet var bottomSectionHeaderLabel: UILabel!
    @IBOutlet var bottomSectionTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
