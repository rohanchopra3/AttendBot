//
//  TextFieldViewClass.swift
//  AttendBot
//
//  Created by Rohan Chopra on 08/10/17.
//  Copyright © 2017 RohanChopra. All rights reserved.
//

import UIKit

class TextFieldViewClass: UITextField {

    let padding = UIEdgeInsets(top : 0 , left : 10 , bottom : 0 , right : 0)
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
         return UIEdgeInsetsInsetRect(bounds, padding)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
         return UIEdgeInsetsInsetRect(bounds, padding)
    }
}
