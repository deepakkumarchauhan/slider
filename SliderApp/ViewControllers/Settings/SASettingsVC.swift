//
//  SASettingsVC.swift
//  SliderApp
//
//  Created by Krati Agarwal on 12/07/17.
//  Copyright © 2017 Mobiloitte. All rights reserved.
//

import UIKit

class SASettingsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    
    var menuTitleArray = [Dictionary<String,Any>]()

    //MARK: - UIViewController Life Cycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetUp()
    }

    //MARK: - Helper Method
    
    func initialSetUp() {
        
        self.tableView.alwaysBounceVertical = false

        // Register TableView
        self.tableView.register(UINib(nibName: "SAimageLabelTVCell", bundle: nil), forCellReuseIdentifier: "SAimageLabelTVCell")
        
        self.menuTitleArray = [["menuTitle" : "Edit Profile" as AnyObject, "imageIcon" : "account_icon" as AnyObject],
                               ["menuTitle" : "Notification" as AnyObject, "imageIcon" : "notification_icon" as AnyObject],
                               ["menuTitle" : "Change Password" as AnyObject, "imageIcon" : "password_icon" as AnyObject],
                               ["menuTitle" : "Terms and Conditions" as AnyObject, "imageIcon" : "edit_icon" as AnyObject],
                               ["menuTitle" : "About Us" as AnyObject,"imageIcon" : "info_icon" as AnyObject],
                               ["menuTitle" : "Contact Us" as AnyObject,"imageIcon" : "contact_icon" as AnyObject]]
        
        let when = DispatchTime.now() + 0.2 
        DispatchQueue.main.asyncAfter(deadline: when) {

            self.tableViewHeightConstraint.constant = self.tableView.contentSize.height
        
        }
    }
    
    //MARK: - UIButton Action Methods
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        _ =   self.navigationController?.popViewController(animated: true)

    }
    
    //MARK: -  UITableView Delegate and Datasource Methods
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return menuTitleArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "SAimageLabelTVCell")as! SAimageLabelTVCell
        
        cell.notificationSwitch.isHidden = (indexPath.row == 1) ? false : true
        
        let menuDict = menuTitleArray[indexPath.row]

        cell.titleLabel.text = menuDict["menuTitle"] as? String
        cell.titleimageView.image = UIImage(named:(menuDict["imageIcon"] as? String)!)
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        
        case 0:
            let editProfileVC = SAEditProfileVC(nibName: "SAEditProfileVC", bundle: nil)
            self.navigationController?.pushViewController(editProfileVC, animated: true)
            
            break
            
        case 2:
            let resetChangePasswordVC = SAResetChangePasswordVC(nibName: "SAResetChangePasswordVC", bundle: nil)
            resetChangePasswordVC.controllerType = .Change_Password
            self.navigationController?.pushViewController(resetChangePasswordVC, animated: true)
            
            break
       
        case 3:
            let termsAboutUsVC = SATermsAboutUsVC(nibName: "SATermsAboutUsVC", bundle: nil)
            termsAboutUsVC.controllerType = .Terms_And_Conditions
            self.navigationController?.pushViewController(termsAboutUsVC, animated: true)
                
            break
        case 4:
            let termsAboutUsVC = SATermsAboutUsVC(nibName: "SATermsAboutUsVC", bundle: nil)
            termsAboutUsVC.controllerType = .About_Us
            self.navigationController?.pushViewController(termsAboutUsVC, animated: true)

            break
            
        case 5:
            let contactUsViewController = SAContactUsViewController(nibName: "SAContactUsViewController", bundle: nil)
            self.navigationController?.pushViewController(contactUsViewController, animated: true)
            
            break
            
        default:
            break
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
