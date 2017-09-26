//
//  SAAddGroupSubjectViewController.swift
//  SliderApp
//
//  Created by Deepak Chauhan on 17/07/17.
//  Copyright © 2017 Mobiloitte. All rights reserved.
//

import UIKit
let cellGroupIdentifier = "userGroupCellID"

class SAAddGroupSubjectViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var subjectNameTextField: SATexFieldSubClass!
    @IBOutlet var profileButton: UIButton!
    
    @IBOutlet var navigationTitleLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    var picker:UIImagePickerController? = UIImagePickerController()
    
    var groupPeopleArray: [String] = ["John Hilter","Jackob Won","William","Andrew Tom","Hitlor","Johney"]
    
    var isShowGroupDetail = Bool()
    
    
    //MARK: -  UIView Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initialMethod()
    }
    
    //MARK: -  Custom Method
    func initialMethod() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        self.profileButton.layer.cornerRadius = self.profileButton.layer.frame.size.width / 2
        self.profileButton.layer.masksToBounds = true
        self.profileButton.clipsToBounds = true
        
        
        if isShowGroupDetail {
            self.subjectNameTextField.text = "My Group"
            self.navigationTitleLabel.text = "Group Detail"
            self.tableView.delegate = self
            self.tableView.dataSource = self
            // Register TableView
            self.tableView.register(UINib(nibName: "SAGroupUserTableViewCell", bundle: nil), forCellReuseIdentifier: cellGroupIdentifier)

        }else {
            self.tableView.isHidden = true
        }
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
    @IBAction func backButtonAction(_ sender: UIButton) {
        
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func doneButtonAction(_ sender: UIButton) {
        
        self.view .endEditing(true)
        
        if self.subjectNameTextField.text?.length != 0 {
            _ =     presentAlertWithOptions("", message:isShowGroupDetail ? "Detail updated successfully." : "Group created successfully.", controller: self, buttons: ["OK"], tapBlock: { (UIAlertAction, Int) in
                
                if self.isShowGroupDetail ==  false {
                    _ = self.navigationController?.popToRootViewController(animated: true)
                }
                
            })
        }else {
            presentAlert("", msgStr: blank_Subject, controller: self)
            
        }
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
    
    
    
    //MARK: -  UITableView Datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupPeopleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellGroupIdentifier)as! SAGroupUserTableViewCell
        
        cell.userNameLabel.text = self.groupPeopleArray[indexPath.row]
        cell.removeButton.tag = indexPath.row+100
        cell.removeButton.addTarget(self, action: #selector(removeButtonTapped(_:)), for: .touchUpInside)
        
        return cell
    }
    
    
    //MARK: -  UITableView Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    
    //MARK: -  Selector Method
    func removeButtonTapped(_ sender : UIButton){
        
        _ =     presentAlertWithOptions("", message: "Are you sure you want to remove this user?", controller: self, buttons: ["Yes","No"], tapBlock: { (UIAlertAction, position) in
        
            if position == 0 {
                self.groupPeopleArray .remove(at: sender.tag-100)
                self.tableView.reloadData()
            }
            
        })
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
    }
    
    
    
}
