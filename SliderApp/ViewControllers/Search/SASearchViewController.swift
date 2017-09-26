//
//  SASearchViewController.swift
//  SliderApp
//
//  Created by Deepak Chauhan on 10/07/17.
//  Copyright © 2017 Mobiloitte. All rights reserved.
//

import UIKit

let searchEventCellID = "searchCollectionCell"

class SASearchViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate {

    @IBOutlet var collectionView: UICollectionView!
    
    let ImageArray: [String] = ["dummy_happy_club_image@2x.png","dummy_night_club@2x.png","dummy_img1@3x.png","dummy_img3@3x.png"]
    let titleArray: [String] = ["Happy Hour","Night Life","Events","Music"]


    //MARK: -  UIView Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialMethod()
    }

    
    //MARK: -  Custom Method
    func initialMethod() {
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.collectionView.register(UINib(nibName:"SASearchCollectionViewCell",bundle:nil), forCellWithReuseIdentifier: searchEventCellID)
    }
    
    
    //MARK: -  UICollection Datasource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ImageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let searchCell = collectionView.dequeueReusableCell(withReuseIdentifier: searchEventCellID,
                                                      for: indexPath)as! SASearchCollectionViewCell
        
        searchCell.eventImageView.image = UIImage(named:ImageArray[indexPath.row])
        searchCell.eventTitleLabel.text = titleArray[indexPath.row]

        return searchCell
    }
    
    
    //MARK: -  UICollection Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = SAEventListViewController(nibName: "SAEventListViewController", bundle: nil)
        vc.isFromSideMenu = true
        vc.isFromSearchMenu = true
        vc.navigationTitle = titleArray[indexPath.row]
        self.navigationController!.pushViewController(vc, animated: true)
        
    }
    

    //MARK:- UITextField Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view .endEditing(true)
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var str:NSString = textField.text! as NSString
        str = str.replacingCharacters(in: range, with: string) as NSString
        
        if (str.length > 100) {
            return false
        }
        
        return true
    }
    
    
    //MARK:- Memory Management Methods
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension SASearchViewController : UICollectionViewDelegateFlowLayout {
    //1
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize  {
        
        return CGSize(width: (self.collectionView.frame.size.width/2-5), height: 225)
    }
}
