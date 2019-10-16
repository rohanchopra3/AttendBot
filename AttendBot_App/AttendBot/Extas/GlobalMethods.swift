//
//  GlobalMethods.swift
//  AttendBot
//
//  Created by Rohan Chopra on 02/01/18.
//  Copyright © 2018 RohanChopra. All rights reserved.
//

import UIKit
import UserNotifications
// contains all the global methods

//To present an error

//storyboard IDS

let step1ID = "Step1VC"
let Step2ID = "Step2VC"
let HomepageID = "HomeNavbar"
//quickOptions
let QuickselectionSubjectsID = "quickSubjectSelection"
//settings
let settingsID = "settings"
let updatesubjectsID = "updateSubjects"
let updateRegisterationID = "updateRegisteration"

//end
func ShowError(with : String)-> UIAlertController
{
    let alert = UIAlertController(title: "Oops", message: with, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "Done", style: UIAlertAction.Style.cancel, handler: nil))
    
    return alert
}

func ShowError(with : String, title : String)-> UIAlertController
{
    let alert = UIAlertController(title: title, message: with, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "Done", style: UIAlertAction.Style.cancel, handler: nil))
    
    return alert
}

//TO present a new view
func PresentVC(withName : String) -> UIViewController {
    let storyboard = UIStoryboard(name:"Main",bundle : nil)
    let VCtoPresent = storyboard.instantiateViewController(withIdentifier: withName)
    
    return VCtoPresent
}


//let  VeryDarkGray = UIColor(red : 85.0/255.0 , green : 85.0/255.0 , blue : 85.0/255.0 , alpha : 1.0 )
//let darkgray = UIColor(red : 13.0/255.0 , green : 13.0/255.0 , blue : 13.0/255.0 , alpha : 1.0 )
let darkgray = #colorLiteral(red: 0.04612638512, green: 0.1728793096, blue: 0.3164459074, alpha: 1)
let VeryDarkGray = #colorLiteral(red: 0.4095264451, green: 0.4528783698, blue: 0.5144845905, alpha: 1)
extension UIView {
    // Name this function in a way that makes sense to you...
    // slideFromLeft, slideRight, slideLeftToRight, etc. are great alternative names
    func slideInFromRight(duration: TimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        // Create a CATransition animation
        let slideInFromLeftTransition = CATransition()
        
        // Set its callback delegate to the completionDelegate that was provided (if any)
        if let delegate: AnyObject = completionDelegate {
            slideInFromLeftTransition.delegate = delegate as? CAAnimationDelegate
        }
        
        // Customize the animation's properties
        slideInFromLeftTransition.type = CATransitionType.push
        slideInFromLeftTransition.subtype = CATransitionSubtype.fromRight
        slideInFromLeftTransition.duration = duration
        slideInFromLeftTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        slideInFromLeftTransition.fillMode = CAMediaTimingFillMode.removed
        
        // Add the animation to the View's layer
        self.layer.add(slideInFromLeftTransition, forKey: "slideInFromLeftTransition")
    }
    func slideInFromleft(duration: TimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        // Create a CATransition animation
        let slideInFromLeftTransition = CATransition()
        
        // Set its callback delegate to the completionDelegate that was provided (if any)
        if let delegate: AnyObject = completionDelegate {
            slideInFromLeftTransition.delegate = delegate as? CAAnimationDelegate
        }
        
        // Customize the animation's properties
        slideInFromLeftTransition.type = CATransitionType.push
        slideInFromLeftTransition.subtype = CATransitionSubtype.fromLeft
        slideInFromLeftTransition.duration = duration
        slideInFromLeftTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        slideInFromLeftTransition.fillMode = CAMediaTimingFillMode.removed
        
        // Add the animation to the View's layer
        self.layer.add(slideInFromLeftTransition, forKey: "slideInFromLeftTransition")
    }
}

func sendNotification() {
    let content = UNMutableNotificationContent()
    content.title = "Update the attendance "
    content.body = "Dont forget to update the attendance for today."
    content.sound = UNNotificationSound.default
    var dateComponents = DateComponents()
    dateComponents.hour = 20
    dateComponents.minute = 0
    dateComponents.second = 0
    
    let trigger = UNCalendarNotificationTrigger(
        dateMatching: dateComponents,
        repeats: true)
    
    let request = UNNotificationRequest(identifier: "pizza.reminder", content: content, trigger: trigger)
    
    UNUserNotificationCenter.current().add(request) { (error) in
        if let error = error {
            print("error in adding \(error.localizedDescription)")
        }
    }
    print("added notification:\(request.identifier)")
}


func ReturnDateFromString(_ str : String) -> Date{
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd MMMM yyyy"
    
    return dateFormatter.date(from: str)!
    
}


func ReturnStringFromDate(_ date : Date) -> String{
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd MMMM yyyy"
    
    return dateFormatter.string(from: date)
    
}
