//
//  SALogoutVC.swift
//  SliderApp
//
//  Created by Krati Agarwal on 11/07/17.
//  Copyright © 2017 Mobiloitte. All rights reserved.
//

import UIKit

typealias logoutViewCompletionBlock = (_ index: Int) -> Void

class SALogoutVC: UIViewController {

    var completionBlock: logoutViewCompletionBlock?
  
    @IBOutlet weak var alertLabel: UILabel!

    @IBOutlet weak var alertView: UIView!

    //MARK: - UIViewController LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setShadowOfAlertView()

    }
    
    //MARK: - Helper Methods
    
    func setShadowOfAlertView() {
        
        self.alertView.layer.masksToBounds = false
        self.alertView.layer.shadowRadius = 2.0
        self.alertView.layer.shadowColor = UIColor.black.cgColor
        self.alertView.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        self.alertView.layer.shadowOpacity = 1
        
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
    
    //MARK: Public Methods
    
    func showCommonPopup(with block: @escaping logoutViewCompletionBlock, labelTitle title1: String) {
        
        self.view .layoutIfNeeded()
        
        UIView .animate(withDuration: 3.0) {
            self.view .layoutIfNeeded()
            self.modalPresentationStyle = UIModalPresentationStyle.custom
            self.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal;
            
            self.getRootController().present(self, animated: false, completion: {() -> Void in
                self.alertLabel.text = title1

            })
            self.completionBlock = block
        }
    }
    
    //MARK: - UIButton Action Handling

    @IBAction func okButtonAction(_ sender: UIButton) {
        
        self.dismiss()
        self.completionBlock!(0)
    }
    
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        
        self.dismiss()
        self.completionBlock!(1)
    }
    
    //MARK: - Memory Handling

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
