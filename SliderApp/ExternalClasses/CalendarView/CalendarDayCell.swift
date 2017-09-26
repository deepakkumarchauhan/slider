//
//  KDCalendarDayCell.swift
//  KDCalendar
//
//  Created by Michael Michailidis on 02/04/2015.
//  Copyright (c) 2015 Karmadust. All rights reserved.
//

import UIKit

let cellColorDefault = UIColor(white: 0.0, alpha: 0.1)
let cellColorToday = UIColor(red: 239.0/255.0, green: 0.0/255.0, blue: 39.0/255.0, alpha: 0.8)
let borderColor = UIColor(red: 239.0/255.0, green: 0.0/255.0, blue: 39.0/255.0, alpha: 0.8)

var isTodayDate = Bool()

class CalendarDayCell: UICollectionViewCell {
    
    var eventsCount = 0 {
        didSet {
            for sview in self.dotsView.subviews {
                sview.removeFromSuperview()
            }
            
            let stride = self.dotsView.frame.size.width / CGFloat(eventsCount+1)
            let viewHeight = self.dotsView.frame.size.height
            let halfViewHeight = viewHeight / 2.0
            
            for _ in 0..<eventsCount {
                let frm = CGRect(x: (stride+1.0) - halfViewHeight, y: 0.0, width: viewHeight, height: viewHeight)
                let circle = UIView(frame: frm)
                circle.layer.cornerRadius = halfViewHeight
              //  circle.backgroundColor = borderColor
                self.dotsView.addSubview(circle)
            }
        }
    }
    
   var isToday : Bool = false {
        
        didSet {
           
            if isToday == true {
                self.pBackgroundView.backgroundColor = cellColorToday
            }
            else {
                self.pBackgroundView.backgroundColor = UIColor.clear
            }
        }
    }
    
    override var isSelected : Bool {
        
        didSet {
            
            if isSelected == true {
                self.pBackgroundView.layer.borderWidth = 2.0
                
            }
            else {
                self.pBackgroundView.layer.borderWidth = 0.0
            }
            
        }
    }
    
     lazy var pBackgroundView : UIView = {
        
        var vFrame = self.frame.insetBy(dx: 3.0, dy: 3.0)
        
        let view = UIView(frame: vFrame)
        
        view.layer.cornerRadius = 0.0
        
        view.layer.borderColor = borderColor.cgColor
        view.layer.borderWidth = 0.0
        
        view.center = CGPoint(x: self.bounds.size.width * 0.5, y: self.bounds.size.height * 0.5)
        
        view.backgroundColor = UIColor.clear
        
        
        return view
    }()
    
    lazy var textLabel : UILabel = {
       
        let lbl = UILabel()
        lbl.textAlignment = NSTextAlignment.center
        
        
        lbl.textColor = UIColor.black
        
        return lbl
        
    }()
    
    lazy var dotsView : UIView = {
        
        let frm = CGRect(x: 8.0, y: self.frame.size.width - 10.0 - 4.0, width: self.frame.size.width - 16.0, height: 8.0)
        let dv = UIView(frame: frm)
        
        
        return dv
        
    }()

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        
        self.addSubview(self.pBackgroundView)
        
        self.textLabel.frame = self.bounds
        self.addSubview(self.textLabel)
        
        self.addSubview(dotsView)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}
