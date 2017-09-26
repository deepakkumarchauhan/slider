//
//  IPGradientView.swift
//  IndustryPlatter
//
//  Created by Krati Agarwal on 26/05/17.
//  Copyright © 2017 Mobiloitte. All rights reserved.
//

import UIKit

class IPGradientView: UIView {

    override func awakeFromNib() {
        
        super.awakeFromNib()
        blackGradient()
    }
    
    func blackGradient() {
        
    // Create the colors
        
        let topColor = UIColor .black .withAlphaComponent(0.2) as UIColor
        let bottomColor = UIColor.black
        
        // Create the gradient

        //let theViewGradient = layer as! CAGradientLayer
        var theViewGradient: CAGradientLayer!
        
        theViewGradient = CAGradientLayer()
        
        theViewGradient.colors = [topColor.cgColor, bottomColor.cgColor]
        theViewGradient.frame = self.bounds
        
        //Add gradient to view
        self.layer .insertSublayer(theViewGradient, at: 0)

    }
    
}
