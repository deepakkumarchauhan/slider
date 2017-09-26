//
//  AppDelegate.swift
//  SliderApp
//
//  Created by Krati Agarwal on 05/07/17.
//  Copyright © 2017 Mobiloitte. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var sidePanel = KYDrawerController()

    var window: UIWindow?
    var navigationController  : UINavigationController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
//        let fontFamilyNames = UIFont.familyNames
//        for familyName in fontFamilyNames {
//            print("------------------------------")
//            print("Font Family Name = [\(familyName)]")
//            let names = UIFont.fontNames(forFamilyName: familyName )
//            print("Font Names = [\(names)]")
//        }

        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().enableAutoToolbar = false
        IQKeyboardManager.sharedManager().shouldResignOnTouchOutside = true

        if  UserDefaults.standard.bool(forKey: "IsRemember") {
            self.setHomeController()
        }else {
            setInitialController()
        }
        
        //>>>>>>>>>>>>>>>>>>>>> Google Place Key>>>>>>>>>>>>>>>>>>>>>>>//
        GMSPlacesClient.provideAPIKey("AIzaSyAuQtKxaMwAZDfAk9Q_htNKsA9w-PsHCOg")
       
        //>>>>>>>>>>>>>>>>>>>>> Google Map Key>>>>>>>>>>>>>>>>>>>>>>>//
        GMSServices.provideAPIKey("AIzaSyAuQtKxaMwAZDfAk9Q_htNKsA9w-PsHCOg")
      
        return true
    }

    func setInitialController() {
        
        window = UIWindow(frame:UIScreen.main.bounds)
        
        let rootVC = SALoginViewController(nibName: "SALoginViewController", bundle: nil)

        self.navigationController = UINavigationController.init(rootViewController: rootVC)
        self.navigationController?.isNavigationBarHidden = true
        self.window!.rootViewController = self.navigationController
        
        self.window?.makeKeyAndVisible()
    }
    
    
    func addSidePanel() -> KYDrawerController {
        
        let mainViewController   = SATabBarViewController()
        
        let drawerViewController =  SAMenuViewController()
        
        let navigationController = UINavigationController(rootViewController : mainViewController)
        navigationController.isNavigationBarHidden = true
        
        sidePanel.mainViewController = navigationController
        sidePanel.drawerViewController = drawerViewController
        sidePanel.setDrawerState(.closed, animated: true)
        
        return sidePanel
    }
    
    
    func setHomeController() {
        
        window = UIWindow(frame:UIScreen.main.bounds)
        
        let rootVC = addSidePanel()
        
        self.navigationController = UINavigationController.init(rootViewController: rootVC)
        self.navigationController?.isNavigationBarHidden = true
        self.window!.rootViewController = self.navigationController
        
        self.window?.makeKeyAndVisible()
    }


    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

