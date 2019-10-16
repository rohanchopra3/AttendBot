//
//  PastelForSubViews.swift
//  AttendBot
//
//  Created by Rohan Chopra on 09/10/17.
//  Copyright © 2017 RohanChopra. All rights reserved.
//

import UIKit
import Pastel

class PastelForSubViews: UIView {
 
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubviews()
        
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
        
    }
    

    func initSubviews() {
        let pastelSubView = PastelView(frame: self.frame)
       
        pastelSubView.startPastelPoint = .bottomLeft
        pastelSubView.endPastelPoint = .topRight
        pastelSubView.animationDuration = 5.0
        pastelSubView.setColors([
            
            UIColor(red: 123/255, green: 31/255, blue: 162/255, alpha: 1.0),
            UIColor(red: 32/255, green: 77/255, blue: 162/255, alpha: 1.0),
            UIColor(red: 25/255, green: 132/255, blue: 216/255, alpha: 1.0)])
        
        pastelSubView.startAnimation()
        insertSubview(pastelSubView, at: 0)
            
     
    }
 

}
