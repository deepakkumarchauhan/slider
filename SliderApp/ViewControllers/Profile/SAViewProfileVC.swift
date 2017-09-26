//
//  SAViewProfileVC.swift
//  SliderApp
//
//  Created by Krati Agarwal on 12/07/17.
//  Copyright © 2017 Mobiloitte. All rights reserved.
//

import UIKit

class SAViewProfileVC: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var joinedDateLabel: UILabel!
    
    @IBOutlet weak var userProfileImageView: UIImageView!
    
    var userInfoObj = SAUserInfo()

    //MARK: -  UIView Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        dummyData()
        setData()
    }
 
    //MARK: -  Helper Methods

    func dummyData() {
        
        userInfoObj.fullName = "John Cena"
        userInfoObj.location = "Florida"
        userInfoObj.joinedDate = "5 June 2017"

    }
    
    func setData() {
        
      self.nameLabel.text = userInfoObj.fullName
      self.cityLabel.text = userInfoObj.location
      self.joinedDateLabel.text = "Joined" + " " + userInfoObj.joinedDate
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
