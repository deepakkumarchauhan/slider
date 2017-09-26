//
//  SAMapNavigationViewController.swift
//  SliderApp
//
//  Created by Deepak Chauhan on 13/07/17.
//  Copyright © 2017 Mobiloitte. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps

class SAMapNavigationViewController: UIViewController,GMSMapViewDelegate,UITextFieldDelegate {

    @IBOutlet var sourceTextField: UITextField!
    @IBOutlet var destinationTextField: UITextField!
    @IBOutlet var mapView: GMSMapView!
    var sourceLatLong = CLLocationCoordinate2D()
    var destinationLatLong = CLLocationCoordinate2D()

    var textFieldTag = String()
    

    //MARK: -  UIView Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialMethod()

    }
    
    //MARK: -  Custom Method
    func initialMethod() {
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        let camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: 27.039038, longitude: -80.481957, zoom: 5.0)
        mapView.camera = camera
        mapView.mapType = .normal
        mapView.delegate = self
        
        self.sourceLatLong.latitude = 27.039038
        self.sourceLatLong.longitude = -80.481957

        self.destinationLatLong.latitude = 36.894374
        self.destinationLatLong.longitude = -77.896651

        
        self.sourceTextField.text = "Florida, United States"
        self.destinationTextField.text = "Virginia, United States"

        self.getPolylineRoute(from: self.sourceLatLong, to: self.destinationLatLong)

    }


    
    //MARK:- UITextField Delegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField.tag == 100 {
            textFieldTag = "100"
        }else {
            textFieldTag = "101"
         }
        
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
    }
    
    
    func getPolylineRoute(from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D){
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let url = URL(string: "http://maps.googleapis.com/maps/api/directions/json?origin=\(source.latitude),\(source.longitude)&destination=\(destination.latitude),\(destination.longitude)&sensor=false&mode=driving")!
        
        
        DispatchQueue.main.async {
            let task = session.dataTask(with: url, completionHandler: {
                (data, response, error) in
                if error != nil {
                    print(error!.localizedDescription)
                }else{
                    do {
                        if let json : [String:Any] = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]{
                            
                            let routes = json["routes"] as? [Any]
                            let overview_polyline = routes?[0] as?[String:Any]
                            let overLays = overview_polyline?["overview_polyline"] as?[String:Any]
                            
                            let polyString = overLays?["points"] as?String
                           
                            //Call this method to draw path on map
                            self.showPath(polyStr: polyString!)
                        }
                        
                    }catch{
                        print("error in JSONSerialization")
                    }
                }
            })
            task.resume()

        }
    }
    
    
    func showPath(polyStr :String){
        
        DispatchQueue.main.async {
        self.mapView.clear()

        let sourceMarker = GMSMarker()
        let destinationMarker = GMSMarker()
        sourceMarker.position = self.sourceLatLong
        sourceMarker.title = "Florida, United States"
        destinationMarker.position = self.destinationLatLong
        destinationMarker.title = "Virginia, United States"

        sourceMarker.map = self.mapView
        destinationMarker.map = self.mapView
        let path = GMSPath(fromEncodedPath: polyStr)
        let polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 3.0
        polyline.map = self.mapView // Your map view
        }
    }

    @IBAction func backButtonAction(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }

    //MARK:- Memory Management Methods
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


extension SAMapNavigationViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        //  print("Place name: \(place.name)")
        
        if textFieldTag == "100" {
            self.sourceTextField.text = place.name
            self.sourceLatLong = place.coordinate
        }else {
            self.destinationTextField.text = place.name
            self.destinationLatLong = place.coordinate
       }
        
        if self.sourceTextField.text?.length != 0 && self.destinationTextField.text?.length != 0 {
            
            let camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: sourceLatLong.latitude, longitude: sourceLatLong.longitude, zoom: 8.0)
            mapView.camera = camera

            self.getPolylineRoute(from: self.sourceLatLong, to: self.destinationLatLong)
        }
        
      //  self.searchtextField.text = place.name
        
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
