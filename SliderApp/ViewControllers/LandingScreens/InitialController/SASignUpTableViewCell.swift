//
//  SASignUpTableViewCell.swift
//  SliderApp
//
//  Created by Deepak Chauhan on 05/07/17.
//  Copyright © 2017 Mobiloitte. All rights reserved.
//

import UIKit

class SASignUpTableViewCell: UITableViewCell {

    @IBOutlet weak var signUpTextField: SATexFieldSubClass!
    @IBOutlet weak var purpleTopUpLabel: UILabel!
    @IBOutlet weak var purpleTopDownLabel: UILabel!
    @IBOutlet weak var purpleDownDownLabel: UILabel!
    @IBOutlet weak var purpleDownLeftLabel: UILabel!
    @IBOutlet weak var locationImageView: UIImageView!

    @IBOutlet var signUpTextView: IQTextView!
    @IBOutlet var signUpButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

