//
//  SATrendingTableViewCell.swift
//  SliderApp
//
//  Created by Deepak Chauhan on 10/07/17.
//  Copyright © 2017 Mobiloitte. All rights reserved.
//

import UIKit

class SATrendingTableViewCell: UITableViewCell {

    @IBOutlet var userProfileImageView: UIImageView!
    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var commentUserProfileImageView: UIImageView!
    
    @IBOutlet var barNameLabel: UILabel!
    @IBOutlet var barCategoryLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    @IBOutlet var numberOfCommentLabel: UILabel!
    @IBOutlet var commentUserNameLabel: UILabel!
    @IBOutlet var locationDistanceButton: UIButton!
    
    @IBOutlet var likeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
