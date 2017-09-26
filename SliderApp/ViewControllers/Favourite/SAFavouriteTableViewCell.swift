//
//  SAFavouriteTableViewCell.swift
//  SliderApp
//
//  Created by Deepak Chauhan on 11/07/17.
//  Copyright © 2017 Mobiloitte. All rights reserved.
//

import UIKit

class SAFavouriteTableViewCell: UITableViewCell {
    @IBOutlet var favouriteImageView: UIImageView!

    @IBOutlet var eventNameLabel: UILabel!
    @IBOutlet var closeTimeLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    
    
    @IBOutlet var shareButton: UIButton!
    @IBOutlet var happyHourButton: UIButton!
    @IBOutlet var liveMusicButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
