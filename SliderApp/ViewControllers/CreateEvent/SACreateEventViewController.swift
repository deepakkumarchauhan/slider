//
//  SACreateEventViewController.swift
//  SliderApp
//
//  Created by Deepak Chauhan on 11/07/17.
//  Copyright © 2017 Mobiloitte. All rights reserved.
//

import UIKit
import GooglePlaces

let createEventCellIdentifier = "signUpCellID"
let createEventTwoFieldCellIdentifier = "createEventCellID"


class SACreateEventViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate  {

    var picker:UIImagePickerController? = UIImagePickerController()
    @IBOutlet var profileButton: UIButton!
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var eventImageView: UIImageView!
    //let interestedPeopleArray: [String] = ["John Hilter","Jackob Won","William","Andrew Tom","Hitlor","Johney"]

    
    var eventInfo = SAEventInfo()

    //MARK: -  UIView Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialMethod()

    }

    //MARK: -  Custom Method
    func initialMethod() {
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        // Set Profile Button Corner
        self.profileButton.layer.cornerRadius = self.profileButton.layer.frame.size.width/2
        self.profileButton.layer.masksToBounds = true

        // Register TableView
        self.tableView.register(UINib(nibName: "SASignUpTableViewCell", bundle: nil), forCellReuseIdentifier: createEventCellIdentifier)
        self.tableView.register(UINib(nibName: "SACreateEventTableViewCell", bundle: nil), forCellReuseIdentifier: createEventTwoFieldCellIdentifier)

    }
    
    
    func validateFields() -> Bool {
        
        if (eventInfo.eventName.length == 0) {
            presentAlert("", msgStr: blank_EventName, controller: self)
        }
        else if (eventInfo.ticket.length == 0) {
            presentAlert("", msgStr: blank_Ticket, controller: self)
        }
        else if (eventInfo.share.length == 0) {
            presentAlert("", msgStr: blank_Share, controller: self)
        }
        else if (eventInfo.startDate.length == 0) {
            presentAlert("", msgStr: blank_StartDate, controller: self)
        }
        else if (eventInfo.endDate.length == 0) {
            presentAlert("", msgStr: blank_EndDate, controller: self)
        }
//        else if (eventInfo.publicEvent.length == 0) {
//            presentAlert("", msgStr: blank_Public, controller: self)
//        }
//        else if (eventInfo.startDate.length == 0) {
//            presentAlert("", msgStr: blank_Date, controller: self)
//        }
        else if (eventInfo.startTime.length == 0) {
            presentAlert("", msgStr: blank_StartTime, controller: self)
        }
        else if (eventInfo.endTime.length == 0) {
            presentAlert("", msgStr: blank_EndTime, controller: self)
        }
        else if (eventInfo.eventDescription.length == 0) {
            presentAlert("", msgStr: blank_Description, controller: self)
        }
        else if (eventInfo.hostBy.length == 0) {
            presentAlert("", msgStr: blank_HostBy, controller: self)
        }
        else if (eventInfo.numberOfTicket.length == 0) {
            presentAlert("", msgStr: blank_TicketCount, controller: self)
        }
        else if (eventInfo.amount.length == 0 &&  eventInfo.ticket == "Paid") {
            presentAlert("", msgStr: blank_Amount, controller: self)
        }
        else if (eventInfo.category.length == 0) {
            presentAlert("", msgStr: blank_Category, controller: self)
        }
        else if (eventInfo.location.length == 0) {
            presentAlert("", msgStr: blank_Location, controller: self)
        }
        else {
            return true
        }
        
        return false
    }

    
    
    //MARK: -  UITableView Datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if eventInfo.ticket == "Free" {
            return 11
        }
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)as! SASignUpTableViewCell
        
        let twoFieldCell = tableView.dequeueReusableCell(withIdentifier: createEventTwoFieldCellIdentifier)as! SACreateEventTableViewCell
        
        cell.purpleTopUpLabel.isHidden = true
        cell.purpleTopDownLabel.isHidden = true
        cell.purpleDownDownLabel.isHidden = true
        cell.purpleDownLeftLabel.isHidden = true
        cell.locationImageView.isHidden = true
        cell.signUpTextField.delegate = self
        cell.signUpTextView.delegate = self
        cell.signUpTextField.returnKeyType = UIReturnKeyType.next;
        cell.signUpTextField.isSecureTextEntry = false
        cell.signUpTextField.keyboardType = .default
        cell.signUpTextField.autocapitalizationType = .none
        cell.signUpButton.isHidden = true
        cell.signUpTextField.isUserInteractionEnabled = true
        cell.signUpTextField.isHidden = false
        cell.signUpTextView.isHidden = true

        cell.signUpButton.tag = indexPath.row + 200
        twoFieldCell.leftButton.tag = indexPath.row + 200
        twoFieldCell.rightButton.tag = indexPath.row + 201

        
        cell.signUpButton.addTarget(self, action: #selector(signUpButtonAction(_:)), for: .touchUpInside)
        twoFieldCell.leftButton.addTarget(self, action: #selector(signUpButtonAction(_:)), for: .touchUpInside)
        twoFieldCell.rightButton.addTarget(self, action: #selector(signUpButtonAction(_:)), for: .touchUpInside)
        
        var index: NSInteger = 0
        index = indexPath.row
        
        if eventInfo.ticket == "Free" && index >= 9 {
            index = index+1
        }
        
        switch index {
            
        case 0:
            
            cell.signUpTextField.setCustomPlaceholder(string: "Event Name")
            cell.purpleTopUpLabel.isHidden = false
            cell.signUpTextField.text = eventInfo.eventName
            cell.signUpTextField.returnKeyType = .done;
            cell.signUpTextField.tag = indexPath.row+100
            cell.purpleTopDownLabel.isHidden = false
            break
            
        case 1:
            cell.signUpTextField.setCustomPlaceholder(string: "Ticket")
            cell.signUpTextField.text = eventInfo.ticket
            cell.signUpTextField.isUserInteractionEnabled = false
            cell.signUpButton.isHidden = false
            cell.signUpButton.isUserInteractionEnabled = true
            cell.signUpButton.setImage(UIImage(named:"drop_icon"), for: UIControlState.normal)
            break
            
        case 2:
            cell.signUpTextField.setCustomPlaceholder(string: "Privacy")
            cell.signUpTextField.text = eventInfo.share
            cell.signUpTextField.isUserInteractionEnabled = false
            cell.signUpButton.isHidden = false
            cell.signUpButton.isUserInteractionEnabled = true
            cell.signUpButton.setImage(UIImage(named:"drop_icon"), for: UIControlState.normal)
            break
            
        case 3:
            cell.signUpTextField.setCustomPlaceholder(string: "Start Date")
            cell.signUpTextField.text = eventInfo.startDate
            cell.signUpTextField.isUserInteractionEnabled = false
            cell.signUpButton.isHidden = false
            cell.signUpButton.isUserInteractionEnabled = true
            cell.signUpButton.setImage(UIImage(named:"calender_Clock_icon"), for: UIControlState.normal)
            break

            
        case 4:
            cell.signUpTextField.setCustomPlaceholder(string: "End Date")
            cell.signUpTextField.text = eventInfo.endDate
            cell.signUpTextField.isUserInteractionEnabled = false
            cell.signUpButton.isHidden = false
            cell.signUpButton.isUserInteractionEnabled = true
            cell.signUpButton.setImage(UIImage(named:"calender_Clock_icon"), for: UIControlState.normal)
            break
            
        case 5:
            twoFieldCell.leftTextField.setCustomPlaceholder(string: "Start Time")
            twoFieldCell.rightTextField.setCustomPlaceholder(string: "End Time")
            twoFieldCell.leftTextField.text = eventInfo.startTime
            twoFieldCell.rightTextField.text = eventInfo.endTime

            return twoFieldCell
            
        case 6:
            cell.signUpTextView.placeholder = "Description"
            cell.signUpTextField.isHidden = true
            cell.signUpTextView.isHidden = false
            cell.signUpTextView.text = eventInfo.eventDescription
            return cell
            
        case 7:
            cell.signUpTextField.setCustomPlaceholder(string: "Host by")
            cell.signUpTextField.tag = indexPath.row+96
            cell.signUpTextField.text = eventInfo.hostBy
            break
            
        case 8:
            cell.signUpTextField.setCustomPlaceholder(string: "Number of Ticket")
            cell.signUpTextField.tag = indexPath.row+96
            cell.signUpTextField.text = eventInfo.numberOfTicket
            cell.signUpTextField.keyboardType = .numberPad
            break
            
        case 9:
            cell.signUpTextField.setCustomPlaceholder(string: "Amount")
            cell.signUpTextField.tag = indexPath.row+96
            cell.signUpTextField.text = eventInfo.amount
            cell.signUpTextField.keyboardType = .decimalPad
            break
            
        case 10:
            cell.signUpTextField.setCustomPlaceholder(string: "Category")
            cell.signUpTextField.text = eventInfo.category
            cell.signUpTextField.isUserInteractionEnabled = false
            cell.signUpButton.isHidden = false
            if eventInfo.ticket == "Free" {
                cell.signUpButton.tag = 210
            }
            cell.signUpButton.isUserInteractionEnabled = true
            cell.signUpButton.setImage(UIImage(named:"drop_icon"), for: UIControlState.normal)
            break
            
        case 11:
            cell.signUpTextField.setCustomPlaceholder(string: "Location")
            cell.signUpTextField.tag = indexPath.row+96
            if eventInfo.ticket == "Free" {
                cell.signUpTextField.tag = indexPath.row+97
            }
            cell.signUpTextField.text = eventInfo.location
            cell.purpleDownDownLabel.isHidden = false
            cell.purpleDownLeftLabel.isHidden = false
            cell.signUpTextField.returnKeyType = UIReturnKeyType.done;
            break
            
        default: break
            
        }
        return cell
    }
    
    
    //MARK: -  UITableView Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 6 {
            return 120
        }
        return 40.0
    }
    
    
    
    //MARK: -  UITextField Delegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField.tag == 107 {
            
            let autocompleteController = GMSAutocompleteViewController()
            autocompleteController.delegate = self
            present(autocompleteController, animated: true, completion: nil)
            
        }else if textField.tag == 104 || textField.tag == 105 {
            
            textField.inputAccessoryView = SAAppUtility.addToolBarOnView(self)
        }
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        switch textField.tag {
        case 100:
            eventInfo.eventName = (textField.text?.trimWhiteSpace())!
            break;
        case 103:
            eventInfo.hostBy = (textField.text?.trimWhiteSpace())!
            break;
        case 104:
            eventInfo.numberOfTicket = (textField.text?.trimWhiteSpace())!
            break;
        case 105:
            eventInfo.amount = (textField.text?.trimWhiteSpace())!
            break;
        case 107:
            eventInfo.location = (textField.text?.trimWhiteSpace())!
            break;
            
        default:
            break
        }
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var str:NSString = textField.text! as NSString
        str = str.replacingCharacters(in: range, with: string) as NSString
        
        if (textField.tag == 100 && str.length > 50) {
            return false
        }
        else if(textField.tag == 101 && str.length > 500) {
            return false
        }
        else if(textField.tag == 102 && str.length > 100) {
            return false
        }
        else if((textField.tag == 104 || textField.tag == 105) && str.length > 5) {
            return false
        }
        
        if (textField.tag == 105 || textField.tag == 104) && !(string.containsNumberOnly() || string == "." || string == ""){
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
    
    
    //MARK: -  UITextView Delegate
    func textViewDidEndEditing(_ textView: UITextView) {
        
        self.eventInfo.eventDescription = (textView.text?.trimWhiteSpace())!
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
        
        let drawerController = self.navigationController?.parent as! KYDrawerController
        drawerController.setDrawerState(.opened, animated: true)
    }
    
    @IBAction func saveButtonAction(_ sender: UIButton) {
        
        self.view .endEditing(true)
        if self.validateFields() {
            presentAlert("", msgStr: "Event created successfully.", controller: self)

        }
    }
    
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        let drawerController = self.navigationController?.parent as! KYDrawerController
        drawerController.setDrawerState(.opened, animated: true)
        
    }

    
    @IBAction func profileButtonAction(_ sender: UIButton) {
        
        self.view.endEditing(true)
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
    
    
    func signUpButtonAction(_ sender : UIButton){
        
        self.view.endEditing(true)

        if sender.tag == 201 {
            
            let ticketData = ["Paid", "Free"]

            RPicker.sharedInstance.selectOption(dataArray: ticketData, selectedIndex: 0) { (selectedValue: String, selectedIndex: Int) in
                
                self.eventInfo.ticket = selectedValue
                self.tableView .reloadData()
                
            }
        }else if sender.tag == 202 {
            
            
            let privacyData = ["Private", "Public"]
            
                RPicker.sharedInstance.selectOption(dataArray: privacyData, selectedIndex: 0) { (selectedValue: String, selectedIndex: Int) in
            
                    self.eventInfo.share = selectedValue
                    self.tableView .reloadData()
   
            }

        }else if sender.tag == 210 {
            
            let categoryData = ["Happy Hour", "Night Life","Events","Music"]
            RPicker.sharedInstance.selectOption(dataArray: categoryData, selectedIndex: 0) { (selectedValue: String, selectedIndex: Int) in
                
                self.eventInfo.category = selectedValue
                self.tableView .reloadData()
                
            }
        }
        else if sender.tag == 203 {
        DatePickerDialog().show("DatePicker", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", minimumDate:Date(), datePickerMode: .date) {
            (date) -> Void in
            
            if date != nil {
                self.eventInfo.startDateInDate = date
                self.eventInfo.startDate = getStringFromDate(date: date!)
                self.tableView .reloadData()
            }
         }
        }else if sender.tag == 204{
            DatePickerDialog().show("DatePicker", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", minimumDate:Date(), datePickerMode: .date) {
                (date) -> Void in
                
                if date != nil {
                   self.eventInfo.endDateInDate = date
                   self.eventInfo.endDate = getStringFromDate(date: date!)
                   self.tableView .reloadData()
                }
            }
        }else if sender.tag == 205 {
            
            // Start time picker
            DatePickerDialog().show("DatePicker", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", minimumDate:nil, datePickerMode: .time) {
                (date) -> Void in
                
                if date != nil {
                    self.eventInfo.startTimeInDate = date
                    self.eventInfo.startTime = getStringFromTime(date: date!)
                    self.tableView .reloadData()
                }
            }
        }else if sender.tag == 206 {
            
            // End time picker
            DatePickerDialog().show("DatePicker", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", minimumDate:nil, datePickerMode: .time) {
                (date) -> Void in
                
                if date != nil {
                    self.eventInfo.endTimeInDate = date
                    self.eventInfo.endTime = getStringFromTime(date: date!)
                    self.tableView .reloadData()
                }
            }
        }
  }
    
    
    func doneButtonAction() {
        
        self.view .endEditing(true)
    }

    
    //MARK:- UIImage Picker Delegate Methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            self.eventImageView.image = image
           // self.profileButton .setImage(image, for: UIControlState.normal)
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


extension SACreateEventViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        //  print("Place name: \(place.name)")
        
        eventInfo.location = place.name
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

