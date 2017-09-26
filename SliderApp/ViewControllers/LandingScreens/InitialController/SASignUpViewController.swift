//
//  SASignUpViewController.swift
//  SliderApp
//
//  Created by Deepak Chauhan on 05/07/17.
//  Copyright © 2017 Mobiloitte. All rights reserved.
//

import UIKit
import GooglePlaces


let cellReuseIdentifier = "signUpCellID"

class SASignUpViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet var profileButton: UIButton!
    @IBOutlet var agreebutton: UIButton!
    var picker:UIImagePickerController? = UIImagePickerController()
    @IBOutlet var headerView: UIView!
    var userInfo = SAUserInfo()
    
    
    //MARK: -  UIView Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialMethod()
        
    }
    
    //MARK: -  Custom Method
    func initialMethod() {
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        self.tableView.register(UINib(nibName: "SASignUpTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
        
        self.profileButton.layer.cornerRadius = self.profileButton.layer.frame.size.width/2
        self.profileButton.layer.masksToBounds = true
        
        
        if Window_Width > 320 {
            let rect = CGRect(x: 0, y: 0, width: Window_Width, height: 300)
            self.headerView.frame = rect;
        }
    }
    
    //MARK: -  UITableView Datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)as! SASignUpTableViewCell
        
        cell.purpleTopUpLabel.isHidden = true
        cell.purpleTopDownLabel.isHidden = true
        cell.purpleDownDownLabel.isHidden = true
        cell.purpleDownLeftLabel.isHidden = true
        cell.locationImageView.isHidden = true
        cell.signUpTextField.tag = indexPath.row+100
        cell.signUpTextField.delegate = self
        cell.signUpTextField.returnKeyType = UIReturnKeyType.next;
        cell.signUpTextField.isSecureTextEntry = false
        cell.signUpTextField.keyboardType = .default
        cell.signUpTextField.autocapitalizationType = .none
        cell.signUpTextView.isHidden = true
        
        switch indexPath.row {
        case 0:
            cell.signUpTextField.setCustomPlaceholder(string: "Full Name")
            cell.purpleTopUpLabel.isHidden = false
            cell.signUpTextField.text = userInfo.fullName
            cell.purpleTopDownLabel.isHidden = false
            cell.signUpTextField.autocapitalizationType = .words

            break
            
        case 1:
            cell.signUpTextField.setCustomPlaceholder(string: "Username")
            cell.signUpTextField.text = userInfo.userName
            break
            
        case 2:
            cell.signUpTextField.setCustomPlaceholder(string: "Email ID")
            cell.signUpTextField.text = userInfo.email
            cell.signUpTextField.keyboardType = .emailAddress
            break
            
        case 3:
            cell.signUpTextField.setCustomPlaceholder(string: "Mobile Number")
            cell.signUpTextField.keyboardType = .numberPad
            cell.signUpTextField.text = userInfo.mobile
            break
            
        case 4:
            cell.signUpTextField.setCustomPlaceholder(string: "Password")
            cell.signUpTextField.text = userInfo.password
            cell.signUpTextField.isSecureTextEntry = true
            break
            
        case 5:
            cell.signUpTextField.setCustomPlaceholder(string: "Confirm Password")
            cell.signUpTextField.text = userInfo.confirmPassword
            cell.signUpTextField.isSecureTextEntry = true
            break
            
        case 6:
            cell.signUpTextField.setCustomPlaceholder(string: "Location")
            cell.signUpTextField.text = userInfo.location
            cell.purpleDownDownLabel.isHidden = false
            cell.purpleDownLeftLabel.isHidden = false
            cell.locationImageView.isHidden = false
            cell.signUpTextField.returnKeyType = UIReturnKeyType.done;
            break
            
        default: break
            
        }
        return cell
    }
    
    
    //MARK: -  UITableView Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0;
    }
    
    
    //MARK: -  UITextField Delegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField.tag == 106 {
            
            let autocompleteController = GMSAutocompleteViewController()
            autocompleteController.delegate = self
            present(autocompleteController, animated: true, completion: nil)
 
        }else if textField.tag == 103 {
            
            textField.inputAccessoryView = SAAppUtility.addToolBarOnView(self)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        switch textField.tag {
        case 100:
            userInfo.fullName = (textField.text?.trimWhiteSpace())!
            break;
        case 101:
            userInfo.userName = (textField.text?.trimWhiteSpace())!
            break;
        case 102:
            userInfo.email = (textField.text?.trimWhiteSpace())!
            break;
        case 103:
            userInfo.mobile = (textField.text?.trimWhiteSpace())!
            break;
        case 104:
            userInfo.password = (textField.text?.trimWhiteSpace())!
            break;
        case 105:
            userInfo.confirmPassword = (textField.text?.trimWhiteSpace())!
            break;
        case 106:
            userInfo.location = (textField.text?.trimWhiteSpace())!
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
        else if(textField.tag == 103 && str.length > 15) {
            return false
        }
        else if((textField.tag == 104 || textField.tag == 105) && str.length > 16) {
            return false
        }
        else if(textField.tag == 106 && str.length > 300) {
            return false
        }
        
        return true
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField.returnKeyType == UIReturnKeyType.next {
            
            let txtField1 = self.view.viewWithTag(textField.tag+1) as? UITextField
            txtField1? .becomeFirstResponder()
        }else {
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    func validateFields() -> Bool {
        
        if (userInfo.fullName.length == 0) {
            presentAlert("", msgStr: blank_FullName, controller: self)
        }
        else if ((userInfo.fullName.length) < 3) {
            presentAlert("", msgStr: maxLength_FullName, controller: self)
        }
        else if (userInfo.userName.length == 0) {
            presentAlert("", msgStr: blank_UserName, controller: self)
        }
        else if ((userInfo.userName.length) < 3) {
            presentAlert("", msgStr: blank_ValidUserName, controller: self)
        }
        else if (!(userInfo.userName.containsAlphaNumericOnly())) {
            presentAlert("", msgStr: blank_MaxLengthUserName, controller: self)
        }
        else if (userInfo.email.length == 0) {
            presentAlert("", msgStr: blank_Email, controller: self)
        }
        else if (!(userInfo.email.isEmail())) {
            presentAlert("", msgStr: valid_Email, controller: self)
        }
        else if (userInfo.mobile.length == 0) {
            presentAlert("", msgStr: blank_Mobile, controller: self)
        }
        else if ((userInfo.mobile.length) < 10) {
            presentAlert("", msgStr: maxLength_Mobile, controller: self)
            
        }
        else if (userInfo.password.length == 0) {
            presentAlert("", msgStr: blank_Password, controller: self)
        }
        else if ((userInfo.password.length) < 8) {
            presentAlert("", msgStr: valid_Password, controller: self)
        }
        else if (userInfo.confirmPassword.length == 0) {
            presentAlert("", msgStr: blank_Confirm_Password, controller: self)
        }
        else if (userInfo.confirmPassword != userInfo.password) {
            presentAlert("", msgStr: match_Confirm_Password, controller: self)
        }
        else if (userInfo.location.length == 0) {
            presentAlert("", msgStr: blank_Location, controller: self)
        }
        else if (!self.agreebutton.isSelected) {
            presentAlert("", msgStr: agree_Terms, controller: self)
        }
        else {
            return true
        }
        
        return false
    }
    
    //MARK:- UIImage Picker Delegate Methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.profileButton .setImage(image, for: UIControlState.normal)
        } else{
            print("Something went wrong")
        }
        picker .dismiss(animated: true, completion: {
//            self.imgData = UIImageJPEGRepresentation(self.profileImageView.image!, 0.1)
//            if self.imgData.count > 100 {
//                //self.callApiForUploadingImages()
//            }
        })
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker .dismiss(animated: true, completion: nil)
    }
    
    
    
    //MARK:- UIButton Action
    @IBAction func profileButtonAction(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "", message: "Please select", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Take Photo", style: .default , handler:{ (UIAlertAction)in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
                
                self.picker?.delegate = self
                self.picker?.sourceType = UIImagePickerControllerSourceType.camera;
                self.picker?.allowsEditing = false
                
                self.present(self.picker!, animated: true, completion: nil)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Choose from gallery", style: .default , handler:{ (UIAlertAction)in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
                imagePicker.allowsEditing = true
                
                self.present(imagePicker, animated: true, completion: {
                })
                
            }     }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler:{ (UIAlertAction)in
            
        }))
        self.present(alert, animated: true, completion: {
        })
    }
    
    
    @IBAction func agreeButtonAction(_ sender: UIButton) {
        self.agreebutton.isSelected = !self.agreebutton.isSelected
    }
    
    @IBAction func termsButtonAction(_ sender: UIButton) {
        
        let termsAboutUsVC = SATermsAboutUsVC(nibName: "SATermsAboutUsVC", bundle: nil)
        termsAboutUsVC.controllerType = .Terms_And_Conditions
        self.navigationController?.pushViewController(termsAboutUsVC, animated: true)
    }
    
    @IBAction func privacyButtonAction(_ sender: UIButton) {
        let termsAboutUsVC = SATermsAboutUsVC(nibName: "SATermsAboutUsVC", bundle: nil)
        termsAboutUsVC.controllerType = .Privacy_Policy
        self.navigationController?.pushViewController(termsAboutUsVC, animated: true)
    }
    
    @IBAction func signUpButtonAction(_ sender: UIButton) {
        
        self.view .endEditing(true)
        if self.validateFields() {
           
            let vc = SAOTPVerificationVC(nibName: "SAOTPVerificationVC", bundle: nil)
            
            vc.showCommonPopup(with: { (Int) in
                
                _ =     presentAlertWithOptions("", message: "OTP verified successfully.", controller: self, buttons: ["OK"], tapBlock: { (UIAlertAction, Int) in

                    DispatchQueue.main.async(execute: {
                        let homeMapVC = SAHomeMapVC(nibName: "SAHomeMapVC", bundle: nil)
                        self.navigationController?.pushViewController(homeMapVC, animated: true)
                    })
                    
                    })
            })
        }
    }
    
    @IBAction func loginButtonAction(_ sender: UIButton) {
        
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func doneButtonAction() {
        
        self.view .endEditing(true)
    }

    //MARK:- Memory Management Methods
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
}
}

extension SASignUpViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
      //  print("Place name: \(place.name)")
        
        userInfo.location = place.name
        self.tableView .reloadData()
       // print("Place address: \(place.formattedAddress)")
      //  print("Place attributions: \(place.attributions)")
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
