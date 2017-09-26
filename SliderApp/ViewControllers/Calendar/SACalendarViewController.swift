//
//  SACalendarViewController.swift
//  SliderApp
//
//  Created by Deepak Chauhan on 12/07/17.
//  Copyright © 2017 Mobiloitte. All rights reserved.
//

import UIKit

class SACalendarViewController: UIViewController,CalendarViewDataSource, CalendarViewDelegate {
    
    @IBOutlet var menuButton: UIButton!
    @IBOutlet var calendarView: CalendarView!
    var fromHome = Bool()
    
    //MARK: -  UIView Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialMethod()
    }
    
    
    //MARK: -  Custom Method
    func initialMethod() {
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        if fromHome {
            menuButton.setImage(UIImage(named:"back_icon"), for: .normal)
            menuButton.setImage(UIImage(named:"back_icon"), for: .highlighted)
        }
        
        calendarView.dataSource = self
        calendarView.delegate = self
        //        calendarView.displayDate = Date()
        // change the code to get a vertical calender.
        calendarView.direction = .horizontal
        
    }
    
    // MARK : KDCalendarDataSource
    func startDate() -> Date? {
        
        var dateComponents = DateComponents()
        dateComponents.month = -3
        
        let today = Date()
        
        // let threeMonthsAgo = (self.calendarView.calendar as NSCalendar).date(byAdding: dateComponents, to: today, options: NSCalendar.Options())
        
        
        return today
    }
    
    func endDate() -> Date? {
        
        var dateComponents = DateComponents()
        
        dateComponents.year = 5;
        let today = Date()
        
        let twoYearsFromNow = (self.calendarView.calendar as NSCalendar).date(byAdding: dateComponents, to: today, options: NSCalendar.Options())
        
        return twoYearsFromNow
        
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        self.calendarView.frame = self.calendarView.frame
    }
    
    
    // MARK : KDCalendarDelegate
    func calendar(_ calendar: CalendarView, didSelectDate date : Date, withEvents events: [CalendarEvent]) {
        
        print("You have selected \(date) date.")
        //        let vc = SAEventListViewController(nibName: "SAEventListViewController", bundle: nil)
        //        vc.isFromSideMenu = true
        //        vc.isFromSearchMenu = true
        //        vc.navigationTitle = "Events"
        //        self.navigationController!.pushViewController(vc, animated: true)
        
    }
    
    func calendar(_ calendar : CalendarView, canSelectDate date : Date) -> Bool
    {
        print("You have selected \(date) date.")
        
        if fromHome {
            _ = self.navigationController?.popViewController(animated: true)
        }else {
            let vc = SAEventListViewController(nibName: "SAEventListViewController", bundle: nil)
            vc.isFromSideMenu = true
            vc.isFromSearchMenu = true
            vc.navigationTitle = "Events"
            self.navigationController!.pushViewController(vc, animated: true)
        }
        return true
    }
    
    func calendar(_ calendar: CalendarView, didScrollToMonth date : Date) {
        
        //   self.datePicker.setDate(date, animated: true)
    }
    
    
    
    //MARK:- UIButton Action
    @IBAction func menuButtonAction(_ sender: UIButton) {
        
        if fromHome {
            _ = self.navigationController?.popViewController(animated: true)
        }else {
            let drawerController = self.navigationController?.parent as! KYDrawerController
            drawerController.setDrawerState(.opened, animated: true)
        }
    }
    
    //MARK:- Memory Management Methods
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
