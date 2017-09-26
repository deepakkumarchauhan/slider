//
//  SAFavouriteViewController.swift
//  SliderApp
//
//  Created by Deepak Chauhan on 11/07/17.
//  Copyright © 2017 Mobiloitte. All rights reserved.
//

import UIKit
let favouriteCellID = "favouriteCellID"


class SAFavouriteViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    let ImageArray: [String] = ["event1.png","event2.png","event3.png","event4.png"]

    let favArray: [String] = ["Time After Time","Time of My Life","Simply the Best","Stand By Me"]

    
    //MARK: -  UIView Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialMethod()
    }

    //MARK: -  Custom Method
    func initialMethod() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.tableView.register(UINib(nibName: "SAFavouriteTableViewCell", bundle: nil), forCellReuseIdentifier: favouriteCellID)

}
    
    
    //MARK: -  UITableView Datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let favouriteCell = tableView.dequeueReusableCell(withIdentifier: favouriteCellID)as! SAFavouriteTableViewCell
        
        favouriteCell.eventNameLabel.text = favArray[indexPath.row]
        
        favouriteCell.shareButton.addTarget(self, action: #selector(shareButtonAction(_:)), for: UIControlEvents.touchUpInside)

      //  favouriteCell.favouriteImageView.image = UIImage(named:ImageArray[indexPath.row])
        return favouriteCell
    }
    
    
    //MARK: -  UITableView Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 219.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = SAEventDetailViewController(nibName: "SAEventDetailViewController", bundle: nil)
        vc.navigationTitleName = favArray[indexPath.row]
        vc.isFromTrending = true
        self.navigationController!.pushViewController(vc, animated: true)
        
    }

    
    func shareButtonAction(_ sender:UIButton){
        
        let bounds = UIScreen.main.bounds
        UIGraphicsBeginImageContextWithOptions(bounds.size, true, 0.0)
        self.view.drawHierarchy(in: bounds, afterScreenUpdates: false)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let activityViewController = UIActivityViewController(activityItems: [img!], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }

    
    //MARK:- Memory Management Methods
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
