//
//  SAInterestedPeopleTableViewCell.swift
//  SliderApp
//
//  Created by Deepak Chauhan on 06/07/17.
//  Copyright © 2017 Mobiloitte. All rights reserved.
//

import UIKit

class SAInterestedPeopleTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var connectButton: UIButton!
    @IBOutlet var userImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
