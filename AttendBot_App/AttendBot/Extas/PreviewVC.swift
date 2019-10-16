//
//  PreviewVC.swift
//  AttendBot
//
//  Created by Rohan Chopra on 30/04/18.
//  Copyright © 2018 RohanChopra. All rights reserved.
//

import UIKit

class PreviewVC: UIViewController {
    @IBOutlet weak var label: UILabel!
    
    @IBAction func startUsing(_ sender: UIButton) {
         present(PresentVC(withName : step1ID
         ), animated: true, completion: nil)
    }
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var button: UIButton!
    var counter = 0
    var imagearray = [#imageLiteral(resourceName: "image1"),#imageLiteral(resourceName: "image2"),#imageLiteral(resourceName: "image9"),#imageLiteral(resourceName: "image7"),#imageLiteral(resourceName: "image5")  ]
    var values = ["Easy way to manage attendance" , "Automatically calculates class days during semester period","Use quick options to update your attendance with just one click" , "An informative view for a better understanding ", "Just select the class days to auto calaculate total classes"]
    override func viewDidLoad() {
        super.viewDidLoad()
        var swipeRight = UISwipeGestureRecognizer(target: self, action:  #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        var swipeleft = UISwipeGestureRecognizer(target: self, action:  #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeleft)
        
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc  func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.right:
                previouspage()
           
            case UISwipeGestureRecognizer.Direction.left:
                nextImage()
    
            default:
                break
            }
        }
    }
    func nextImage(){
        if counter < 4{
        imageView.slideInFromRight(duration: 0.3, completionDelegate: nil)
        counter += 1
            label.text = values[counter]
        pageControl.currentPage = counter
        imageView.image = imagearray[counter]
        }
    }
    func previouspage(){
        if counter > 0{
        imageView.slideInFromleft(duration: 0.3, completionDelegate: nil)
        counter -= 1
            label.text = values[counter]
        pageControl.currentPage = counter
        imageView.image = imagearray[counter]
        }
    }

}
