//
//  SATitleLabelTVCell.swift
//  SliderApp
//
//  Created by Krati Agarwal on 12/07/17.
//  Copyright © 2017 Mobiloitte. All rights reserved.
//

import UIKit

class SATitleLabelTVCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var checkButton: UIButton!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
