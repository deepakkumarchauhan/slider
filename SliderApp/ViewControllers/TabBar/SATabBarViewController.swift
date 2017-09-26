//
//  SATabBarViewController.swift
//  SliderApp
//
//  Created by Deepak Chauhan on 11/07/17.
//  Copyright © 2017 Mobiloitte. All rights reserved.
//

import UIKit

class SATabBarViewController: UIViewController {

    @IBOutlet var mainContentView: UIView!
    
    @IBOutlet var homeButton: UIButton!
    @IBOutlet var favouriteButton: UIButton!
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var profileButton: UIButton!
    
    @IBOutlet var navigationTitleLabel: UILabel!
    
    @IBOutlet var seperatorLabel: UILabel!
    @IBOutlet weak var rightNavigationBarButton: UIButton!
    var navigationRightBarButtonIndex = 0 as Int
    
    
    
    
    //MARK: -  UIView Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialMethod()

    }
    
    //MARK: -  Custom Method
    func initialMethod() {
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        // Set Initial Title Label
        self.navigationTitleLabel.text = "Events"
        setButtonImage(name:"fliter_icon")
        
        let vc = SAHomeBaseViewController(nibName: "SAHomeBaseViewController", bundle: nil)
        addViewController(vc)
        
        self.homeButton.isSelected = true
        
        // Register to receive notification
        NotificationCenter.default.addObserver(self, selector: #selector(self.changeTitleLabelToTrending), name: NSNotification.Name(rawValue: "ChangeTitleLabelTextTrending"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.changeTitleLabelToEventList), name: NSNotification.Name(rawValue: "ChangeTitleLabelTextEventList"), object: nil)
        
    }
    
    
    func addViewController(_ childController: UIViewController) {
        
            childController.view.frame = self.mainContentView.bounds;
            self.addChildViewController(childController)
            self.mainContentView.addSubview(childController.view)
            childController.didMove(toParentViewController: self)
        
    }
    
    func removeViewController(_ childController: UIViewController) {
        
        childController.willMove(toParentViewController: nil)
        childController.view.removeFromSuperview()
        childController.removeFromParentViewController()
    }
    
    
    func setTapButtonSelected(_ sender: UIButton) {
        
        self.homeButton.isSelected = false
        self.searchButton.isSelected = false
        self.favouriteButton.isSelected = false
        self.profileButton.isSelected = false
        sender.isSelected = true;
    }
    
    func setButtonImage(name:String) {
        
        self.rightNavigationBarButton.setImage(UIImage(named:name), for: .normal)
        self.rightNavigationBarButton.setImage(UIImage(named:name), for: .highlighted)
        
    }
    
    //MARK:- Observer Method
    func changeTitleLabelToTrending() {
        
        self.navigationTitleLabel.text = "Events"
        self.navigationRightBarButtonIndex = 0
        self.rightNavigationBarButton.isHidden = false

    }
    
    func changeTitleLabelToEventList() {
        
        self.navigationTitleLabel.text = "Trending"
        self.navigationRightBarButtonIndex = 0
        self.rightNavigationBarButton.isHidden = false

    }
    
    //MARK:- Dealloc Method
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "ChangeTitleLabelTextTrending"), object: nil);
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "ChangeTitleLabelTextEventList"), object: nil);
    }
    

    //MARK:- UIButton Action Methods
    
    @IBAction func menuButtonAction(_ sender: UIButton) {
        
        self.view .endEditing(true)
        let drawerController = self.navigationController?.parent as! KYDrawerController
        drawerController.setDrawerState(.opened, animated: true)
    }

    @IBAction func rightNavigationBarButtonAction(_ sender: UIButton) {

        self.view .endEditing(true)

        DispatchQueue.main.async {
                
                switch self.navigationRightBarButtonIndex {
                    
                case 0 :
                    let vc = SASetFilterVC(nibName: "SASetFilterVC", bundle: nil)
                    self.navigationController!.pushViewController(vc, animated: true)
                    
                    break
                    
                case 1:
                    let vc = SASetFilterVC(nibName: "SASetFilterVC", bundle: nil)
                    self.navigationController!.pushViewController(vc, animated: true)
                    
                    break
                    
                case 3:
                    let vc = SASettingsVC(nibName: "SASettingsVC", bundle: nil)
                    self.navigationController!.pushViewController(vc, animated: true)
                    
                    break
                   
                default:
                    break
                    
                }
        }
    }

    @IBAction func homeButtonAction(_ sender: UIButton) {
        
        self.seperatorLabel.isHidden = false
        self.navigationTitleLabel.text = "Events"
        self.navigationRightBarButtonIndex = 0
        self.rightNavigationBarButton.isHidden = false

        setButtonImage(name:"fliter_icon")
        
        setTapButtonSelected(sender)
        removeViewController(self.childViewControllers.first!)
        let vc = SAHomeBaseViewController(nibName: "SAHomeBaseViewController", bundle: nil)
        addViewController(vc)
    }
    
    @IBAction func searchButtonAction(_ sender: UIButton) {
        
        self.seperatorLabel.isHidden = false
        self.navigationTitleLabel.text = "Search"
        self.navigationRightBarButtonIndex = 1
        self.rightNavigationBarButton.isHidden = false

        setButtonImage(name:"fliter_icon")
        
        setTapButtonSelected(sender)
        removeViewController(self.childViewControllers.first!)
        let vc = SASearchViewController(nibName: "SASearchViewController", bundle: nil)
        addViewController(vc)

    }
    
    @IBAction func favouriteButtonAction(_ sender: UIButton) {
        
        self.seperatorLabel.isHidden = true
        self.navigationTitleLabel.text = "Favourites"
        self.navigationRightBarButtonIndex = 2
        self.rightNavigationBarButton.isHidden = true
        
        setTapButtonSelected(sender)
        removeViewController(self.childViewControllers.first!)
        let vc = SAFavouriteViewController(nibName: "SAFavouriteViewController", bundle: nil)
        addViewController(vc)
    
    }
    
    @IBAction func profileButtonAction(_ sender: UIButton) {
        
        self.seperatorLabel.isHidden = true
        self.navigationTitleLabel.text = "Profile"
        self.navigationRightBarButtonIndex = 3
        self.rightNavigationBarButton.isHidden = false
        
        setButtonImage(name:"setting_icon")
        
        setTapButtonSelected(sender)
        removeViewController(self.childViewControllers.first!)
        let vc = SAViewProfileVC(nibName: "SAViewProfileVC", bundle: nil)
        addViewController(vc)
    }
    
    //MARK:- Memory Management Methods
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
