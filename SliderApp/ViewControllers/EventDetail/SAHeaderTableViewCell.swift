//
//  SAHeaderTableViewCell.swift
//  SliderApp
//
//  Created by Deepak Chauhan on 07/07/17.
//  Copyright © 2017 Mobiloitte. All rights reserved.
//

import UIKit

class SAHeaderTableViewCell: UITableViewCell {

    @IBOutlet var headerTitleLabel: UILabel!

    @IBOutlet weak var bgroundView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
