//
//  CampgroundsTableViewCell.swift
//  CapitalOneSES-August2019Submit
//
//  Created by Sam Blum on 6/9/19.
//  Copyright © 2019 Sam Blum. All rights reserved.
//

import UIKit

//Custom cell for campground data
class CampgroundsTableViewCell: UITableViewCell {
    
    //Cell attributes loaded into variables to change
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var amenitiesLabel: UILabel!
    @IBOutlet var weatherLabel: UILabel!
    @IBOutlet var directionsLabel: UILabel!
    @IBOutlet var campsiteTypesHeader: UILabel!
    @IBOutlet var weatherHeader: UILabel!
    @IBOutlet var directionsHeader: UILabel!
    @IBOutlet var campsitesStackView: UIStackView!
    @IBOutlet var totalSites: UILabel!
    @IBOutlet var rvSites: UILabel!
    @IBOutlet var tentSites: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
