//
//  SAWelcomAlertVC.swift
//  SliderApp
//
//  Created by Krati Agarwal on 07/07/17.
//  Copyright © 2017 Mobiloitte. All rights reserved.
//

import UIKit

typealias landingWelcomeViewCompletionBlock = (_ index: Int) -> Void

class SAWelcomAlertVC: UIViewController {

    @IBOutlet weak var landingLocationLabel: UILabel!
    
    @IBOutlet weak var alertView: UIView!
    
    var completionBlock: landingWelcomeViewCompletionBlock?
    var isDismiss: Bool!

    
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
        self.alertView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
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
        self.completionBlock!(0)

    }
    
    //MARK: Public Methods
    
    func showCommonPopup(with block: @escaping landingWelcomeViewCompletionBlock, labelTitle title1: String, dissmissOnTap dissmissvalue: Bool) {
        
        self.view .layoutIfNeeded()
        
        UIView .animate(withDuration: 3.0) {
            self.view .layoutIfNeeded()
            self.modalPresentationStyle = UIModalPresentationStyle.custom
            self.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal;
            
            self.getRootController().present(self, animated: false, completion: {() -> Void in
                self.landingLocationLabel.text = title1
                (dissmissvalue) ? (self.isDismiss = true) : (self.isDismiss = false)
            })
            self.completionBlock = block
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (self.isDismiss == true) {
            self.dismiss()
        }
    }
    
    //MARK: - Memory Handling

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
