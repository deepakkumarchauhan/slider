//
//  SAContactViewController.swift
//  SliderApp
//
//  Created by Deepak Chauhan on 17/07/17.
//  Copyright © 2017 Mobiloitte. All rights reserved.
//

import UIKit

class SAContactViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {

    @IBOutlet var tableView: UITableView!
    
    var messageArray = NSMutableArray()

    @IBOutlet var searchTextField: SATexFieldSubClass!
    //MARK: -  UIView Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
          self.initialMethod()
    }

    
    //MARK: -  Custom Method
    func initialMethod() {
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        // Register TableView
        self.tableView.register(UINib(nibName: "SAInterestedPeopleTableViewCell", bundle: nil), forCellReuseIdentifier: cellInterestedIdentifier)
        
        let messageTempArray: [String] = ["John Hilter","Jackob Won","William","Andrew Tom","Hitlor","Johney"]
        
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
            cell.contentView.backgroundColor = UIColor.init(colorLiteralRed: 214.0/255.0, green: 214.0/255.0, blue: 214.0/255.0, alpha: 0.5)
        }else{
            cell.contentView.backgroundColor = UIColor.clear
        }
        
        return cell
    }
    
    
    //MARK: -  UITableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let messageInfo = messageArray[indexPath.row] as! SAMessage
        messageInfo.isSelect = !messageInfo.isSelect
        self.tableView .reloadData()
      
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
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

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //MARK:- UIButton Action
    @IBAction func backButtonAction(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)

    }

    @IBAction func nextButtonAction(_ sender: UIButton) {
        
        var isSelectRow: Bool = false
        
        for messageInfoClass in messageArray {
            if (messageInfoClass as! SAMessage).isSelect == true {
                isSelectRow = true
                break
            }
        }
        if isSelectRow {
            let vc = SAAddGroupSubjectViewController(nibName: "SAAddGroupSubjectViewController", bundle: nil)
            self.navigationController!.pushViewController(vc, animated: true)
        }else {
            presentAlert("", msgStr: blank_User, controller: self)
            
        }

    }
}
