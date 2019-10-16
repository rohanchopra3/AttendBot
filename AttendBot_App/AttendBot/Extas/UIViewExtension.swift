//
//  UIViewExtension.swift
//  AttendBot
//
//  Created by Rohan Chopra on 04/02/18.
//  Copyright © 2018 RohanChopra. All rights reserved.
//

import Foundation
import UIKit
extension UIView{
    
    
    func setGradientBackgroundForColors(one : UIColor , two : UIColor)
    {
        let gradientlayer = CAGradientLayer()
        gradientlayer.frame = bounds
        gradientlayer.colors = [one.cgColor , two.cgColor]
        gradientlayer.locations = [0.0 , 1.0]
        gradientlayer.startPoint = CGPoint(x:1.0 , y :1.0 )
        gradientlayer.endPoint = CGPoint(x:0.0 , y :0.0 )
        layer.insertSublayer(gradientlayer, at: 0)
    }
    
}
