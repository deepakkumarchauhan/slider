//
//  SATermsAboutUsVC.swift
//  SliderApp
//
//  Created by Krati Agarwal on 05/07/17.
//  Copyright © 2017 Mobiloitte. All rights reserved.
//

import UIKit

class SATermsAboutUsVC: UIViewController {

    enum enum_static_page{
        case Terms_And_Conditions
        case About_Us
        case Privacy_Policy

    }
    
    var controllerType = enum_static_page.Terms_And_Conditions

    @IBOutlet weak var webView: UIWebView!
  
    @IBOutlet weak var navigationBarTitleLabel: UILabel!

    //MARK: - UIViewController Life Cycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
    }

    //MARK: - Helper Method
    
    func initialSetup() {
        
        switch controllerType {
       
        case .Terms_And_Conditions:
            self.navigationBarTitleLabel.text = "Terms and Conditions"
            break
            
        case .About_Us:
            self.navigationBarTitleLabel.text = "About Us"
            break
            
        default:
            self.navigationBarTitleLabel.text = "Privacy Policy"
            break
        }
        
        DispatchQueue.main.async(execute: {

            // displayimg dummy content on web view
            let localfilePath = Bundle.main.url(forResource: "DummyHtml", withExtension: "html")
            let myRequest = NSURLRequest(url: localfilePath!)
            self.webView.loadRequest(myRequest as URLRequest)
        })
    }

    @IBAction func backButtonAction(_ sender: UIButton) {
        
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
