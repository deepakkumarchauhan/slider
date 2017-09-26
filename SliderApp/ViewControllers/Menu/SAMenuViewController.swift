//
//  SAMenuViewController.swift
//  SliderApp
//
//  Created by Deepak Chauhan on 10/07/17.
//  Copyright © 2017 Mobiloitte. All rights reserved.
//

import UIKit

let menuCellID = "menuCellID"

class SAMenuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    
    //MARK: -  UIView Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialMethod()
        
    }
    
    
    //MARK: -  Custom Method
    func initialMethod() {
        
        // Register TableView
        self.tableView.register(UINib(nibName: "SAMenuTableViewCell", bundle: nil), forCellReuseIdentifier: menuCellID)
        self.tableView.estimatedRowHeight = 60.0
    }
    
    
    //MARK: -  UITableView Datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let menuCell = tableView.dequeueReusableCell(withIdentifier: menuCellID)as! SAMenuTableViewCell
        
        switch indexPath.row {
        case 0:
            menuCell.menuTitleLabel.text = "Home"
            menuCell.menuImageView.image = UIImage(named:"home")
            break
        case 1:
            menuCell.menuTitleLabel.text = "Where Do You Want to Go?"
            menuCell.menuImageView.image = UIImage(named:"go_iconWhite")
            break
        case 2:
            menuCell.menuTitleLabel.text = "Create Event"
            menuCell.menuImageView.image = UIImage(named:"create_event_iconWhite")
            break
        case 3:
            menuCell.menuTitleLabel.text = "My Events"
            menuCell.menuImageView.image = UIImage(named:"myEvent")
            break
        case 4:
            menuCell.menuTitleLabel.text = "Messages"
            menuCell.menuImageView.image = UIImage(named:"message")
            break
        case 5:
            menuCell.menuTitleLabel.text = "Calendar"
            menuCell.menuImageView.image = UIImage(named:"calender_iconWhite")
            break
        case 6:
            menuCell.menuTitleLabel.text = "Notifications"
            menuCell.menuImageView.image = UIImage(named:"notification")
            break
        case 7:
            menuCell.menuTitleLabel.text = "Logout"
            menuCell.menuImageView.image = UIImage(named:"icon14")
            break
            //        case 5:
            //            menuCell.menuTitleLabel.text = "Price"
            //            menuCell.menuImageView.image = UIImage(named:"paid_icon")
            //            break
            
        default:
            break
        }
        
        return menuCell
        
    }
    
    //MARK: -  UITableView Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let drawerController = kAppDelegate.navigationController?.topViewController as! KYDrawerController
        
        let navigationController:UINavigationController?
        
        if let navController = drawerController.mainViewController as? UINavigationController {
            
            navigationController = navController
            
            navController.popToRootViewController(animated: false)
        } else {
            navigationController = UINavigationController()
            navigationController!.isNavigationBarHidden = true
        }
        
        switch indexPath.row {
        case 0:
            let vc = SATabBarViewController(nibName: "SATabBarViewController", bundle: nil)
            navigationController!.setViewControllers([vc], animated: false)
            drawerController.mainViewController = navigationController!
            drawerController .setDrawerState(.closed, animated: true)
            break
            
        case 1:
            let vc = SAHomeMapVC(nibName: "SAHomeMapVC", bundle: nil)
            vc.isFromSidePannel = true
            navigationController!.setViewControllers([vc], animated: false)
            drawerController.mainViewController = navigationController!
            drawerController .setDrawerState(.closed, animated: true)
            break
            
        case 2:
            
            DispatchQueue.main.async
                {
            let vc = SACreateEventViewController(nibName: "SACreateEventViewController", bundle: nil)
            navigationController!.setViewControllers([vc], animated: false)
            drawerController.mainViewController = navigationController!
            drawerController .setDrawerState(.closed, animated: true)
            }
            break
            
        case 3:
            let vc = SAEventListViewController(nibName: "SAEventListViewController", bundle: nil)
            vc.isFromSideMenu = true
            vc.navigationTitle = "My Events"
            navigationController!.setViewControllers([vc], animated: false)
            drawerController.mainViewController = navigationController!
            drawerController .setDrawerState(.closed, animated: true)
            break
            
        case 4:
            let vc = SAMessageViewController(nibName: "SAMessageViewController", bundle: nil)
            navigationController!.setViewControllers([vc], animated: false)
            drawerController.mainViewController = navigationController!
            drawerController .setDrawerState(.closed, animated: true)
            break
            
        case 5:
            let vc = SACalendarViewController(nibName: "SACalendarViewController", bundle: nil)
            navigationController!.setViewControllers([vc], animated: false)
            drawerController.mainViewController = navigationController!
            drawerController .setDrawerState(.closed, animated: true)
            break
            
        case 6:
            let vc = SANotificationViewController(nibName: "SANotificationViewController", bundle: nil)
            navigationController!.setViewControllers([vc], animated: false)
            drawerController.mainViewController = navigationController!
            drawerController .setDrawerState(.closed, animated: true)
            break
            
        case 7:
            
            DispatchQueue.main.async
                {
                    let alertLabelVC = SALogoutVC(nibName: "SALogoutVC", bundle: nil)
                    alertLabelVC.showCommonPopup(with: { (Int) in
                        
                        if (Int == 0) {
                            kAppDelegate.setInitialController()
                           // _ = kAppDelegate.navigationController?.popToRootViewController(animated: true)
                        }
                        
                    }, labelTitle: "Are you sure you want to logout?")
            }
            
            
            break
            
        default:
            break
        }
        
    }
    
    
    //MARK:- Memory Management Methods
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
}
