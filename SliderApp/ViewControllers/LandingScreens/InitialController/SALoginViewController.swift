//
//  SALoginViewController.swift
//  SliderApp
//
//  Created by Deepak Chauhan on 05/07/17.
//  Copyright © 2017 Mobiloitte. All rights reserved.
//

import UIKit


class SALoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: SATexFieldSubClass!
    @IBOutlet weak var passwordTextField: SATexFieldSubClass!
    @IBOutlet weak var rememberMeButton: UIButton!
    
    @IBOutlet var emailConstraint: NSLayoutConstraint!
    
    //MARK: -  UIView Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initialMethod()
    }
    
    //MARK: -  Custom Method
    func initialMethod() {
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        if Window_Width > 320 {
            self.emailConstraint.constant = 10.0
        }
        
    }
    
    func validateFields() -> Bool {
        
        let str = self.emailTextField.text

        if (self.emailTextField.text?.trimWhiteSpace().length == 0) {
            presentAlert("", msgStr: blank_EmailAndUsername, controller: self)
        }
        else if (str?.range(of: "@") != nil && !(self.emailTextField.text?.isEmail())!){
            presentAlert("", msgStr: valid_Email, controller: self)
        }
        else if (str?.range(of: "@") == nil && (self.emailTextField.text?.length)! < 3){
            presentAlert("", msgStr: blank_ValidUserName, controller: self)
        }
        else if (str?.range(of: "@") == nil && !(self.emailTextField.text?.containsAlphaNumericOnly())!){
            presentAlert("", msgStr: blank_MaxLengthUserName, controller: self)
        }
        else if (self.passwordTextField.text?.trimWhiteSpace().length == 0) {
            presentAlert("", msgStr: blank_Password, controller: self)
        }
        else if ((self.passwordTextField.text?.trimWhiteSpace().length)! < 8) {
            presentAlert("", msgStr: valid_Password, controller: self)
            
        }
        else {
            return true
        }
        
        return false
    }
    
    
    //MARK:- UITextField Delegate Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField.returnKeyType == UIReturnKeyType.next {
            
            let txtField1 = self.view.viewWithTag(textField.tag+1) as? UITextField
            txtField1? .becomeFirstResponder()
        }else {
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var str:NSString = textField.text! as NSString
        str = str.replacingCharacters(in: range, with: string) as NSString
        
        if !string.canBeConverted(to: String.Encoding.ascii){
            return false
        }
        
        if (str.length > 60 && textField.tag == 100) {
            return false
        }
        else if(str.length > 16 && textField.tag == 101) {
            return false
        }
        
        return true
    }
    
    
    //MARK:- UIButton Action
    @IBAction func loginButtonAction(_ sender: UIButton) {
        self.view .endEditing(true)
        
        if self.validateFields() {
            
            if self.rememberMeButton.isSelected {
                UserDefaults.standard.set(true, forKey: "IsRemember")
            }else {
                UserDefaults.standard.set(false, forKey: "IsRemember")
             }
            
            DispatchQueue.main.async
                {
                    let vc = SAHomeMapVC(nibName: "SAHomeMapVC", bundle: nil)
                    self.navigationController!.pushViewController(vc, animated: true)
            }
        }
    }
    
    
    @IBAction func rememberMeButtonAction(_ sender: UIButton) {
        
        self.view .endEditing(true)
        
        self.rememberMeButton.isSelected = !self.rememberMeButton.isSelected
        
    }
    
    @IBAction func signUpButtonAction(_ sender: UIButton) {
        
        DispatchQueue.main.async
            {
        let vc = SASignUpViewController(nibName: "SASignUpViewController", bundle: nil)
        self.navigationController!.pushViewController(vc, animated: true)
        }
        
    }
    
    @IBAction func forgotButtonAction(_ sender: UIButton) {
        self.view .endEditing(true)
        
        let vc = SAForgotPasswordVC(nibName: "SAForgotPasswordVC", bundle: nil)
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    @IBAction func faceBookButtonAction(_ sender: UIButton) {
        presentAlert("", msgStr: "Work in progress.", controller: self)
        
    }
    
    
    @IBAction func twitterButtonAction(_ sender: UIButton) {
        presentAlert("", msgStr: "Work in progress.", controller: self)
    }
    
    
    @IBAction func googlePlusButtonAction(_ sender: UIButton) {
        presentAlert("", msgStr: "Work in progress.", controller: self)
    }
    
    
    //MARK:- Memory Management Methods
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
}
