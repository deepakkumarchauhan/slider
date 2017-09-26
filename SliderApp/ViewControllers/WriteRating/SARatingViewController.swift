//
//  SARatingViewController.swift
//  SliderApp
//
//  Created by Deepak Chauhan on 07/07/17.
//  Copyright © 2017 Mobiloitte. All rights reserved.
//

import UIKit

class SARatingViewController: UIViewController,UITextViewDelegate {

    @IBOutlet var starTopConstraint: NSLayoutConstraint!
    
    @IBOutlet var ratingView: FloatRatingView!
    @IBOutlet var reviewTextView: UITextView!
    //MARK: -  UIView Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    //MARK: -  UITextView Delegate
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        UIView.animate(withDuration: 0.2,
                       delay: 0.2,
                       options: UIViewAnimationOptions.curveEaseIn,
                       animations: { () -> Void in
                        if Window_Width > 320 {
                           self.starTopConstraint.constant = 65
                        }else {
                            self.starTopConstraint.constant = 0
                        }
                        self.view?.layoutIfNeeded()
        }, completion: { (finished) -> Void in
        })
    }
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        UIView.animate(withDuration: 0.2,
                       delay: 0.2,
                       options: UIViewAnimationOptions.curveEaseIn,
                       animations: { () -> Void in
                        self.starTopConstraint.constant = 65
                        self.view?.layoutIfNeeded()
        }, completion: { (finished) -> Void in
        })
    }
    
    
    //MARK:- Touch Method
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view .endEditing(true)
    }
    
    
    //MARK:- UIButton Action
    @IBAction func backButtonAction(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }

    @IBAction func submitButtonAction(_ sender: UIButton) {
        
        self.view .endEditing(true)
        
        if self.reviewTextView.text.trimWhiteSpace().length == 0 && self.ratingView.rating == 0 {
          
            presentAlert("", msgStr: blank_Review, controller: self)
       
        } else {
            
            _ =     presentAlertWithOptions("", message: "Review posted successfully.", controller: self, buttons: ["OK"], tapBlock: { (UIAlertAction, Int) in
                
                _ = self.navigationController?.popViewController(animated: true)
                
            })
        }
    }
    
    //MARK:- Memory Management Methods
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
