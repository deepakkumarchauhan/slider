//
//  SAEventDetailDescTableViewCell.swift
//  SliderApp
//
//  Created by Deepak Chauhan on 07/07/17.
//  Copyright © 2017 Mobiloitte. All rights reserved.
//

import UIKit

class SAEventDetailDescTableViewCell: UITableViewCell,FloatRatingViewDelegate {

    @IBOutlet var eventNameLabel: UILabel!
    @IBOutlet var eventDescriptionLabel: UILabel!
    @IBOutlet var descDateLabel: UILabel!

    @IBOutlet var descStarView: FloatRatingView!
    
    @IBOutlet var descBackgroundView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
//        
//        // Required float rating view params
//        self.descStarView.emptyImage = UIImage(named: "star_iconWhite")
//        self.descStarView.fullImage = UIImage(named: "star_icon")
//        // Optional params
//        self.descStarView.delegate = self
//        self.descStarView.contentMode = UIViewContentMode.scaleAspectFit
//        self.descStarView.maxRating = 5
//        self.descStarView.minRating = 1
//        self.descStarView.rating = 5
//        self.descStarView.editable = false
//        self.descStarView.halfRatings = false
//        self.descStarView.floatRatings = false

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    // MARK: FloatRatingViewDelegate
    func floatRatingView(_ ratingView: FloatRatingView, isUpdating rating:Float) {
        //        self.liveLabel.text = NSString(format: "%.2f", self.floatRatingView.rating) as String
    }
    
    func floatRatingView(_ ratingView: FloatRatingView, didUpdate rating: Float) {
        //        self.updatedLabel.text = NSString(format: "%.2f", self.floatRatingView.rating) as String
    }
}
