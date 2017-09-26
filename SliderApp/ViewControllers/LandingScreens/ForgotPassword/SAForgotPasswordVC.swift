//
//  SAForgotPasswordVC.swift
//  SliderApp
//
//  Created by Krati Agarwal on 05/07/17.
//  Copyright © 2017 Mobiloitte. All rights reserved.
//

import UIKit

class SAForgotPasswordVC: UIViewController {

    @IBOutlet weak var emailIdTextField: SATexFieldSubClass!
    
    //MARK:- UIViewController LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.initialSetUp()
    }
    
    //MARK:- Helper Methods

    func initialSetUp() {
    
        self.navigationController?.navigationBar.isHidden = true

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
    //MARK:- Validation Methods
    
    func validateOnNextButton() -> Bool {
        
        var isAllValid: Bool = false
        
        if (self.emailIdTextField.text?.trimWhiteSpace().length == 0) {
            presentAlert("", msgStr: blank_Email, controller: self)
            
        } else if (!(self.emailIdTextField.text?.isEmail())!) {
            presentAlert("", msgStr: valid_Email, controller: self)
            
        } else {
            isAllValid = true
        }
        
        return isAllValid
    }
    
    //MARK:- UITextField Delegate Methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var str:NSString = textField.text! as NSString
        str = str.replacingCharacters(in: range, with: string) as NSString
        
        if (str.length > 60) {
            return false
        }
        
        return true
    }

    //MARK:- UIButton Action Methods

    @IBAction func sendButtonAction(_ sender: UIButton) {
        
        self.view .endEditing(true)
        
        if validateOnNextButton() {
            
            let alertLabelVC = SAAlertLabelVC(nibName: "SAAlertLabelVC", bundle: nil)

            alertLabelVC.showCommonPopup(with: { (Int) in
                
                let resetChangePasswordVC = SAResetChangePasswordVC(nibName: "SAResetChangePasswordVC", bundle: nil)
                resetChangePasswordVC.controllerType = .Reset_Password
                self.navigationController?.pushViewController(resetChangePasswordVC, animated: true)

                
            }, labelTitle: "We have sent you link on your Email Id. Please click on that for reset password.", dissmissOnTap: false)
        }
        

    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
       
        self.view .endEditing(true)
        _ =   self.navigationController?.popViewController(animated: true)
    
    }
    
    // MARK: - Memory Handling Methods

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
