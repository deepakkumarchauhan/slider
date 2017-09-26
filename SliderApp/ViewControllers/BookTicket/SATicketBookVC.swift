//
//  SATicketBookVC.swift
//  SliderApp
//
//  Created by Krati Agarwal on 07/07/17.
//  Copyright © 2017 Mobiloitte. All rights reserved.
//

import UIKit


class SATicketBookVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate, UITextFieldDelegate {

    @IBOutlet weak var navigationTitleLabel: UILabel!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var netAmountLabel: UILabel!
    
    @IBOutlet weak var ticketButonLabel: UILabel!
    @IBOutlet weak var attendeeButtonLabel: UILabel!
    @IBOutlet weak var paymentButtonLabel: UILabel!

    @IBOutlet weak var paymentButton: UIButton!
    @IBOutlet weak var attendeeButton: UIButton!
    @IBOutlet weak var proceedButton: UIButton!
    @IBOutlet weak var ticketButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var viewToRound: UIView!
    
    var buttonIndex:Int = 0
    
    var booktickerObj = SABookTicket()
    
    //MARK: - UIViewController Life Cycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialMethod()
        
        addSwipeGesture()
        
        dummyInitialization()
    }

    //MARK: - Helper Method

    func initialMethod() {

        // Register TableView
        self.tableView.register(UINib(nibName: "SATickeTVCell", bundle: nil), forCellReuseIdentifier: "SATickeTVCell")
        
        self.tableView.register(UINib(nibName: "SAAttendeeTVCell", bundle: nil), forCellReuseIdentifier: "SAAttendeeTVCell")
        
        self.tableView.register(UINib(nibName: "SAPaymentTVCell", bundle: nil), forCellReuseIdentifier: "SAPaymentTVCell")
        
        self.tableView.register(UINib(nibName: "SAHeaderTVCell", bundle: nil), forCellReuseIdentifier: "SAHeaderTVCell")

        // set default ticket button selected
        self.ticketButton.isSelected = true
    
        self.navigationTitleLabel.text = "Book Ticket"
    }
    
    func dummyInitialization() {
    
        booktickerObj.netAmountString = "20"
        booktickerObj.totalAmount = booktickerObj.netAmountString
        
        self.booktickerObj.dateTime = Date()
        
        self.booktickerObj.dateString = getStringFromDate(date: self.booktickerObj.dateTime!)
        self.booktickerObj.timeString = getStringFromTime(date: self.booktickerObj.dateTime!)
        self.booktickerObj.weekNameString = getDayOfWeek(today: self.booktickerObj.dateString)
     
        let day = getDay(today: self.booktickerObj.dateString) as Int
        
        self.booktickerObj.day = ("\(day)")
        
    }
    
    func addSwipeGesture() {
        
        let rightSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(SATicketBookVC.rightReloadTableView))
        rightSwipeGestureRecognizer.direction =  UISwipeGestureRecognizerDirection.right
        self.tableView.addGestureRecognizer(rightSwipeGestureRecognizer)
        
        // Add left swipe gesture recognizer
       
        let leftSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(SATicketBookVC.leftReloadTableView))
        leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirection.left

        self.tableView.addGestureRecognizer(leftSwipeGestureRecognizer)
        
        leftSwipeGestureRecognizer.delegate = self
        rightSwipeGestureRecognizer.delegate = self
    }
 
    func leftReloadTableView() {

        UIView.transition(with: tableView,
                          duration: 1.0,
                          options: .transitionFlipFromLeft,
                          animations: {
                            
                            self.tableView.reloadData()
                            
                            })
        
    }
    
    func rightReloadTableView() {
        
        UIView.transition(with: tableView,
                          duration: 1.0,
                          options: .transitionFlipFromRight,
                          animations: {
                            
                            self.tableView.reloadData()
                            
        })
        
    }
    
    //MARK: - UIGestureRecognizerDelegate delegate method

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return true
    }
    
    //MARK: - Validation Methods
    
    func validateAttendeeDetails() -> Bool {
        
        var isAllValid: Bool = false
        
        if (booktickerObj.buyerName.trimWhiteSpace().length == 0) {
            presentAlert("", msgStr: blank_Name, controller: self)
            
        } else if (booktickerObj.buyerEmail.trimWhiteSpace().length == 0) {
            presentAlert("", msgStr: blank_Email, controller: self)
            
        } else if (!(booktickerObj.buyerEmail.isEmail())) {
            presentAlert("", msgStr: valid_Email, controller: self)
            
        } else if (booktickerObj.buyerMobileNumber.trimWhiteSpace().length == 0) {
            presentAlert("", msgStr: blank_Mobile, controller: self)
            
        }else if ((booktickerObj.buyerMobileNumber.length)<10) {
            presentAlert("", msgStr: maxLength_Mobile, controller: self)
            
        }
//        else if (!(booktickerObj.buyerMobileNumber.isValidMobileNumber())) {
//            presentAlert("", msgStr: valid_MobileNumber, controller: self)
//            
//        }
        else {
            isAllValid = true
        }
        
        return isAllValid
    }
    
    //MARK: -  UITextField Delegate Methods
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
     if textField.tag == 2 {
            
            textField.inputAccessoryView = SAAppUtility.addToolBarOnView(self)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        switch textField.tag {
        case 0:
            booktickerObj.buyerName = (textField.text?.trimWhiteSpace())!
            break;
        case 1:
            booktickerObj.buyerEmail = (textField.text?.trimWhiteSpace())!
            break;
        case 2:
            booktickerObj.buyerMobileNumber = (textField.text?.trimWhiteSpace())!
            break;
            
        default:
            break
        }
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var str:NSString = textField.text! as NSString
        str = str.replacingCharacters(in: range, with: string) as NSString
        
        if (textField.tag == 0 && str.length > 50) { // name upper limit
            
            return false
        
        } else if(textField.tag == 1 && str.length > 60) { // email upper limit
            
            return false
        
        } else if(textField.tag == 2 && str.length > 15) { // mobile number upper limit
            
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
    
    //MARK: - UIButton Action Methods

    @IBAction func backButotnAction(_ sender: UIButton) {
        
        self.view .endEditing(true)
        _ =   self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func proceedButtonAction(_ sender: UIButton) {
        
        self.view .endEditing(true)
        
        if (buttonIndex == 0 ) {
            
            // reload table view and proceed to attendee screen
            self.navigationTitleLabel.text = "Details"
            
            self.ticketButton.isSelected = false
            self.attendeeButton.isSelected = true
            self.paymentButton.isSelected = false

            self.buttonIndex = 1
            rightReloadTableView()

            
        } else if (buttonIndex == 1 && validateAttendeeDetails()) {
        
            // reload table view and proceed to payment screen
            self.navigationTitleLabel.text = "Payment"
            
            self.ticketButton.isSelected = false
            self.attendeeButton.isSelected = false
            self.paymentButton.isSelected = true

            self.buttonIndex = 2
            rightReloadTableView()
        }
    }
    
    @IBAction func ticketButtonAction(_ sender: UIButton) {
        
        self.ticketButton.isSelected = true
        self.attendeeButton.isSelected = false
        self.paymentButton.isSelected = false
        
        self.navigationTitleLabel.text = "Ticket Book"

        if buttonIndex > 0 {
            
            self.buttonIndex = 0
            leftReloadTableView()
            
        }

    }
    
    @IBAction func attendeeButtonAction(_ sender: UIButton) {
        
        self.ticketButton.isSelected = false
        self.attendeeButton.isSelected = true
        self.paymentButton.isSelected = false
        
        self.navigationTitleLabel.text = "Details"

        if buttonIndex > 1 {
            
            self.buttonIndex = 1
            leftReloadTableView()
            
        } else if buttonIndex < 1 {
            
            self.buttonIndex = 1
            rightReloadTableView()
            
        } else {
        
            self.buttonIndex = 1
        }

    }
    
    @IBAction func paymentButtonAvtion(_ sender: UIButton) {
        
        self.ticketButton.isSelected = false
        self.attendeeButton.isSelected = false
        self.paymentButton.isSelected = true
        
        self.navigationTitleLabel.text = "Payment"

        if buttonIndex < 2 {
            
            self.buttonIndex = 2
            rightReloadTableView()
            
        }

    }
    
    
    func doneButtonAction() {
        
        self.view .endEditing(true)
    }
    
    //MARK: -  UIButton Selector Method
    
    func plusButtonSelector(_ sender : UIButton){

        sender.isSelected = true

        let cell = tableView.dequeueReusableCell(withIdentifier: "SATickeTVCell")as! SATickeTVCell
        cell.minusButton.isSelected = false
        cell.plusButton.isSelected = true

        booktickerObj.ticketCount = booktickerObj.ticketCount + 1
    
        let netCalculation = Float(booktickerObj.ticketCount) * Float(booktickerObj.netAmountString)! as Float
        
        booktickerObj.totalAmount = ("\(netCalculation)")

        self.tableView .reloadData()
    }
    
    func minusButtonSelector(_ sender : UIButton){
        
        if booktickerObj.ticketCount > 1 {
            
            sender.isSelected = true
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SATickeTVCell")as! SATickeTVCell
            cell.plusButton.isSelected = false
            cell.minusButton.isSelected = true

            booktickerObj.ticketCount = booktickerObj.ticketCount - 1
            
            let netCalculation = Float(booktickerObj.ticketCount) * Float(booktickerObj.netAmountString)! as Float
            
            booktickerObj.totalAmount = ("\(netCalculation)")
            
            self.tableView .reloadData()
        }
        
    }
    
    func dateButotnAction(_ sender : UIButton){
        
        DatePickerDialog().show("DatePicker", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", minimumDate:Date(), datePickerMode: .dateAndTime) {
            (date) -> Void in
            
            self.booktickerObj.dateTime = date
            
            self.booktickerObj.dateString = getStringFromDate(date: date!)
            self.booktickerObj.timeString = getStringFromTime(date: date!)            
            self.booktickerObj.weekNameString = getDayOfWeek(today: self.booktickerObj.dateString)
            
            let day = getDay(today: self.booktickerObj.dateString) as Int
            
            self.booktickerObj.day = ("\(day)")

            self.tableView .reloadData()
    }
}
    
    //MARK: -  UITableView Delegate and Datasource Methods
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if (buttonIndex == 0) {
            
            return 180.0
            
        } else  if (buttonIndex == 1) {
            
            return 50
            
        } else {
            
            return 40
        }
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (buttonIndex == 0) {
            
            return 1
       
        } else  if (buttonIndex == 1) {
            
            return 3
        
        } else {
            
            return 3
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch buttonIndex {
       
        case 0:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SATickeTVCell")as! SATickeTVCell
            
            cell.totalAmountLabel.text = "$" + booktickerObj.totalAmount
            cell.singleTicketAmountLabel.text = "$" + booktickerObj.netAmountString
            cell.ticketCountLabel.text = ("\(booktickerObj.ticketCount)")
            
            cell.dateLabel.text = self.booktickerObj.dateString
            cell.timeLabel.text = self.booktickerObj.timeString

            cell.weekLabel.text = self.booktickerObj.weekNameString

            cell.datePickerButton .setTitle(self.booktickerObj.day, for: .normal)

            cell.plusButton.addTarget(self, action: #selector(plusButtonSelector(_:)), for: .touchUpInside)
            cell.minusButton.addTarget(self, action: #selector(minusButtonSelector(_:)), for: .touchUpInside)
            
            cell.datePickerButton.addTarget(self, action: #selector(dateButotnAction(_:)), for: .touchUpInside)

            return cell
            
            
        case 1:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SAAttendeeTVCell")as! SAAttendeeTVCell
            cell.inputField.setBorder(UIColor.lightGray, borderWidth: 0.5)
            cell.inputField.tag = indexPath.row
            cell.inputField.returnKeyType = UIReturnKeyType.next;
            cell.inputField.delegate = self
            cell.inputField.autocapitalizationType = .none
            
            if (indexPath.row == 0) {
                
                cell.inputField.placeholder = "Name"
                cell.inputField.keyboardType = .asciiCapable;
                cell.inputField.autocapitalizationType = .words

            } else if (indexPath.row == 1) {
                
                cell.inputField.placeholder = "Email"
                cell.inputField.keyboardType = .emailAddress
            } else {
                
                cell.inputField.placeholder = "Mobile No."
                cell.inputField.keyboardType = .numberPad
                cell.inputField.returnKeyType = UIReturnKeyType.done;

            }
            
            return cell
            
            
        default:
            
        let cell = tableView.dequeueReusableCell(withIdentifier: "SAPaymentTVCell")as! SAPaymentTVCell
        
        if (indexPath.row == 0) {
            
            cell.paymentTitleLabel.text = "Credit Card"
            cell.paymentImageView.image = UIImage(named:"credit_icon")

        } else if (indexPath.row == 1) {
            
            cell.paymentTitleLabel.text = "Debit Card"
            cell.paymentImageView.image = UIImage(named:"debit_card")
            
        } else {
            
            cell.paymentTitleLabel.text = "Net Banking"
            cell.paymentImageView.image = UIImage(named:"net_banking_icon")
            
        }

        return cell
            
        }
    
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if (buttonIndex == 0 || buttonIndex == 1) {
            
            return 0
            
        } else {
            
            return 40
        }

    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "SAHeaderTVCell")as! SAHeaderTVCell
        
        if (buttonIndex == 2) {
            headerCell.headerTitleLabel.text = "Choose your payment method"

        }
       
        return headerCell
    }
    
    //MARK: - Memory Handling

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
