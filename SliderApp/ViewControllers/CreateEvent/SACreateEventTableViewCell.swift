//
//  SACreateEventTableViewCell.swift
//  SliderApp
//
//  Created by Deepak Chauhan on 11/07/17.
//  Copyright © 2017 Mobiloitte. All rights reserved.
//

import UIKit

class SACreateEventTableViewCell: UITableViewCell {

    @IBOutlet var leftTextField: SATexFieldSubClass!
    @IBOutlet var rightTextField: SATexFieldSubClass!
    
    @IBOutlet var rightButton: UIButton!
    @IBOutlet var leftButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
