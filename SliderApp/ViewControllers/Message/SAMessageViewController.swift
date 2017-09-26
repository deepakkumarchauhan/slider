//
//  SAMessageViewController.swift
//  SliderApp
//
//  Created by Deepak Chauhan on 12/07/17.
//  Copyright © 2017 Mobiloitte. All rights reserved.
//

import UIKit

let cellMessageIdentifier = "interestedCellId"

class SAMessageViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    
    @IBOutlet var searchTextField: SATexFieldSubClass!
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var backButton: UIButton!
    @IBOutlet var addButton: UIButton!
    
    @IBOutlet var tableBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet var doneButton: UIButton!
    @IBOutlet var navigationTitleLabel: UILabel!
    
    var messageArray = NSMutableArray()
    
    //MARK: -  UIView Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialMethod()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    //MARK: -  Custom Method
    func initialMethod() {
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        // Register TableView
        self.tableView.register(UINib(nibName: "SAInterestedPeopleTableViewCell", bundle: nil), forCellReuseIdentifier: cellInterestedIdentifier)
        
        let messageTempArray: [String] = ["John Hilter","Jackob Won","William","Andrew Tom","Hitlor","Johney","My Group"]
        
        
        for name in messageTempArray {
            let messageInfo = SAMessage()
            messageInfo.isSelect = false
            messageInfo.userName = name
            messageArray.add(messageInfo)
        }
    }
    
    
    //MARK: -  UITableView Datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellInterestedIdentifier)as! SAInterestedPeopleTableViewCell
        cell.connectButton.isHidden = true
        
        let messageInfo = messageArray[indexPath.row] as! SAMessage
        
        cell.nameLabel.text = messageInfo.userName
        cell.connectButton.tag = indexPath.row+100
        
        if messageInfo.isSelect {
            cell.contentView.backgroundColor = UIColor.lightGray
            cell.contentView.backgroundColor?.withAlphaComponent(0.1)
        }else{
            cell.contentView.backgroundColor = UIColor.clear
        }
        
        return cell
    }
    
    
    //MARK: -  UITableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 6 {
            let vc = SAChatViewController(nibName: "SAChatViewController", bundle: nil)
            vc.isGroupChat = true
            self.navigationController!.pushViewController(vc, animated: true)
        }else {
            let vc = SAChatViewController(nibName: "SAChatViewController", bundle: nil)
            let messageInfo = messageArray[indexPath.row] as! SAMessage
            vc.userName = messageInfo.userName
            self.navigationController!.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let cell = tableView.cellForRow(at: indexPath) as! SAInterestedPeopleTableViewCell
        
        let deleteAction = UITableViewRowAction(style: .default, title: "") { action, index in
            
            //  print("more button tapped")
            
            _ =     presentAlertWithOptions("", message: "Are you sure you want to remove this user?", controller: self, buttons: ["Yes","No"], tapBlock: { (UIAlertAction, position) in
                
                if position == 0 {
                    self.messageArray.removeObject(at: indexPath.row)
                    self.tableView.reloadData()
                }
                
            })
        }
        
        let imageView = UIImageView(image: UIImage(named: "delete")!)
        
        imageView.frame = CGRect(x:cell.frame.size.width-2, y:(cell.frame.size.height/2) - 5, width:30, height:30)
        
        imageView.contentMode = .scaleAspectFit
        cell.contentView .addSubview(imageView)
        
        deleteAction.backgroundColor = UIColor.clear
        
        return [deleteAction];
        
        
    }
    
    
    //MARK:- UITextField Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view .endEditing(true)
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var str:NSString = textField.text! as NSString
        str = str.replacingCharacters(in: range, with: string) as NSString
        
        if (str.length > 100) {
            return false
        }
        
        return true
    }
    
    
    //MARK:- UIButton Action
    @IBAction func menuButtonAction(_ sender: Any) {
        
        let drawerController = self.navigationController?.parent as! KYDrawerController
        drawerController.setDrawerState(.opened, animated: true)
    }
    
    
    @IBAction func searchButtonAction(_ sender: UIButton) {
        
    }
    
    @IBAction func addGroupButtonAction(_ sender: UIButton) {
        
        //        presentAlert("", msgStr: "Work in progress.", controller: self)
        
        let vc = SAContactViewController(nibName: "SAContactViewController", bundle: nil)
        self.navigationController!.pushViewController(vc, animated: true)
        
    }
    
    //MARK:- Memory Management Methods
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
