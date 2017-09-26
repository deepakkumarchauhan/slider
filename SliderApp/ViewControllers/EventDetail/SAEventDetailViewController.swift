//
//  SAEventDetailViewController.swift
//  SliderApp
//
//  Created by Deepak Chauhan on 07/07/17.
//  Copyright © 2017 Mobiloitte. All rights reserved.
//

import UIKit

let eventDetailCellID = "eventDetailCellID"
let eventDetailDescCellID = "eventDetailDescCellID"
let nearByCellID = "nearByCollectionCellID"
let nearByCollectionCellID = "nearCollectionCellID"
let headerCellID = "headerCellID"



class SAEventDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet var navigationTitleLabel: UILabel!
    @IBOutlet var favouriteButton: UIButton!
    @IBOutlet var bookButton: UIButton!
    @IBOutlet var tableView: UITableView!
    
    var isFromTrending = false
    var navigationTitleName = String()
    
    
    //MARK: -  UIView Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialMethod()

    }
    
    
    //MARK: -  Custom Method
    func initialMethod() {
        
        // Register TableView
        self.tableView.register(UINib(nibName: "SAEventDetailTableViewCell", bundle: nil), forCellReuseIdentifier: eventDetailCellID)
        self.tableView.register(UINib(nibName: "SAEventDetailDescTableViewCell", bundle: nil), forCellReuseIdentifier: eventDetailDescCellID)
        self.tableView.register(UINib(nibName: "SANearByEventTableViewCell", bundle: nil), forCellReuseIdentifier: nearByCellID)
        self.tableView.register(UINib(nibName: "SAHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: headerCellID)

        self.tableView.estimatedRowHeight = 100
        
        // Set Shadow
        self.bookButton.layer.masksToBounds = false
        self.bookButton.layer.shadowRadius = 1.0
        self.bookButton.layer.shadowColor = UIColor.black.cgColor
        self.bookButton.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.bookButton.layer.shadowOpacity = 1
        
        self.navigationTitleLabel.text = navigationTitleName

        if isFromTrending {
            self.bookButton.isHidden = true
        }
    }
    
    
    //MARK: -  UITableView Datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 2
        }else if section == 1 {
            return 1
        }
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let detailCell = tableView.dequeueReusableCell(withIdentifier: eventDetailCellID)as! SAEventDetailTableViewCell
        let detailDescCell = tableView.dequeueReusableCell(withIdentifier: eventDetailDescCellID)as! SAEventDetailDescTableViewCell
        let nearByCell = tableView.dequeueReusableCell(withIdentifier: nearByCellID)as! SANearByEventTableViewCell
        
        nearByCell.nearyByCollectionView.register(UINib(nibName: "SANearByCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: nearByCollectionCellID)
        
        nearByCell.nearyByCollectionView.delegate = self
        nearByCell.nearyByCollectionView.dataSource = self
        
        detailDescCell.descDateLabel.isHidden = true
        detailDescCell.descStarView.isHidden = true
        
        detailDescCell.eventNameLabel.font = UIFont .systemFont(ofSize: 15.0)
        detailDescCell.eventDescriptionLabel.font = UIFont .systemFont(ofSize: 13.0)
        
        // Target Method
        detailCell.inviteFriendButton.addTarget(self, action: #selector(inviteButtonAction(_:)), for: UIControlEvents.touchUpInside)
        detailCell.peopleInterestedButton.addTarget(self, action: #selector(interestedButtonAction(_:)), for: UIControlEvents.touchUpInside)
        detailCell.groupChatButton.addTarget(self, action: #selector(groupChatButtonAction(_:)), for: UIControlEvents.touchUpInside)



        if indexPath.section == 0 {
            if indexPath.row == 0 {
                detailCell.eventnameLabel.text = navigationTitleName
                return detailCell
            }else {
                detailDescCell.eventNameLabel.text = "Description"
                return detailDescCell
            }
        }
        else if indexPath.section == 1 {
            return nearByCell
        }else {
            detailDescCell.eventNameLabel.font = UIFont .systemFont(ofSize: 13.0)
            detailDescCell.eventDescriptionLabel.font = UIFont .systemFont(ofSize: 10.0)
            detailDescCell.descDateLabel.isHidden = false
            detailDescCell.descStarView.isHidden = false
            detailDescCell.eventNameLabel.text = "Eater"
            return detailDescCell
         }
    }
    
    
    //MARK: -  UITableView Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                return 100
            }
        }else if indexPath.section == 1 {
            
            if isFromTrending {
                return 0
            }
            return 105
        }
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 {
            return 0
        }
        else {
            if isFromTrending && section == 1 {
                return 0
            }
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        
        let headerCell = tableView.dequeueReusableCell(withIdentifier: headerCellID)as! SAHeaderTableViewCell
        if section == 1 {
            headerCell.headerTitleLabel.text = "Similer Events Near by your location"
        }
        else if section == 2 {
            headerCell.headerTitleLabel.text = "Reviews and Rating"
        }
        
        return headerCell
    }

    
    //MARK: -  UICollectionView Datasource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: nearByCollectionCellID, for: indexPath)
        
        return collectionCell
    }
    
    
    //MARK:- Selector Method
    func inviteButtonAction(_ sender: UIButton) {
        
        let vc = SAInviteFrieldViewController(nibName: "SAInviteFrieldViewController", bundle: nil)
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    func interestedButtonAction(_ sender: UIButton) {
        
        let vc = SAInterestedPeopleViewController(nibName: "SAInterestedPeopleViewController", bundle: nil)
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    func groupChatButtonAction(_ sender: UIButton) {
        
        let vc = SAChatViewController(nibName: "SAChatViewController", bundle: nil)
        vc.isGroupChat = true
        self.navigationController!.pushViewController(vc, animated: true)

    }
    
    

    //MARK:- UIButton Action
    @IBAction func backButtonAction(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }

    @IBAction func findFriendButtonAction(_ sender: UIButton) {
        
        let vc = SAFindFriendViewController(nibName: "SAFindFriendViewController", bundle: nil)
        vc.fromDetail = true
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func favouriteButtonAction(_ sender: UIButton) {
        
    }
    
    @IBAction func bookButtonAction(_ sender: UIButton) {
        
        let vc = SATicketBookVC(nibName: "SATicketBookVC", bundle: nil)
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    @IBAction func writeReviewButtonAction(_ sender: UIButton) {
        
        let vc = SARatingViewController(nibName: "SARatingViewController", bundle: nil)
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    //MARK:- Memory Management Methods
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
