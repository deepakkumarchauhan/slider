//
//  SAAlertLabelVC.swift
//  SliderApp
//
//  Created by Krati Agarwal on 05/07/17.
//  Copyright © 2017 Mobiloitte. All rights reserved.
//

import UIKit

typealias commonViewCompletionBlock = (_ index: Int) -> Void

class SAAlertLabelVC: UIViewController {

    @IBOutlet weak var alertLabel: UILabel!
    var completionBlock: commonViewCompletionBlock?
    var isDismiss: Bool!
    
    //MARK: - UIViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    //MARK: - Private Methods
    
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
    
    func showCommonPopup(with block: @escaping commonViewCompletionBlock, labelTitle title1: String, dissmissOnTap dissmissvalue: Bool) {
        
        self.view .layoutIfNeeded()
        
        UIView .animate(withDuration: 3.0) { 
            self.view .layoutIfNeeded()
            self.modalPresentationStyle = UIModalPresentationStyle.custom
            self.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal;
           
            self.getRootController().present(self, animated: false, completion: {() -> Void in
                self.alertLabel.text = title1
                (dissmissvalue) ? (self.isDismiss = true) : (self.isDismiss = false)
            })
            self.completionBlock = block
        }
    }
    
    //MARK: - UIButton Action Handling

    @IBAction func okButtonAction(_ sender: UIButton) {
        
        self.dismiss()
        self.completionBlock!(0)
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
