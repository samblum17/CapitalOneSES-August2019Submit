//
//  EventsTableViewCell.swift
//  CapitalOneSES-August2019Submit
//
//  Created by Sam Blum on 6/10/19.
//  Copyright © 2019 Sam Blum. All rights reserved.
//

import UIKit

//Custom cell for event data
class EventsTableViewCell: UITableViewCell {
    
    //Cell attributes loaded into variables to change
    
    @IBOutlet var dateStackView: UIStackView!
    @IBOutlet var startDateLabel: UILabel!
    @IBOutlet var endDateLabel: UILabel!
    @IBOutlet var timeStackView: UIStackView!
    @IBOutlet var timeStartLabel: UILabel!
    @IBOutlet var endTimeLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var feeLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
