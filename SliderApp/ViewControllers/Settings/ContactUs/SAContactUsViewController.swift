//
//  SAContactUsViewController.swift
//  SliderApp
//
//  Created by Deepak Chauhan on 07/07/17.
//  Copyright © 2017 Mobiloitte. All rights reserved.
//

import UIKit

let signUpCellID = "signUpCellID"
let contactUsUpCellID = "contactUsCellID"


class SAContactUsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate {

    @IBOutlet var haveAQuestionLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    var userInfo = SAUserInfo()

    //MARK: -  UIView Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialMethod()

    }
    
    
    //MARK: -  Custom Method
    func initialMethod() {
        
        self.tableView.alwaysBounceVertical = false
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        self.haveAQuestionLabel.text = "Have a Question?\nGet in Touch"
        self.tableView.register(UINib(nibName: "SASignUpTableViewCell", bundle: nil), forCellReuseIdentifier: signUpCellID)
        self.tableView.register(UINib(nibName: "SAContactUsTableViewCell", bundle: nil), forCellReuseIdentifier: contactUsUpCellID)
        
    }
    
    
    func validateFields() -> Bool {
        
        if (userInfo.firstName.length == 0) {
            presentAlert("", msgStr: blank_FirstName, controller: self)
        }
        else if ((userInfo.firstName.length) < 3) {
            presentAlert("", msgStr: valid_FirstName, controller: self)
        }
        else if (userInfo.lastName.length == 0) {
            presentAlert("", msgStr: blank_LastName, controller: self)
        }
        else if ((userInfo.lastName.length) < 3) {
            presentAlert("", msgStr: valid_LastName, controller: self)
        }
        else if (userInfo.email.length == 0) {
            presentAlert("", msgStr: blank_Email, controller: self)
        }
        else if (!(userInfo.email.isEmail())) {
            presentAlert("", msgStr: valid_Email, controller: self)
        }
        else if (userInfo.message.length == 0) {
            presentAlert("", msgStr: blank_Message, controller: self)
        }
        else {
            return true
        }
        
        return false
    }

    
    //MARK: -  UITableView Datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)as! SASignUpTableViewCell
        
        let cellMessage = tableView.dequeueReusableCell(withIdentifier: contactUsUpCellID)as! SAContactUsTableViewCell
        
        cell.purpleTopUpLabel.isHidden = true
        cell.purpleTopDownLabel.isHidden = true
        cell.purpleDownDownLabel.isHidden = true
        cell.purpleDownLeftLabel.isHidden = true
        cell.locationImageView.isHidden = true
        cell.signUpTextField.tag = indexPath.row+100

        cell.signUpTextField.delegate = self
        cellMessage.messageTextView.delegate = self

        cell.signUpTextField.returnKeyType = UIReturnKeyType.next;
        cell.signUpTextField.autocapitalizationType = UITextAutocapitalizationType.sentences
        
        switch indexPath.row {
        case 0:
            cell.signUpTextField.placeholder = "First Name"
            cell.purpleTopUpLabel.isHidden = false
            cell.signUpTextField.text = userInfo.firstName
            cell.purpleTopDownLabel.isHidden = false
            break
            
        case 1:
            cell.signUpTextField.placeholder = "Last Name"
            cell.signUpTextField.text = userInfo.lastName
            break
            
        case 2:
            cell.signUpTextField.autocapitalizationType = UITextAutocapitalizationType.none
            cell.signUpTextField.placeholder = "Email"
            cell.signUpTextField.text = userInfo.email
            break
            
        default:
        //    cellMessage.messageTextView.text = "Message"
            cellMessage.messageTextView.tag = indexPath.row+100
            cellMessage.messageTextView.text = userInfo.message
            return cellMessage
        }
        
        return cell
    }
    
    
    //MARK: -  UITableView Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 3 {
           return 150.0
        }
        return 40.0
    }

    
    //MARK: -  UITextField Delegate
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        

        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        switch textField.tag {
        case 100:
            userInfo.firstName = (textField.text?.trimWhiteSpace())!
            break;
        case 101:
            userInfo.lastName = (textField.text?.trimWhiteSpace())!
            break;
        case 102:
            userInfo.email = (textField.text?.trimWhiteSpace())!
            break;
            
        default:
            break
        }
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var str:NSString = textField.text! as NSString
        str = str.replacingCharacters(in: range, with: string) as NSString
        
        if !string.canBeConverted(to: String.Encoding.ascii){
            return false
        }

        if ((textField.tag == 100  || textField.tag == 101) && str.length > 50) {
            return false
        }
        else if(textField.tag == 102 && str.length > 60) {
            return false
        }
        
        return true
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField.returnKeyType == UIReturnKeyType.next {
            
            if textField.tag == 102 {
                let txtView1 = self.view.viewWithTag(textField.tag+1) as? UITextView
                txtView1? .becomeFirstResponder()
            }else {
                let txtField1 = self.view.viewWithTag(textField.tag+1) as? UITextField
                txtField1? .becomeFirstResponder()
            }
        }else {
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    //MARK: -  UITextView Delegate
    func textViewDidEndEditing(_ textView: UITextView) {
        
         userInfo.message = (textView.text?.trimWhiteSpace())!
        print( userInfo.message)
    }
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        var str:NSString = textView.text! as NSString
        str = str.replacingCharacters(in: range, with: text) as NSString
        
        if (TRIM_SPACE(str: str) as AnyObject).length > 500 {
            return false
        }
        return true
    }
    

    //MARK:- UIButton Action
    @IBAction func backButtonAction(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func sendMessageButtonAction(_ sender: UIButton) {
        
        self.view .endEditing(true)
        if self.validateFields() {
            presentAlert("", msgStr: "Thanks! Our team has jumped into action and we'll get in touch with you shortly.", controller: self)
        }
    }
    
    //MARK:- Memory Management Methods
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
