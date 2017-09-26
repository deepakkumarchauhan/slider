//
//  SAGroupUserTableViewCell.swift
//  SliderApp
//
//  Created by Deepak Chauhan on 18/07/17.
//  Copyright © 2017 Mobiloitte. All rights reserved.
//

import UIKit

class SAGroupUserTableViewCell: UITableViewCell {

    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var removeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
