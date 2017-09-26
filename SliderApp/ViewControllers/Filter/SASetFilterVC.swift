//
//  SASetFilterVC.swift
//  SliderApp
//
//  Created by Krati Agarwal on 12/07/17.
//  Copyright © 2017 Mobiloitte. All rights reserved.
//

import UIKit
import GooglePlaces

class SASetFilterVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var locationButton: UIButton!
    
    @IBOutlet weak var searchTextField: SATexFieldSubClass!
    
    @IBOutlet weak var searchLocationView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var tableViewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    
    var locationArray = [String]()

    var categoryArray = ["All", "Acoustic", "Christian & Gospal", "Classical", "Country & Folk", "Dance & Electonic"]

 
    //MARK: - UIViewController Life Cycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        initialMethod()
    }

    //MARK: - Helper Method
    
    func initialMethod() {
        
        // Register TableView
        self.tableView.register(UINib(nibName: "SATitleLabelTVCell", bundle: nil), forCellReuseIdentifier: "SATitleLabelTVCell")
        
        self.tableView.estimatedRowHeight = 60
        
        let when = DispatchTime.now() + 0.2 
        DispatchQueue.main.asyncAfter(deadline: when) {
            
            self.tableViewHeightConstraint.constant = self.tableView.contentSize.height
            
        }

        // set default category button selected
        setCategorySelected()
        
    }
    
    func setCategorySelected() {
       
        self.categoryButton.backgroundColor = UIColor.white
        self.locationButton.backgroundColor = UIColor.clear
        
        self.categoryButton.isSelected = true
        self.locationButton.isSelected = false

        self.searchLocationView.isHidden = true
        self.tableViewTopConstraint.constant = 130.0

    }
    
    func setLocationSelected() {
        
        self.locationButton.backgroundColor = UIColor.white
        self.categoryButton.backgroundColor = UIColor.clear
        
        self.locationButton.isSelected = true
        self.categoryButton.isSelected = false
        
        self.searchLocationView.isHidden = false
        self.tableViewTopConstraint.constant = 200.0

    }
    
    //MARK: - UIButton Action Methods

    @IBAction func locationButtobAction(_ sender: UIButton) {
        
        self.view .endEditing(true)

        if (self.locationButton.isSelected == false) {
            
            setLocationSelected()
            UIView.transition(with: tableView,
                              duration: 1.0,
                              options: .curveEaseOut,
                              animations: {
                                self.tableViewHeightConstraint.constant = 0

                                self.tableView.reloadData()
                                
            })
            
        }
        
    }
    
    @IBAction func categoryButtonAction(_ sender: UIButton) {
        
        self.view .endEditing(true)

        if (self.categoryButton.isSelected == false) {
            setCategorySelected()
            
            UIView.transition(with: tableView,
                              duration: 1.0,
                              options: .curveEaseOut,
                              animations: {
                                
                                self.tableView.reloadData()

                                let when = DispatchTime.now() + 0.2
                                DispatchQueue.main.asyncAfter(deadline: when) {
                                    
                                    self.tableViewHeightConstraint.constant = self.tableView.contentSize.height
                                    
                                }
            })
        }
       
    }
    
    @IBAction func doneButtonAction(_ sender: UIButton) {
        self.view .endEditing(true)

        _ =   self.navigationController?.popViewController(animated: true)

    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.view .endEditing(true)
        _ =   self.navigationController?.popViewController(animated: true)
        
    }
    
    //MARK: - UITextField Delegate Methods
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
        var str:NSString = textField.text! as NSString
        str = str.replacingCharacters(in: range, with: string) as NSString
        
        placeAutocomplete(locationStr: TRIM_SPACE(str: str) as! String)

        return true
    }
    
    //MARK: -  UIButton Selector Method
    
    func selectFilteOptionSelector(_ sender : UIButton){
        
        sender.isSelected = !sender.isSelected
    }

    //MARK: -  UITableView Delegate and Datasource Methods
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.categoryButton.isSelected {
            return categoryArray .count
        } else {
            return locationArray .count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

         let cell = tableView.dequeueReusableCell(withIdentifier: "SATitleLabelTVCell")as! SATitleLabelTVCell
        
        cell.titleLabel.text = (self.categoryButton.isSelected) ? categoryArray[indexPath.row] : (self.locationArray .count == 0) ? "" :locationArray[indexPath.row]
        
        cell.checkButton.addTarget(self, action: #selector(selectFilteOptionSelector(_:)), for: .touchUpInside)

        return cell
    
    }
    
    func placeAutocomplete(locationStr:String) {
        
        if locationStr.length == 0 {
            
            locationArray.removeAll()
            self.tableView .reloadData()
        } else {
            
            let filter = GMSAutocompleteFilter()
            let placesClient = GMSPlacesClient()
            
            filter.type = .establishment
            placesClient.autocompleteQuery(locationStr, bounds: nil, filter: filter, callback: {(results, error) -> Void in
                
                if let error = error {
                    
                    print("Autocomplete error \(error)")
                    
                    self.locationArray.removeAll()
                    self.tableView .reloadData()
                    
                    return
                } else {
                    
                    self.locationArray.removeAll()
                    
                    if let results = results {
                        for result in results {
                            print("Result \(result.attributedFullText) with placeID \(result.placeID)")
                            
                            self.locationArray.append(result.attributedFullText.string)
                        }
                        
                    }
                    
                    self.tableView .reloadData()
                    
                }
                
            })

        }
        
        let when = DispatchTime.now() + 0.2

        DispatchQueue.main.asyncAfter(deadline: when) {
            
            if self.tableView.contentSize.height < Window_Width-214 {
                self.tableViewHeightConstraint.constant = self.tableView.contentSize.height
            }else {
                self.tableViewHeightConstraint.constant = Window_Height-214
            }
            
        }
    }
    
    //MARK: - Memory Handling

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
