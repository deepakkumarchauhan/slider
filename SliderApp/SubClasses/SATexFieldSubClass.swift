//
//  SATexFieldSubClass.swift
//  SliderApp
//
//  Created by Krati Agarwal on 10/07/17.
//  Copyright © 2017 Mobiloitte. All rights reserved.
//

import UIKit

@IBDesignable

class SATexFieldSubClass: UITextField {

    @IBInspectable var paddingLeft: CGFloat = 0
    @IBInspectable var paddingRight: CGFloat = 0
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
            return CGRect(x: bounds.origin.x + paddingLeft, y: bounds.origin.y, width: bounds.size.width - paddingLeft - paddingRight, height: bounds.size.height)
    }
        
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
            return textRect(forBounds: bounds)
    }
    
    
    func setCustomPlaceholder(string: String) {
        
        self.autocorrectionType = UITextAutocorrectionType.no
        self.attributedPlaceholder = NSAttributedString(string: string, attributes: [NSForegroundColorAttributeName :UIColor.black ,NSFontAttributeName : UIFont(name:"Raleway-Regular", size:15)!])
        self.font = UIFont(name:"Raleway-Regular", size:15)
        self.textColor = UIColor.darkText
    }
    
    override func draw(_ rect: CGRect) {
        
        self.autocorrectionType = UITextAutocorrectionType.no
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder!, attributes: [NSForegroundColorAttributeName :UIColor.black ,NSFontAttributeName : UIFont(name:"Raleway-Regular", size:15)!])
        self.font = UIFont(name:"Raleway-Regular", size:15)
        self.textColor = UIColor.darkText
    }
}
