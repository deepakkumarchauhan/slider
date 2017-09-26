//
//  SAEventDetailTableViewCell.swift
//  SliderApp
//
//  Created by Deepak Chauhan on 07/07/17.
//  Copyright © 2017 Mobiloitte. All rights reserved.
//

import UIKit

class SAEventDetailTableViewCell: UITableViewCell,FloatRatingViewDelegate {

    @IBOutlet var eventnameLabel: UILabel!
    @IBOutlet var eventLocationLabel: UILabel!
    @IBOutlet var eventTimeLabel: UILabel!
    
    @IBOutlet var detailStarView: FloatRatingView!
    
    @IBOutlet var groupChatButton: UIButton!
    @IBOutlet var peopleInterestedButton: UIButton!
    @IBOutlet var locationButton: UIButton!
    @IBOutlet var inviteFriendButton: UIButton!
    
    @IBOutlet var floatRatingView: FloatRatingView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
//            // Required float rating view params
//            self.detailStarView.emptyImage = UIImage(named: "star_iconWhite")
//            self.detailStarView.fullImage = UIImage(named: "star_icon")
//            // Optional params
//            self.detailStarView.delegate = self
//            self.detailStarView.contentMode = UIViewContentMode.scaleAspectFit
//            self.detailStarView.maxRating = 5
//            self.detailStarView.minRating = 1
//            self.detailStarView.rating = 5
//            self.detailStarView.editable = false
//            self.detailStarView.halfRatings = false
//            self.detailStarView.floatRatings = false
//        
//            // Segmented control init
//            self.ratingSegmentedControl.selectedSegmentIndex = 1
        
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



