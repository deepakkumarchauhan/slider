//
//  SAResetChangePasswordVC.swift
//  SliderApp
//
//  Created by Krati Agarwal on 05/07/17.
//  Copyright © 2017 Mobiloitte. All rights reserved.
//

import UIKit

class SAResetChangePasswordVC: UIViewController, UITextFieldDelegate {

    enum enum_password{
        case Reset_Password
        case Change_Password
    }
    
    var controllerType = enum_password.Reset_Password

    @IBOutlet weak var currentPasswordTextField: SATexFieldSubClass!
    @IBOutlet weak var newPasswordTextField: SATexFieldSubClass!
    @IBOutlet weak var confirmPasswordField: SATexFieldSubClass!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var submitResetButton: UIButton!
    
    @IBOutlet weak var navigationBarTitleLabel: UILabel!
    
    @IBOutlet weak var currentPasswordHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var currentPasswordBottomConstraint: NSLayoutConstraint!
  
    //MARK: - UIViewController Life Cycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
    }

    //MARK: - Helper Method

    func initialSetup() {
    
    if (controllerType == .Reset_Password) {
    
        self.backButton.isHidden = true
        self.currentPasswordTextField.isHidden = true
        self.submitResetButton .setTitle("RESET", for: UIControlState.normal)
        self.navigationBarTitleLabel.text = "Reset Password"
        self.currentPasswordHeightConstraint.constant = 0
        self.currentPasswordBottomConstraint.constant = 0
    
    } else {
    
        self.submitResetButton .setTitle("SUBMIT", for: UIControlState.normal)
        self.navigationBarTitleLabel.text = "Change Password"
    
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view .endEditing(true)
        
    }
    
    //MARK: - Validation Method
    
    func validateOnSaveButton() -> Bool {
        
        let isAllValid: Bool = true
        
        if controllerType == .Reset_Password {
            
            if (TRIM_SPACE(str: newPasswordTextField.text ?? "") as AnyObject).length == 0 {
                presentAlert("", msgStr: blank_New_Password, controller: self)

                return false
            }
            else if ((TRIM_SPACE(str: newPasswordTextField.text ?? "") as AnyObject).length < 8) {
                presentAlert("", msgStr: valid_New_Password, controller: self)
                return false
            }
            else if ((TRIM_SPACE(str: confirmPasswordField.text ?? "") as AnyObject).length == 0) {
                presentAlert("", msgStr: blank_ConfirmPassword, controller: self)

                return false
            }
            else if !(newPasswordTextField.text == confirmPasswordField.text) {
                presentAlert("", msgStr: password_Confirm_Password_Not_Match, controller: self)

                return false
            }
        }
        else {
            if ((TRIM_SPACE(str: currentPasswordTextField.text ?? "") as AnyObject).length == 0) {
                presentAlert("", msgStr: blank_Old_Password, controller: self)
                return false
            }
            else if (TRIM_SPACE(str: currentPasswordTextField.text ?? "") as AnyObject).length < 8 {
                presentAlert("", msgStr: valid_Old_Password, controller: self)
                return false
            }
            else if ((TRIM_SPACE(str: newPasswordTextField.text ?? "") as AnyObject).length  == 0){
                presentAlert("", msgStr: blank_New_Password, controller: self)
                return false
            }
            else if (TRIM_SPACE(str: newPasswordTextField.text ?? "") as AnyObject).length < 8 {
                presentAlert("", msgStr: valid_New_Password, controller: self)
                return false
            }
            else if ((TRIM_SPACE(str: confirmPasswordField.text ?? "") as AnyObject).length == 0) {
                presentAlert("", msgStr: blank_ConfirmPassword, controller: self)
                return false
            }
            else if !(newPasswordTextField.text == confirmPasswordField.text) {
                presentAlert("", msgStr: password_Confirm_Password_Not_Match, controller: self)
                return false
            }
        }
        return isAllValid
    }
    
    //MARK:- UITextField Delegate Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view .endEditing(true)
       
        if (textField.returnKeyType == UIReturnKeyType.next) {
            self.view .viewWithTag(textField.tag + 1)?.becomeFirstResponder()
            
        } else {
            
            textField .resignFirstResponder()
        }
    
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var str:NSString = textField.text! as NSString
        str = str.replacingCharacters(in: range, with: string) as NSString
        
        if (textField.tag == 100 || textField.tag == 101) {
            
            if (str.length > 16) { // upper limit of password 16
                return false
            }
        }
        
        // Check if input by user is emoji or not
        
        return true
        
    }
    
    //MARK: - UIButton Action Methods
    
    @IBAction func submitResetButtonAction(_ sender: UIButton) {
        
        self.view .endEditing(true)
        
        if validateOnSaveButton() {
            
            if controllerType == .Reset_Password {
            
                _ =     presentAlertWithOptions("", message: "Password changed successfully.", controller: self, buttons: ["OK"], tapBlock: { (UIAlertAction, Int) in
                    
                    _ =    self.navigationController?.popToRootViewController(animated: true)
                })
                
            } else {
                
                _ =     presentAlertWithOptions("", message: "Password changed successfully.", controller: self, buttons: ["OK"], tapBlock: { (UIAlertAction, Int) in
                    
                    _ =   self.navigationController?.popViewController(animated: true)
                })
           
            }
        }
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.view .endEditing(true)
        _ =   self.navigationController?.popViewController(animated: true)

    }
    
    //MARK: - Memory Handling

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
