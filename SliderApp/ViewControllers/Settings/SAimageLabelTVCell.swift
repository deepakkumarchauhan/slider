//
//  SAimageLabelTVCell.swift
//  SliderApp
//
//  Created by Krati Agarwal on 12/07/17.
//  Copyright © 2017 Mobiloitte. All rights reserved.
//

import UIKit

class SAimageLabelTVCell: UITableViewCell {

    @IBOutlet weak var titleimageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var notificationSwitch: UISwitch!
    


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

        override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
