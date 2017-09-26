//
//  SAFindFriendViewController.swift
//  SliderApp
//
//  Created by Deepak Chauhan on 12/07/17.
//  Copyright © 2017 Mobiloitte. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps

class SAFindFriendViewController: UIViewController,GMSMapViewDelegate,UITextFieldDelegate {

    var index:Int = 0

    @IBOutlet var searchButton: UIButton!
    @IBOutlet var seperatorLabel: UILabel!
    @IBOutlet var searchViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var mapView: GMSMapView!
    @IBOutlet var searchtextField: SATexFieldSubClass!
    let userNameArray: [String] = ["Jackob Won","William","Andrew Tom"]


    @IBOutlet var searchView: UIView!
    var fromDetail = Bool()
    
    
    let dummyCoordinates = [  CLLocationCoordinate2D(latitude:27.6648, longitude:-81.5158),
                              CLLocationCoordinate2D(latitude:27.6708, longitude:-81.5600),
                              CLLocationCoordinate2D(latitude:27.8048, longitude:-81.6523)
    ];

    //MARK: -  UIView Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialMethod()

    }

    //MARK: -  Custom Method
    func initialMethod() {
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        let camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: 27.6648, longitude: -81.5158, zoom: 8.0)
        mapView.camera = camera
        mapView.mapType = .hybrid
        
        mapView.delegate = self
        addAnnanotions()
        
        if fromDetail {
            self.searchViewHeightConstraint.constant = 0
            self.searchView.isHidden = true
            self.searchtextField.isHidden = true
            self.searchButton.isHidden = true
            self.titleLabel.text = "Friends Near You"
            self.seperatorLabel.isHidden = true
        }
    }
    
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        // 1
        let customInfoWindow = Bundle.main.loadNibNamed("SAMarkerInfoWindow", owner: self, options: nil)?[0] as! SAMarkerInfoWindow
        customInfoWindow.nameLabel.text = userNameArray[index]
        index += 1
        
        if index == 2 {
            index = 0
        }
        return customInfoWindow
    }
    
    
    //MARK: - Helper Method
    func addAnnanotions(){
        
        for latLong in dummyCoordinates  {
            
            let marker = GMSMarker()
            
            marker.position = latLong
            
            marker.title = "Florida"
            if fromDetail {
             //   marker.title = userNameArray[index]
              //  index += 1
            }else {
                marker.icon = UIImage(named:"map_pin")
            }
            marker.map = self.mapView
        }
    }
    
    
    //MARK:- UITouch Method
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view .endEditing(true)
    }

    
    //MARK:- UITextField Delegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
    }

    
    //MARK:- UIButton Action
    @IBAction func backButtonAction(_ sender: UIButton) {
        
        _ = self.navigationController?.popViewController(animated: true)

    }
    
    
    //MARK:- Memory Management Methods
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension SAFindFriendViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        //  print("Place name: \(place.name)")
        
        self.searchtextField.text = place.name
        
        // print("Place address: \(place.formattedAddress)")
        //  print("Place attributions: \(place.attributions)")
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}

