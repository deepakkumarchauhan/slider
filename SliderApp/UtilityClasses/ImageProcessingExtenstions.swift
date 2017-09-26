//
//  ImageProcessingExtenstions.swift
//  ProjectTemplate
//
//  Created by Raj Kumar Sharma on 07/12/16.
//  Copyright © 2016 Mobiloitte. All rights reserved.
//

import UIKit

extension UIImage {
    
//    func color(color: UIColor) -> UIImage {
//        
//        var s = self.size // CGSize
//        s.height *= self.scale
//        s.width *= self.scale
//        
//        UIGraphicsBeginImageContext(s)
//        
//        var contextRect = CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: s)
//        
//        // Retrieve source image and begin image context
//        let itemImageSize = s //CGSize
//        
//        let xVal = (contextRect.size.width - itemImageSize.width)/2
//        let yVal = (contextRect.size.height - itemImageSize.height)
//        
//        //let itemImagePosition = CGPoint(x: ceilf(xFloatVal), y: ceilf(yVal)) //CGPoint
//        
//        let itemImagePosition = CGPoint(x: xVal, y: yVal) //CGPoint
//        
//        UIGraphicsBeginImageContext(contextRect.size)
//        
//        let c = UIGraphicsGetCurrentContext() //CGContextRef
//        
//        // Setup shadow
//        // Setup transparency layer and clip to mask
//        
////        c?.beginTransparencyLayer(auxiliaryInfo: nil)
////        c?.scaleBy(x: 1.0, y: -1.0)
////        
////        //CGContextRotateCTM(c, M_1_PI)
////        
////        c?.clip(to: CGRect(x: itemImagePosition.x, y: -itemImagePosition.y, width: itemImageSize.width, height: -itemImageSize.height), mask: self.cgImage!)
////        
////        // Fill and end the transparency layer
////        let colorSpace = color.CGColor.colorSpace //CGColorSpaceRef
////        let model = colorSpace?.model //CGColorSpaceModel
//////
////        let colors = color.CGColor.components
////        
////        if (model == .monochrome) {
////            c?.setFillColor(red: (colors?[0])!, green: (colors?[0])!, blue: (colors?[0])!, alpha: (colors?[1])!)
////        } else {
////            c?.setFillColor(red: (colors?[0])!, green: (colors?[1])!, blue: (colors?[2])!, alpha: (colors?[3])!)
////        }
////        
////        contextRect.size.height = -contextRect.size.height
////        contextRect.size.height -= 15
////        c?.fill(contextRect)
////        c?.endTransparencyLayer()
//        
//        let img = UIGraphicsGetImageFromCurrentImageContext() //UIImage
//        
//        let img2 = UIImage(CGImage: (img?.CGImage!)!, scale: self.scale, orientation: self.imageOrientation)
//        
//        UIGraphicsEndImageContext()
//        
//        return img2
//    }
//    
//    func resizeImage(targetSize: CGSize) -> UIImage {
//        let size = self.size
//        
//        let widthRatio  = targetSize.width  / self.size.width
//        let heightRatio = targetSize.height / self.size.height
//        
//        // Figure out what our orientation is, and use that to form the rectangle
//        var newSize: CGSize
//        if(widthRatio > heightRatio) {
//            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
//        } else {
//            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
//        }
//        
//        // This is the rect that we've calculated out and this is what is actually used below
//        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
//        
//        // Actually do the resizing to the rect using the ImageContext stuff
//        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
////        self.draw(in: rect)
//        let newImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        
//        return newImage!
//    }
//}
//
//
//// MARK:- UIImageView Extensions >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
//
//extension UIImageView {
//    
//    /*>>>>>>>>>>>>>>>>>>>>>>>>>>>> Changing icon color according to theme <<<<<<<<<<<<<<<<<<<<<<<<*/
//    func setColor(color: UIColor) {
//        
//        if let image = self.image {
//          
//            self.image = image.color(color)
//        } else {
//            print("Unable to chage color of image. Image not found")
//        }
//    }
}
