//
//  SAEventListCollectionViewCell.swift
//  SliderApp
//
//  Created by Deepak Chauhan on 10/07/17.
//  Copyright © 2017 Mobiloitte. All rights reserved.
//

import UIKit

class SAEventListCollectionViewCell: UICollectionViewCell {

    @IBOutlet var eventLocationButton: UIButton!
    @IBOutlet var eventDateLabel: UILabel!
    @IBOutlet var eventLocationLabel: UILabel!
    @IBOutlet var eventNameLabel: UILabel!
    @IBOutlet var eventImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
