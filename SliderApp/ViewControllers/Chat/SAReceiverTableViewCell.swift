//
//  SAReceiverTableViewCell.swift
//  SliderApp
//
//  Created by Deepak Chauhan on 06/07/17.
//  Copyright © 2017 Mobiloitte. All rights reserved.
//

import UIKit

class SAReceiverTableViewCell: UITableViewCell {

    @IBOutlet var viewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var viewWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var userImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.viewWidthConstraint.constant = Window_Width-120

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
