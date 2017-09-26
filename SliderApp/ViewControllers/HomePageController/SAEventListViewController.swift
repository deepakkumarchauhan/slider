//
//  SAEventListViewController.swift
//  SliderApp
//
//  Created by Deepak Chauhan on 10/07/17.
//  Copyright © 2017 Mobiloitte. All rights reserved.
//

import UIKit

let eventCellID = "eventListCollectionCellID"

class SAEventListViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet var daysViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var navigationHeightConstraint: NSLayoutConstraint!
    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet var navigationTitleLabel: UILabel!
    
    @IBOutlet var seperatorLabel: UILabel!
    @IBOutlet var calendarButton: UIButton!
    @IBOutlet var menuButton: UIButton!
    @IBOutlet var weekendButton: UIButton!
    @IBOutlet var tomorrowButton: UIButton!
    @IBOutlet var todayButton: UIButton!
    
    var isFromSideMenu = Bool()
    var isFromSearchMenu = Bool()

    var navigationTitle = String()
    
    
    let eventsArray: [String] = ["Time After Time","Time of My Life","Simply the Best","Stand By Me","Shores of Venice","Voices That Care","Written in the Stars","Walk This Way","Forever Young","Unforgettable"]

    //MARK: -  UIView Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialMethod()
    }
    
    //MARK: -  Custom Method
    func initialMethod() {
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        if isFromSideMenu {
            
            if isFromSearchMenu {
                menuButton.setImage(UIImage(named:"back_icon"), for: .normal)
                menuButton.setImage(UIImage(named:"back_icon"), for: .highlighted)
            }
            self.daysViewHeightConstraint.constant = 0
            self.navigationHeightConstraint.constant = 65
            self.calendarButton.isHidden = true
            self.weekendButton.isHidden = true
            self.tomorrowButton.isHidden = true
            self.todayButton.isHidden = true
            self.seperatorLabel.isHidden = true
            self.navigationTitleLabel.isHidden = false
            self.menuButton.isHidden = false
            self.navigationTitleLabel.text = navigationTitle
        }else {
            self.daysViewHeightConstraint.constant = 50
            self.navigationHeightConstraint.constant = 0
            self.calendarButton.isHidden = false
            self.weekendButton.isHidden = false
            self.tomorrowButton.isHidden = false
            self.todayButton.isHidden = false
            self.seperatorLabel.isHidden = false
            self.navigationTitleLabel.isHidden = true
            self.menuButton.isHidden = true
        }
        
        self.collectionView.register(UINib(nibName:"SAEventListCollectionViewCell",bundle:nil), forCellWithReuseIdentifier: eventCellID)
    }
    
    
    //MARK: -  UICollection Datasource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return eventsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: eventCellID,
                                                      for: indexPath) as! SAEventListCollectionViewCell
        
        cell.eventNameLabel.text = eventsArray[indexPath.row]
        cell.eventLocationButton.addTarget(self, action: #selector(locationButtonAction(_:)), for: UIControlEvents.touchUpInside)

        return cell
    }
    
    
    //MARK: -  UICollection Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = SAEventDetailViewController(nibName: "SAEventDetailViewController", bundle: nil)
        vc.navigationTitleName = eventsArray[indexPath.row]
        self.navigationController!.pushViewController(vc, animated: true)
        
    }
    
    
    //MARK: -  Selector Methods
    func locationButtonAction(_ sender : UIButton){

        let vc = SAMapNavigationViewController(nibName: "SAMapNavigationViewController", bundle: nil)
        self.navigationController!.pushViewController(vc, animated: true)
        

    }
    

    //MARK:- UIButton Action
    @IBAction func menubuttonAction(_ sender: UIButton) {
        
        if isFromSearchMenu {
            _ = self.navigationController?.popViewController(animated: true)
        }else {
            let drawerController = self.navigationController?.parent as! KYDrawerController
            drawerController.setDrawerState(.opened, animated: true)
        }
    }
    
    
    @IBAction func todayButtonAction(_ sender: UIButton) {
    }
    
    
    @IBAction func weekendButtonAction(_ sender: UIButton) {
    }
    
    
    @IBAction func tomorrowButtonAction(_ sender: UIButton) {
    }
    
    
    @IBAction func calendarButtonAction(_ sender: UIButton) {
        
        let vc = SACalendarViewController(nibName: "SACalendarViewController", bundle: nil)
        vc.fromHome = true
        self.navigationController!.pushViewController(vc, animated: true)

    }
    
    //MARK:- Memory Management Methods
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


extension SAEventListViewController : UICollectionViewDelegateFlowLayout {
    //1
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize  {
        
        return CGSize(width: (self.collectionView.frame.size.width/2), height: 250)
    }
    
  }

