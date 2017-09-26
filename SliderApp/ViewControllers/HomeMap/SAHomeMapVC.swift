//
//  SAHomeMapVC.swift
//  SliderApp
//
//  Created by Krati Agarwal on 07/07/17.
//  Copyright © 2017 Mobiloitte. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps

class SAHomeMapVC: UIViewController, GMSMapViewDelegate,UITextFieldDelegate {

    @IBOutlet weak var mapView: GMSMapView!
    
    @IBOutlet weak var locationView: UIView!

    @IBOutlet var locationTextField: UITextField!
    @IBOutlet weak var locationDisplayLabel: UILabel!
   
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var locationButton: UIButton!
    
    var isFromSidePannel = Bool()
    var islandingLocationSelected = Bool()
    
    var locationMarker = GMSMarker()
    
    let dummyCoordinates = [  CLLocationCoordinate2D(latitude:27.6708, longitude:-81.5600),
                              CLLocationCoordinate2D(latitude:27.8048, longitude:-81.6523)
    ];
        
    //MARK: - UIViewController Life Cycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.menuButton.isHidden = (isFromSidePannel) ? false : true
        self.islandingLocationSelected = false
        
        setShadowOnLocationButton()
        
        setFocusOnCurrentLocation()
        
        mapView.mapType = .hybrid
        addAnnanotions()
    }
    
    //MARK: - Helper Method
    
    func setShadowOnLocationButton() {
        
        self.locationButton.layer.masksToBounds = false
        self.locationButton.layer.shadowRadius = 2.0
        self.locationButton.layer.shadowColor = UIColor.black.cgColor
        self.locationButton.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.locationButton.layer.shadowOpacity = 1
        
    }
    
    func setFocusOnCurrentLocation() {
        
        let camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: 27.6648, longitude: -81.5158, zoom: 10.0)
        mapView.camera = camera
        mapView.delegate = self
        mapView.isMyLocationEnabled = false;
        locationMarker.position = CLLocationCoordinate2D(latitude:27.6648, longitude:-81.5158)
        locationMarker.map = self.mapView
        
    }
    
    func addAnnanotions(){
    
        for latLong in dummyCoordinates  {

            let marker = GMSMarker()
            
            marker.position = latLong
            marker.title = "Florida"
            marker.icon = UIImage(named:"map_pin")
            marker.map = self.mapView
        }
    }
    
    
//    func updateMarker(coordinates: CLLocationCoordinate2D, degrees: CLLocationDegrees, duration: Double) {
//        // Keep Rotation Short
//        let locationMarker = GMSMarker()
//
//        CATransaction.begin()
//        CATransaction.setAnimationDuration(0.5)
//        locationMarker.rotation = degrees
//        CATransaction.commit()
//        
//        // Movement
//        CATransaction.begin()
//        CATransaction.setAnimationDuration(duration)
//        locationMarker.position = coordinates
//        
//        // Center Map View
//        let camera = GMSCameraUpdate.setTarget(coordinates)
//        mapView.animate(with: camera)
//        
//        CATransaction.commit()
//    }
    
    func animationOfPlane(startFrom:CGRect, endTo:CGRect) {
        
        
        self.mapView.isUserInteractionEnabled = false
        var cPt1 = CGPoint()
        var cPt2 = CGPoint()
        
        if((startFrom.origin.x - endTo.origin.x) > (startFrom.origin.y - endTo.origin.y)) {
            
            cPt1 = CGPoint(x:(startFrom.origin.x - endTo.origin.x) / 2, y:startFrom.origin.y)

            cPt2 = CGPoint(x:cPt1.x, y:endTo.origin.y)
        
        } else {
            cPt1 = CGPoint(x:startFrom.origin.x, y:(startFrom.origin.y - endTo.origin.y) / 2)
            cPt2 = CGPoint(x:endTo.origin.x, y:cPt1.y)
        }
        
        let path = UIBezierPath()
        
        let imageView = UIImageView(image: UIImage(named: "plan_icon")!)
        
        imageView.frame = CGRect(x: startFrom.origin.x, y: startFrom.origin.y, width: 70, height: 70)
        self.mapView.addSubview(imageView)
        
        UIView .animate(withDuration: 0) {

            path.move(to: CGPoint(x:startFrom.origin.x ,y: (startFrom.origin.y - (startFrom.size.height/2))))
            
            path.addCurve(to: CGPoint(x: endTo.origin.x + (endTo.size.width/2), y: endTo.origin.y - (endTo.size.height/2)), controlPoint1: cPt1, controlPoint2: cPt2)
            
//            path.addQuadCurve(to: CGPoint(x: endTo.origin.x, y: endTo.origin.y), controlPoint: cPt1)
            
            let animation = CAKeyframeAnimation(keyPath: "position")
            animation.path = path.cgPath
            
            animation.repeatCount = 0
            animation.duration = 5.0
            animation.fillMode = kCAFillModeRemoved
            animation.isRemovedOnCompletion = true
            
            imageView.layer.add(animation, forKey: "animate position along path")

            let line = CAShapeLayer()
            line.path = path.cgPath;
            line.strokeColor = UIColor.white.cgColor
            line.fillColor = UIColor.clear.cgColor
            self.mapView.layer.addSublayer(line)
            
           // imageView.frame = CGRect(x: endTo.origin.x + (endTo.size.height/2), y: endTo.origin.y - (endTo.size.height/2), width: 70, height: 70)

        }
        
        let when = DispatchTime.now() + 3.5
        
        DispatchQueue.main.asyncAfter(deadline: when) {
            imageView.removeFromSuperview()

            imageView.isHidden = true
            self.mapView.isUserInteractionEnabled = true

            let welcomAlertVC = SAWelcomAlertVC(nibName: "SAWelcomAlertVC", bundle: nil)
            
            welcomAlertVC.showCommonPopup(with: { (Int) in
                
                kAppDelegate.setHomeController()
                
            }, labelTitle: "Welcome to Tallahassee, Florida!", dissmissOnTap: true)
        }
    }
    

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view .endEditing(true)
    }
    
    //MARK: - UIButton Action Methods

    @IBAction func menuButtonAction(_ sender: UIButton) {
        
        let drawerController = self.navigationController?.parent as! KYDrawerController
        drawerController.setDrawerState(.opened, animated: true)

    }
    
    @IBAction func locationButtonAction(_ sender: UIButton) {
        
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
    }
    
    
    //MARK: - UITextField Delegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
    }

    
    
    //MARK:- Mapview delegate Methods
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {

        if (!islandingLocationSelected) {
            
            self.islandingLocationSelected = true
            
            let frameOfAnnotationViewInMapView = marker.accessibilityFrame
            let frameOfCurrentLocation = locationMarker.accessibilityFrame
            
            animationOfPlane(startFrom: frameOfCurrentLocation, endTo: frameOfAnnotationViewInMapView)

        }
    }
    
    //MARK: - Memory Handling

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

    extension SAHomeMapVC: GMSAutocompleteViewControllerDelegate {
        
        // Handle the user's selection.
        func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
            //  print("Place name: \(place.name)")
            
            self.locationTextField.text = place.name

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

extension UIImage {
    func rotateImage(withRotation radians: CGFloat) -> UIImage {
        let cgImage = self.cgImage!
        let LARGEST_SIZE = CGFloat(max(self.size.width, self.size.height))
        let context = CGContext.init(data: nil, width:Int(LARGEST_SIZE), height:Int(LARGEST_SIZE), bitsPerComponent: cgImage.bitsPerComponent, bytesPerRow: 0, space: cgImage.colorSpace!, bitmapInfo: cgImage.bitmapInfo.rawValue)!
        
        var drawRect = CGRect.zero
        drawRect.size = self.size
        let drawOrigin = CGPoint(x: (LARGEST_SIZE - self.size.width) * 0.5,y: (LARGEST_SIZE - self.size.height) * 0.5)
        drawRect.origin = drawOrigin
        var tf = CGAffineTransform.identity
        tf = tf.translatedBy(x: LARGEST_SIZE * 0.5, y: LARGEST_SIZE * 0.5)
        tf = tf.rotated(by: CGFloat(radians))
        tf = tf.translatedBy(x: LARGEST_SIZE * -0.5, y: LARGEST_SIZE * -0.5)
        context.concatenate(tf)
        context.draw(cgImage, in: drawRect)
        var rotatedImage = context.makeImage()!
        
        drawRect = drawRect.applying(tf)
        
        rotatedImage = rotatedImage.cropping(to: drawRect)!
        let resultImage = UIImage(cgImage: rotatedImage)
        return resultImage
        
        
    }
}

