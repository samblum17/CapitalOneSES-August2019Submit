//
//  searchResultsTableViewCell.swift
//  CapitalOneSES-August2019Submit
//
//  Created by Sam Blum on 6/12/19.
//  Copyright © 2019 Sam Blum. All rights reserved.
//

import UIKit

//Custom cell made so image can be loaded to proper size
class searchResultsTableViewCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var stateCodeLabel: UILabel!
    @IBOutlet var cellImage: UIImageView!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
