//
//  SAOTPVerificationVC.swift
//  SliderApp
//
//  Created by Krati Agarwal on 05/07/17.
//  Copyright © 2017 Mobiloitte. All rights reserved.
//

import UIKit

typealias otpVerificationCompletionBlock = (_ index: Int) -> Void

class SAOTPVerificationVC: UIViewController,UITextFieldDelegate {

    @IBOutlet var alertView: UIView!
    @IBOutlet weak var otpTextField: UITextField!
    
    var completionBlock: otpVerificationCompletionBlock?

    //MARK: - UIViewController Life Cycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setShadowOnTextFeild()
        setShadowOfAlertView()
    }

    //MARK: - Helper Method
    
    func setShadowOnTextFeild() {
    
    self.otpTextField.layer.masksToBounds = false
    self.otpTextField.layer.shadowRadius = 2.0
    self.otpTextField.layer.shadowColor = UIColor.lightGray.cgColor
    self.otpTextField.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
    self.otpTextField.layer.shadowOpacity = 1
    
    }
    
    func setShadowOfAlertView() {
        
        self.alertView.layer.masksToBounds = false
        self.alertView.layer.shadowRadius = 2.0
        self.alertView.layer.shadowColor = UIColor.black.cgColor
        self.alertView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.alertView.layer.shadowOpacity = 1
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view .endEditing(true)
    }
    
    func getRootController() -> AnyObject {
        
        var rootViewController = UIApplication.shared.delegate?.window??.rootViewController as AnyObject
        
        if (rootViewController is(UINavigationController)) {
            rootViewController = ((rootViewController as? UINavigationController)?.viewControllers[0])!
        }
        
        return rootViewController
    }
    
    func dismiss() {
        self.dismiss(animated: false, completion: nil)
        
    }
    
    //MARK: -  UITextField Delegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        textField.inputAccessoryView = SAAppUtility.addToolBarOnView(self)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var str:NSString = textField.text! as NSString
        str = str.replacingCharacters(in: range, with: string) as NSString
        
        if (str.length > 6) {
            return false
        }
    
        return true
    }


    func doneButtonAction() {
        
        self.view .endEditing(true)
    }
    
    //MARK: Public Methods
    
    func showCommonPopup(with block: @escaping otpVerificationCompletionBlock) {
        
        self.view .layoutIfNeeded()
        
        UIView .animate(withDuration: 3.0) {
            self.view .layoutIfNeeded()
            self.modalPresentationStyle = UIModalPresentationStyle.custom
            self.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal;
            
            self.getRootController().present(self, animated: false, completion: {() -> Void in

            })
            self.completionBlock = block
        }
    }

    
    func validateOnOkButton() -> Bool {
        
        var isAllValid: Bool = false
        
        if (self.otpTextField.text?.trimWhiteSpace().length == 0) {
            presentAlert("", msgStr: blank_OTP, controller: self)
            
        } else if ((self.otpTextField.text?.length)! < 6) {
            presentAlert("", msgStr: six_Digit_OTP, controller: self)
            
        } else {
            isAllValid = true
        }
        
        return isAllValid
    }
    
    //MARK: - UIButton Action Methods

    @IBAction func resendOtpButtonAction(_ sender: UIButton) {
        self.view .endEditing(true)
    }
    
    @IBAction func okButtonAction(_ sender: UIButton) {
        
        self.view .endEditing(true)

        if validateOnOkButton() {
         
            self.dismiss()
            self.completionBlock!(0)
        
        }
    
    }
    
    //MARK: - Memory Handling

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
