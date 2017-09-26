//
//  SATrendingViewController.swift
//  SliderApp
//
//  Created by Deepak Chauhan on 10/07/17.
//  Copyright © 2017 Mobiloitte. All rights reserved.
//

import UIKit
let trendingCellID = "trendingCellID"

class SATrendingViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    //MARK: -  UIView Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialMethod()

    }
    
    
    //MARK: -  Custom Method
    func initialMethod() {
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        self.tableView.register(UINib(nibName: "SATrendingTableViewCell", bundle: nil), forCellReuseIdentifier: trendingCellID)
        
    }
    
    //MARK: -  UITableView Datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let trendingCell = tableView.dequeueReusableCell(withIdentifier: trendingCellID)as! SATrendingTableViewCell
      //  trendingCell.userProfileImageView = UIImageView(image: UIImage(named: "dummy_user_img"))
        trendingCell.barNameLabel.text = "YumYum cha,Florida"
        trendingCell.barCategoryLabel.text = "Japanese&Koreen"
        trendingCell.descriptionLabel.text = "Lorem ispum sit amet"
        trendingCell.commentUserNameLabel.text = "Angla"
        trendingCell.numberOfCommentLabel.text = "6 common interest"

       // trendingCell.commentUserProfileImageView = UIImageView(image: UIImage(named: "dummy_user_img1"))
       // trendingCell.productImageView = UIImageView(image: UIImage(named: "food"))

        return trendingCell
    }
    
    
    //MARK: -  UITableView Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 417.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = SAEventDetailViewController(nibName: "SAEventDetailViewController", bundle: nil)
        vc.navigationTitleName = "YumYum cha,Florida"
        vc.isFromTrending = true
        self.navigationController!.pushViewController(vc, animated: true)

    }


    //MARK:- Memory Management Methods
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
