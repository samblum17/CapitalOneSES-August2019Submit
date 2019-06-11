//
//  QuestionTableViewCell.swift
//  CapitalOneSES-August2019Submit
//
//  Created by Sam Blum on 6/11/19.
//  Copyright © 2019 Sam Blum. All rights reserved.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {

//Cell attribute labels
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var gradeLevelLabel: UILabel!
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var urlLabel: UILabel!


    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
