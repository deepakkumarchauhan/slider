//
//  SAInterestedPeopleViewController.swift
//  SliderApp
//
//  Created by Deepak Chauhan on 06/07/17.
//  Copyright © 2017 Mobiloitte. All rights reserved.
//

import UIKit

let cellInterestedIdentifier = "interestedCellId"

class SAInterestedPeopleViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!

    let interestedPeopleArray: [String] = ["John Hilter","Jackob Won","William","Andrew Tom","Hitlor","Johney"]
    
    
    //MARK: -  UIView Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialMethod()
    }
    
    
    //MARK: -  Custom Method
    func initialMethod() {
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        // Register TableView
        self.tableView.register(UINib(nibName: "SAInterestedPeopleTableViewCell", bundle: nil), forCellReuseIdentifier: cellInterestedIdentifier)
    }
    
    
    //MARK: -  UITableView Datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interestedPeopleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellInterestedIdentifier)as! SAInterestedPeopleTableViewCell
        
        cell.nameLabel.text = self.interestedPeopleArray[indexPath.row]
        cell.connectButton.tag = indexPath.row+100
        cell.connectButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        
        return cell
    }
    
    
    //MARK: -  UITableView Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    
    //MARK: -  Selector Method
    func buttonTapped(_ sender : UIButton){
        
        let vc = SAChatViewController(nibName: "SAChatViewController", bundle: nil)
        vc.userName = self.interestedPeopleArray[sender.tag-100]
        self.navigationController!.pushViewController(vc, animated: true)

    }
    
    //MARK: -  UIButton Action
    @IBAction func backButtonAction(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }

    
    //MARK:- Memory Management Methods
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
