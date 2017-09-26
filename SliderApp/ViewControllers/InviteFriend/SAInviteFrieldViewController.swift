//
//  SAInviteFrieldViewController.swift
//  SliderApp
//
//  Created by Deepak Chauhan on 06/07/17.
//  Copyright © 2017 Mobiloitte. All rights reserved.
//

import UIKit

class SAInviteFrieldViewController: UIViewController {

    
    //MARK: -  UIView Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialMethod()
    }

    //MARK: -  Custom Method
    func initialMethod() {
    }
    
    //MARK: -  UIButton Action

    @IBAction func backButtonAction(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }

    @IBAction func faceBookButtonAction(_ sender: UIButton) {
        presentAlert("", msgStr: "Work in progress.", controller: self)
    }
    
    @IBAction func smsButtonAction(_ sender: UIButton) {
        presentAlert("", msgStr: "Work in progress.", controller: self)
    }

    @IBAction func googlePlusButtonAction(_ sender: Any) {
        
        presentAlert("", msgStr: "Work in progress.", controller: self)
    }
    
    
    //MARK:- Memory Management Methods
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
