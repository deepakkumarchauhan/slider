//
//  SAContactUsTableViewCell.swift
//  SliderApp
//
//  Created by Deepak Chauhan on 07/07/17.
//  Copyright © 2017 Mobiloitte. All rights reserved.
//

import UIKit

class SAContactUsTableViewCell: UITableViewCell {
    @IBOutlet var messageTextView: IQTextView!

    @IBOutlet var downBottomLabel: UILabel!
    @IBOutlet var downLeftLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
