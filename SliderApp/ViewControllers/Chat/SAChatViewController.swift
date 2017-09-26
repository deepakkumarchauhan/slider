//
//  SAChatViewController.swift
//  SliderApp
//
//  Created by Deepak Chauhan on 06/07/17.
//  Copyright © 2017 Mobiloitte. All rights reserved.
//

import UIKit

let cellSenderIdentifier = "senderChatCellId"
let cellReceiverIdentifier = "receiverChatCellId"

class SAChatViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UIScrollViewDelegate {
    
    @IBOutlet var viewBottomConstraint: NSLayoutConstraint!
    @IBOutlet var viewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet var infoButton: UIButton!
    @IBOutlet var tableTopConstraint: NSLayoutConstraint!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var textViewPlaceholderlabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var textView: UITextView!
    @IBOutlet var sendButton: UIButton!
    
    @IBOutlet var navigationTitleLabel: UILabel!
    @IBOutlet var rightLabel: UILabel!
    @IBOutlet var leftLabel: UILabel!
    
    var userName = String()
    var isGroupChat = Bool()

    var chatArray: [String] = []

    //MARK: -  UIView Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initialMethod()
    }
    
    //MARK: -  Custom Method
    func initialMethod() {
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        // Set userName
        self.nameLabel.text = self.userName
        
        self.textView.delegate = self
        
        if isGroupChat {
            self.tableTopConstraint.constant = 0
            self.leftLabel.isHidden = true
            self.rightLabel.isHidden = true
            self.nameLabel.isHidden = true
            self.navigationTitleLabel.text = "My Group"
            self.infoButton.isHidden = false
        }
        
        self.tableView.estimatedRowHeight = 100.0
        self.nameLabel.setBorder(UIColor.white, borderWidth: 1.0)
        
        // Set Send Button Disable
        self.sendButton.isEnabled = false
        self.sendButton.alpha = 0.5

        // Register TableView
        self.tableView.register(UINib(nibName: "SAReceiverTableViewCell", bundle: nil), forCellReuseIdentifier: cellReceiverIdentifier)
        self.tableView.register(UINib(nibName: "SASenderTableViewCell", bundle: nil), forCellReuseIdentifier: cellSenderIdentifier)
        
        // Add Keyboard Notifications
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillAppear), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        IQKeyboardManager.sharedManager().enable = false

    }

    
    //MARK: -  Observer Methods
    func keyboardWillAppear(_ notification : Notification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 1, delay: 2, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: UIViewAnimationOptions(), animations: {
                self.viewBottomConstraint.constant = keyboardSize.height
            }) { _ in
                self.view.layoutSubviews()
                self.view.layoutIfNeeded()
            }
                if self.chatArray.count > 1 {
                    let indexPath = IndexPath(row: self.chatArray.count-1, section: 0)
                    self.tableView.scrollToRow(at: indexPath,
                                               at: UITableViewScrollPosition.bottom, animated: true)
            }
        }
    }
    
    func keyboardWillHide(_ notification : Notification) {
        if ((notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            self.viewBottomConstraint.constant = 0
        }
    }
 
    
    //MARK: -  Dealloc method
    deinit {
        
        NotificationCenter.default.removeObserver(self.keyboardWillAppear, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self.keyboardWillHide, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    
    //MARK: -  UITableView Datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellSender = tableView.dequeueReusableCell(withIdentifier: cellSenderIdentifier)as! SASenderTableViewCell
        let cellReceiver = tableView.dequeueReusableCell(withIdentifier: cellReceiverIdentifier)as! SAReceiverTableViewCell
        
        if indexPath.row%2 == 0 {
            cellReceiver.titleLabel.text = chatArray[indexPath.row]
            return cellReceiver
        }else {
            cellSender.titleLabel.text = chatArray[indexPath.row]
            return cellSender
        }
    }
    
    
    //MARK: -  UITableView Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    //MARK: -  UIScroll Delegate
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.view .endEditing(true)
    }
    
    
    
    //MARK: -  UITextView Delegate
     public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {

        var str:NSString = textView.text! as NSString
        str = str.replacingCharacters(in: range, with: text) as NSString

        if (TRIM_SPACE(str: str) as AnyObject).length != 0 {
          self.sendButton.isEnabled = true
          self.sendButton.alpha = 1.0
          self.textViewPlaceholderlabel.isHidden = true
        }else{
          self.sendButton.isEnabled = false
          self.sendButton.alpha = 0.5
          self.textViewPlaceholderlabel.isHidden = false
        }
        
        let fixedWidth = Window_Width-86
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        if newSize.height > 120 {
            self.textView.isScrollEnabled = true
            self.viewHeightConstraint.constant = 130
        }else {
            self.textView.isScrollEnabled = false
            self.viewHeightConstraint.constant = newSize.height+13
        }
        
        if chatArray.count != 0 {
        let indexPath = IndexPath(row: chatArray.count-1, section: 0)
        self.tableView.scrollToRow(at: indexPath,
                                       at: UITableViewScrollPosition.bottom, animated: true)        }

        return true
    }
    
    
    //MARK: -  UIButton Action
    @IBAction func backButtonAction(_ sender: UIButton) {
        
        IQKeyboardManager.sharedManager().enable = true
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func sendButtonAction(_ sender: UIButton) {
        
        self.textViewPlaceholderlabel.isHidden = false
        self.viewHeightConstraint.constant = 50

        if self.textView.text.trimWhiteSpace().length != 0 {
            
            if self.textView.text.trimWhiteSpace().length >= 1024 {
                presentAlert("", msgStr: "The character limit is 1024. Try a shorter message then send it again.", controller: self)
            }else{
               self.sendButton.isEnabled = false
                self.sendButton.alpha = 0.5
                chatArray.append(self.textView.text.trimWhiteSpace())
                self.textView.text = ""
                
                if chatArray.count != 0 {
                    self.tableView .reloadData()
                }
                let indexPath = IndexPath(row: chatArray.count-1, section: 0)
                self.tableView.scrollToRow(at: indexPath,
                                           at: UITableViewScrollPosition.bottom, animated: true)
            }
        }else {
            
        }
    }
    
    @IBAction func infoButtonAction(_ sender: UIButton) {
        
        let vc = SAAddGroupSubjectViewController(nibName: "SAAddGroupSubjectViewController", bundle: nil)
        vc.isShowGroupDetail = true
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    //MARK:- Memory Management Methods
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
