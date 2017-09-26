//
//  IPButtonSubClass.swift
//  IndustryPlatter
//
//  Created by Krati Agarwal on 16/05/17.
//  Copyright © 2017 Mobiloitte. All rights reserved.
//

import UIKit

class IPButtonSubClass: UIButton {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        self.setBackgroundImage(UIImage(named: "blue_button_background") as UIImage?, for: .normal)
        self.tintColor = UIColor.white

    }

}
