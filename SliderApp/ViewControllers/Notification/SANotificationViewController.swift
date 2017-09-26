//
//  SANotificationViewController.swift
//  SliderApp
//
//  Created by Deepak Chauhan on 12/07/17.
//  Copyright © 2017 Mobiloitte. All rights reserved.
//

import UIKit
let notificationCellIdentifier = "notificationCellID"

class SANotificationViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet var tableView: UITableView!

    var notificationArray: [String] = ["John is connected to you.","Jackob booked a ticket."]

    //MARK: -  UIView Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialMethod()

    }
    
    //MARK: -  Custom Method
    func initialMethod() {
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        self.tableView.estimatedRowHeight = 75.0
        
        // Register TableView
        self.tableView.register(UINib(nibName: "SANotificationTableViewCell", bundle: nil), forCellReuseIdentifier: notificationCellIdentifier)
    }
    
    //MARK: -  UITableView Datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: notificationCellIdentifier)as! SANotificationTableViewCell
        
        cell.notificationTitleLabel.text = self.notificationArray[indexPath.row]
        
        return cell
    }
    
    
    //MARK: -  UITableView Delegate
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let cell = tableView.cellForRow(at: indexPath) as! SANotificationTableViewCell
        
        let deleteAction = UITableViewRowAction(style: .default, title: "") { action, index in
            
        //    print("more button tapped")
            
            self.notificationArray.remove(at: index.row)
            
            self.tableView.reloadData()
            
        }
        
        let imageView = UIImageView(image: UIImage(named: "delete")!)
        
        imageView.frame = CGRect(x:cell.frame.size.width-2, y:(cell.frame.size.height/2) - 15, width:30, height:30)
        
        imageView.contentMode = .scaleAspectFit
        cell.contentView .addSubview(imageView)
        
        deleteAction.backgroundColor = UIColor.clear
        
        return [deleteAction];
        
    }

    //MARK:- UIButton Action
    @IBAction func menuButtonAction(_ sender: UIButton) {
        
        let drawerController = self.navigationController?.parent as! KYDrawerController
        drawerController.setDrawerState(.opened, animated: true)
    }
    
    
    //MARK:- Memory Management Methods
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
