//
//  SAAppUtility.swift
//  SliderApp
//
//  Created by Krati Agarwal on 10/07/17.
//  Copyright © 2017 Mobiloitte. All rights reserved.
//

import UIKit

class SAAppUtility: NSObject {
    
    class func addToolBarOnView(_ controller: UIViewController)->UIToolbar {
        
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: Window_Width, height: 50))
        doneToolbar.barStyle       = UIBarStyle.default
        let flexSpace              = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: controller, action: #selector(doneButtonAction))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        return doneToolbar
    }
    
   @objc func doneButtonAction() {
        
    }

}

func getStringFromDate(date: Date) -> String {
    
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let myString = formatter.string(from: date)
    let yourDate: Date? = formatter.date(from: myString)
    formatter.dateFormat = "dd MMM yyyy"

    let updatedString = formatter.string(from: yourDate!)
    return updatedString
    
}

func getStringFromTime(date: Date)-> String {
    
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let myString = formatter.string(from: date)
    let yourDate: Date? = formatter.date(from: myString)
    formatter.dateFormat = "hh:mm aa"
    let updatedString = formatter.string(from: yourDate!)
    return updatedString
    
}

func getDayOfWeek(today:String)->String {
    
    print("\(today)")
    
    let formatter  = DateFormatter()
    formatter.dateFormat = "dd MMM yyyy"
    let todayDate = formatter.date(from:today)!
    
    let myCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
    let myComponents = myCalendar.components(.weekday, from: todayDate)
    let weekDay = myComponents.weekday! as Int
    
    switch weekDay {
    case 1:
        return "Sunday"
        
    case 2:
        return "Monday"
        
    case 3:
        return "Tuesday"
        
    case 4:
        return "Wednesday"
        
    case 5:
        return "Thursday"
        
    case 6:
        return "Friday"
        
    case 7:
        return "Saturday"
        
    default:
        print("Error fetching days")
        return "Day"
    }

}

func getDay(today:String)->Int {
    
    print("\(today)")
    
    let formatter  = DateFormatter()
    formatter.dateFormat = "dd MMM yyyy"
    let todayDate = formatter.date(from:today)!
    
    let myCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
    let myComponents = myCalendar.components(.day, from: todayDate)
    let day = myComponents.day! as Int
    
    return day
    
  }


