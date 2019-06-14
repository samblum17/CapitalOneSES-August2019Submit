//
//  NewsTableViewCell.swift
//  CapitalOneSES-August2019Submit
//
//  Created by Sam Blum on 6/11/19.
//  Copyright © 2019 Sam Blum. All rights reserved.
//

import UIKit

//Custom cell for news data and url button tap
class NewsTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var urlButton: UIButton!
    
  //Closure so button is tap enabled inside cell
    @objc var urlButtonAction: (() -> ())?
    
    
   override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        //Enable URL button
    self.urlButton.addTarget(self, action: #selector(getter: urlButtonAction), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func urlButtonTapped(_ sender: Any) {
        urlButtonAction?()
    }
    

}
