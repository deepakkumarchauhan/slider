//
//  SAHomeBaseViewController.swift
//  SliderApp
//
//  Created by Deepak Chauhan on 10/07/17.
//  Copyright © 2017 Mobiloitte. All rights reserved.
//

import UIKit

class SAHomeBaseViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet var eventsButton: UIButton!
    @IBOutlet var trendingButton: UIButton!
    
    @IBOutlet var homeContentView: UIView!
    
    @IBOutlet var homeTitleLabel: UILabel!
    
    //MARK: -  UIView Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialMethod()

    }
    
    
    //MARK: -  Custom Method
    func initialMethod() {
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        let vc = SAEventListViewController(nibName: "SAEventListViewController", bundle: nil)
        addViewController(vc)
        
        self.trendingButton.backgroundColor = UIColor.white
        
    }
    
    func addViewController(_ childController: UIViewController) {
        
            childController.view.frame = self.homeContentView.bounds;
            self.addChildViewController(childController)
            self.homeContentView.addSubview(childController.view)
            childController.didMove(toParentViewController: self)
        
    }
    
    func removeViewController(_ childController: UIViewController) {
        
        childController.willMove(toParentViewController: nil)
        childController.view.removeFromSuperview()
        childController.removeFromParentViewController()
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

//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        
//        textField.inputAccessoryView = SAAppUtility.addToolBarOnView(self)
//    }
//    
//    func doneButtonAction() {
//        
//        self.view .endEditing(true)
//    }
    
    //MARK:- UIButton Action
    @IBAction func trendingButtonAction(_ sender: UIButton) {
        
        self.view .endEditing(true)
        
        // Post notification
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ChangeTitleLabelTextTrending"), object: nil)

        self.trendingButton.backgroundColor = UIColor.white
        self.eventsButton.backgroundColor = UIColor.clear

         let removeVC = SATrendingViewController(nibName: "SATrendingViewController", bundle: nil)
        removeViewController(removeVC)

        let vc = SAEventListViewController(nibName: "SAEventListViewController", bundle: nil)
        addViewController(vc)
        
    }

    @IBAction func eventsButtonAction(_ sender: UIButton) {
        
        self.view .endEditing(true)

        // Post notification
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ChangeTitleLabelTextEventList"), object: nil)
        
        self.eventsButton.backgroundColor = UIColor.white
        self.trendingButton.backgroundColor = UIColor.clear
        
        let removeVC = SAEventListViewController(nibName: "SAEventListViewController", bundle: nil)
        removeViewController(removeVC)
        
        
        let vc = SATrendingViewController(nibName: "SATrendingViewController", bundle: nil)
        addViewController(vc)
    }
    
    
    //MARK:- Memory Management Methods
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
