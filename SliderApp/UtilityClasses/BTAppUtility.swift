//
//  BTAppUtility.swift
//  BeanThere
//
//  Created by Neha Chhabra on 11/11/16.
//  Copyright © 2016 Neha Chhabra. All rights reserved.
//

import UIKit

// MARK: - Short Terms
let kAppOrangeColor = RGBA(255, g: 85, b: 40, a: 1) //RGBA(64, g: 183, b: 255, a: 1) //RGBA(252, g: 173, b: 17, a: 1)
let KAppWhiteColor = UIColor.white
let KAppPlaceholderColor = UIColor.lightGray
let KAppTextColor = UIColor.darkGray
let KAppMediumFont = UIFont(name:"San Francisco Text Medium", size:20)!
//let KAppRegularFont = UIFont(name:"San Francisco Text Regular", size: 18)!
let kAppDarkGrayColor = RGBA(29, g: 35, b: 34, a: 0.2)
let KAppTintColor = RGBA(255, g: 220, b: 65, a: 1)
let kAppDelegate = UIApplication.shared.delegate as! AppDelegate

let showLog = true

let Window_Width = UIScreen.main.bounds.size.width
let Window_Height = UIScreen.main.bounds.size.height

// MARK: - Helper functions
func RGBA(_ r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor(red: (r/255.0), green: (g/255.0), blue: (b/255.0), alpha: a)
}

func getRoundRect(_ obj : UIButton){
    obj.layer.cornerRadius = obj.frame.size.height/2
    obj.layer.borderColor = KAppWhiteColor.cgColor
    obj.layer.borderWidth = obj.frame.size.width/2
    obj.clipsToBounds = true
}

func getRoundImage(_ obj : UIImageView){
    obj.layer.cornerRadius = obj.frame.size.height/2
    obj.layer.borderColor = KAppWhiteColor.cgColor
    obj.layer.borderWidth = 5
    obj.layer.masksToBounds = true
}

func getViewWithTag(_ tag:NSInteger, view:UIView) -> UIView {
    return view.viewWithTag(tag)!
}

// custom log
func logInfo(_ message: String, file: String = #file, function: String = #function, line: Int = #line, column: Int = #column) {
    if (showLog) {
        print("\(function): \(line): \(message)")
    }
}

func presentAlert(_ titleStr : String?,msgStr : String?,controller : AnyObject?){
    DispatchQueue.main.async(execute: {
        let alert=UIAlertController(title: titleStr, message: msgStr, preferredStyle: UIAlertControllerStyle.alert);
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil));
        
        //event handler with closure
        controller!.present(alert, animated: true, completion: nil);
        //alert.view.tintColor = UserDefaults.standard.colorForKey("color")! as UIColor
    })
}

 func presentAlertWithOptions(_ title: String, message: String,controller : AnyObject, buttons:[String], tapBlock:((UIAlertAction,Int) -> Void)?) -> UIAlertController {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert, buttons: buttons, tapBlock: tapBlock)
    controller.present(alert, animated: true, completion: nil)
   // alert.view.tintColor = UserDefaults.standard.colorForKey("color")! as UIColor

    //        instance.topMostController()?.presentViewController(alert, animated: true, completion: nil)
    return alert
}

private extension UIAlertController {
    
    convenience init(title: String?, message: String?, preferredStyle: UIAlertControllerStyle, buttons:[String], tapBlock:((UIAlertAction,Int) -> Void)?) {
        self.init(title: title, message: message, preferredStyle:preferredStyle)
        var buttonIndex = 0
        for buttonTitle in buttons {
            let action = UIAlertAction(title: buttonTitle, preferredStyle: .default, buttonIndex: buttonIndex, tapBlock: tapBlock)
            buttonIndex += 1
            self.addAction(action)
        }
    }
}

private extension UIAlertAction {
    convenience init(title: String?, preferredStyle: UIAlertActionStyle, buttonIndex:Int, tapBlock:((UIAlertAction,Int) -> Void)?) {
       
        
        self.init(title: title, style: preferredStyle) {
            (action:UIAlertAction) in
            if let block = tapBlock {
                block(action,buttonIndex)
            }
        }
    }
}

class BTAppUtility: NSObject {

    class  func leftBarButton(_ imageName : NSString,controller : UIViewController) -> UIBarButtonItem {
        let button:UIButton = UIButton.init(type: UIButtonType.custom)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.setImage(UIImage(named: imageName as String), for: UIControlState())
        button.addTarget(controller, action: #selector(leftBarButtonAction(_:)), for: UIControlEvents.touchUpInside)
        let leftBarButtonItem:UIBarButtonItem = UIBarButtonItem(customView: button)
        
        return leftBarButtonItem
    }
    
    class  func rightBarButton(_ imageName : NSString,controller : UIViewController) -> UIBarButtonItem {
        let button:UIButton = UIButton.init(type: UIButtonType.custom)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.setImage(UIImage(named: imageName as String), for: UIControlState())
        button.addTarget(controller, action: #selector(rightBarButtonAction(_:)), for: UIControlEvents.touchUpInside)
        let leftBarButtonItem:UIBarButtonItem = UIBarButtonItem(customView: button)
        
        return leftBarButtonItem
    }
    
    @objc   func leftBarButtonAction(_ button : UIButton) {
        
    }
    
    @objc   func rightBarButtonAction(_ button : UIButton) {
        
    }
    
  

}
