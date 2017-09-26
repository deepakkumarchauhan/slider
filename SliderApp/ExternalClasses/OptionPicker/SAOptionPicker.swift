//
//  SAOptionPicker.swift
//  SliderApp
//
//  Created by Deepak Chauhan on 11/07/17.
//  Copyright © 2017 Mobiloitte. All rights reserved.
//

import UIKit

private extension Selector {
    static let buttonTapped = #selector(SAOptionPicker.buttonTapped)
    static let deviceOrientationDidChange = #selector(DatePickerDialog.deviceOrientationDidChange)
}

class SAOptionPicker: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {

    public typealias optionPickerCallback = ( String? ) -> Void

    
    var picker = UIPickerView()
    var pickerArray: [String] = []
    var tempView = UIView()
    var currentPick:Int = 0
    var label = UILabel()
    

    
    private var callback: optionPickerCallback?

    
      open func showOptionPicker(_ title: String, doneButtonTitle: String = "Done", cancelButtonTitle: String = "Cancel", array: [String] = [], callback: @escaping optionPickerCallback) {
        
        pickerArray = array
        
        // UIPickerView
        self.picker = UIPickerView(frame:CGRect(x: 0, y: Window_Width, width: Window_Width, height: 216))
        self.picker.delegate = self
        self.picker.dataSource = self
        self.picker.backgroundColor = UIColor.white
        self.callback = callback
        
        // ToolBar
        let toolBar = UIToolbar(frame:CGRect(x: 5, y: Window_Width-216, width: Window_Width-10, height: 40))

        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(buttonTapped))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        
        self.tempView.frame = (kAppDelegate.window?.bounds)!
        self.tempView.backgroundColor = UIColor.black
        self.tempView.alpha = 0.0
        kAppDelegate.window?.addSubview(tempView)
        kAppDelegate.window?.addSubview(toolBar)
        kAppDelegate.window?.addSubview(picker)
        kAppDelegate.window?.bringSubview(toFront: picker)
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerArray.count
    }
    
     func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        self.label = UILabel(frame:CGRect(x: 0, y:0.5, width: pickerView.bounds.size.width * 0.8, height: 25.0))
        self.label.textAlignment = .center
        self.label.backgroundColor = UIColor.clear
        
        if row < pickerArray.count {
            self.label.text = pickerArray[row]
        }
        
        return self.label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        currentPick = row
        
    }
    
    // Mark Selector Method
    func buttonTapped() {
        
        self.callback?(pickerArray[currentPick])
        self.removeFromSuperView()
    }
    
    func removeFromSuperView() {
        
        tempView .removeFromSuperview()
        kAppDelegate.window?.removeFromSuperview()
        
    }
    
    func cancelClick() {
        self.removeFromSuperView()
        
    }
    
}
