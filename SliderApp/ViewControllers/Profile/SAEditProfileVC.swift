//
//  SAEditProfileVC.swift
//  SliderApp
//
//  Created by Krati Agarwal on 13/07/17.
//  Copyright © 2017 Mobiloitte. All rights reserved.
//

import UIKit

class SAEditProfileVC: UIViewController, UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var profileButton: UIButton!

    var picker:UIImagePickerController? = UIImagePickerController()

    var userInfo = SAUserInfo()

    //MARK: -  UIView Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        initialMethod()
        
        dummyData()
    }

    //MARK: -  Custom Method
    
    func initialMethod() {
        
        self.tableView.alwaysBounceVertical = false
        
        self.tableView.register(UINib(nibName: "SASignUpTableViewCell", bundle: nil), forCellReuseIdentifier: "signUpCellID")
        
    }
    
    func dummyData() {
        
        userInfo.fullName = "John Cena"
        userInfo.mobile = "9876543210"
        userInfo.email = "cena543@gmail.com"
        

    }
    
    func validateFields() -> Bool {
        
        if (userInfo.fullName.length == 0) {
            presentAlert("", msgStr: blank_FullName, controller: self)
        }
        else if ((userInfo.fullName.length) < 3) {
            presentAlert("", msgStr: maxLength_FullName, controller: self)
        }
        else if (userInfo.mobile.length == 0) {
            presentAlert("", msgStr: blank_Mobile, controller: self)
        }
        else if ((userInfo.mobile.length) < 10) {
            presentAlert("", msgStr: maxLength_Mobile, controller: self)
        }
        else if (userInfo.email.length == 0) {
            presentAlert("", msgStr: blank_Email, controller: self)
        }
        else if (!(userInfo.email.isEmail())) {
            presentAlert("", msgStr: valid_Email, controller: self)
        }
            
        else {
            return true
        }
        
        return false
    }
    
    //MARK:- UIButton Action Methods
    
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
    
    @IBAction func saveButtonAction(_ sender: UIButton) {
        
        self.view .endEditing(true)
        
        if self.validateFields() {
            
            _ =     presentAlertWithOptions("", message: "Profile updated successfully.", controller: self, buttons: ["OK"], tapBlock: { (UIAlertAction, Int) in
                
                _ = self.navigationController?.popViewController(animated: true)
            })
        }

    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        
        _ = self.navigationController?.popViewController(animated: true)

    }
    
    func doneButtonAction() {
        
        self.view .endEditing(true)
    }

    //MARK: -  UITextField Delegate Methods
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField.tag == 101 {
            
            textField.inputAccessoryView = SAAppUtility.addToolBarOnView(self)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        switch textField.tag {
        case 100:
            userInfo.fullName = (textField.text?.trimWhiteSpace())!
            break;
        case 101:
            userInfo.mobile = (textField.text?.trimWhiteSpace())!
            break;
        case 102:
            userInfo.email = (textField.text?.trimWhiteSpace())!
            
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

        if ((textField.tag == 100) && str.length > 50) {
            return false
        }
        else if(textField.tag == 101 && str.length > 15) {
            return false
        }
        else if(textField.tag == 102 && str.length > 60) {
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

    //MARK: -  UITableView Datasource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
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
        
        switch indexPath.row {
        case 0:
            cell.signUpTextField.placeholder = "Full Name"
            cell.purpleTopUpLabel.isHidden = false
            cell.signUpTextField.text = userInfo.fullName
            cell.purpleTopDownLabel.isHidden = false
            cell.signUpTextField.autocapitalizationType = .words
            
            break
            
        case 1:
            cell.signUpTextField.placeholder = "Mobile Number"
            cell.signUpTextField.keyboardType = .numberPad
            cell.signUpTextField.text = userInfo.mobile
            break
            
        case 2:
            cell.signUpTextField.placeholder = "Email"
            cell.signUpTextField.text = userInfo.email
            cell.signUpTextField.keyboardType = .emailAddress
            cell.signUpTextField.returnKeyType = UIReturnKeyType.done;

            cell.purpleDownDownLabel.isHidden = false
            cell.purpleDownLeftLabel.isHidden = false

            break
       
           default: break
            
        }
        return cell
    }
    
    
    //MARK: -  UITableView Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0;
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
    
    
    //MARK:- Memory Management Methods

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
