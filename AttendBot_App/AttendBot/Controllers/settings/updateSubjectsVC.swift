//
//  updateSubjectsVC.swift
//  AttendBot
//
//  Created by Rohan Chopra on 14/02/18.
//  Copyright © 2018 RohanChopra. All rights reserved.
//

import UIKit
import RealmSwift
import Instructions

class updateSubjectsVC: UIViewController, UITextFieldDelegate ,CoachMarksControllerDataSource{
    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkViewsAt index: Int, madeFrom coachMark: CoachMark) -> (bodyView: CoachMarkBodyView, arrowView: CoachMarkArrowView?) {
        let coachViews = coachMarksController.helper.makeDefaultCoachViews(withArrow: true, arrowOrientation: coachMark.arrowOrientation)
        
        
        switch index {
        case 0:
            
            coachViews.bodyView.hintLabel.text = "Enter the Subject name"
            coachViews.bodyView.nextLabel.text = "Next"
        case 1:
            coachViews.bodyView.hintLabel.text = "Select the class Days , tap to select"
            coachViews.bodyView.nextLabel.text = "Next"
        case 2:
             UserDefaults.standard.set(false, forKey: firstimeLauncheKey2)
            coachViews.bodyView.hintLabel.text = "Number of lectures for a subject on that day ,Click to type in new value "
            coachViews.bodyView.nextLabel.text = "Done"
        default:
            break
        }
        return (bodyView: coachViews.bodyView, arrowView: coachViews.arrowView)
    }
    
    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkAt index: Int) -> CoachMark {
        switch index {
        case 0:
            
            return coachMarksController.helper.makeCoachMark(for:subjectName )
        case 1:
            
            return coachMarksController.helper.makeCoachMark(for:stackview )
        case 2:
            
            return coachMarksController.helper.makeCoachMark(for: stackview2 )
        default:
            return coachMarksController.helper.makeCoachMark(for:stackview )
        }
    }
    
    func numberOfCoachMarks(for coachMarksController: CoachMarksController) -> Int {
         return 3
    }
    @IBOutlet weak var stackview2: UIStackView!
    
    @IBOutlet weak var stackview: UIStackView!
    @IBOutlet weak var subview: UIView!
      let set = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ ")
    @IBOutlet weak var subjectName: UITextField!
    @IBOutlet weak var mon: UIButton!
    @IBOutlet weak var fri: UIButton!

    @IBOutlet weak var sun: UIButton!
    @IBOutlet weak var sat: UIButton!
    @IBOutlet weak var thu: UIButton!
    @IBOutlet weak var wed: UIButton!
    @IBOutlet weak var tue: UIButton!
    @IBOutlet var weekdays: [UIButton]!
    @IBOutlet weak var mondayfrequency: UITextField!
    @IBOutlet weak var tueFrequency: UITextField!
    @IBOutlet weak var wedFrequency: UITextField!
    @IBOutlet weak var thuFrequency: UITextField!
    @IBOutlet weak var friFrequency: UITextField!
    @IBOutlet weak var satFrequency: UITextField!
    @IBOutlet weak var sunFrequency: UITextField!
    let coach = CoachMarksController()
    var array = [#colorLiteral(red: 1, green: 0.4585048266, blue: 0.3536286348, alpha: 1) , #colorLiteral(red: 0.607717266, green: 0.1518765705, blue: 0.8053647077, alpha: 1) ,#colorLiteral(red: 1, green: 0.4585048266, blue: 0.3536286348, alpha: 1) , #colorLiteral(red: 0.3939671592, green: 0.4863877695, blue: 1, alpha: 1) , #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1),#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1),#colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1) , #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1), #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1),#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1),#colorLiteral(red: 0.1209454388, green: 0.8790454259, blue: 1, alpha: 1) ,#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1), #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1),#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1),#colorLiteral(red: 0.1209454388, green: 0.8790454259, blue: 1, alpha: 1) ,#colorLiteral(red: 1, green: 0.4585048266, blue: 0.3536286348, alpha: 1) , #colorLiteral(red: 0.607717266, green: 0.1518765705, blue: 0.8053647077, alpha: 1) ,#colorLiteral(red: 1, green: 0.4585048266, blue: 0.3536286348, alpha: 1) , #colorLiteral(red: 0.3939671592, green: 0.4863877695, blue: 1, alpha: 1) , #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1),#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1),#colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1) ,]
    var tag = 0
 let regex = try! NSRegularExpression(pattern: ".*[^A-Za-z ].*", options: [])
    @IBAction func weekdays(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            sender.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
            
            
        }else
        {
            sender.isSelected = true
            sender.setTitleColor(#colorLiteral(red: 0, green: 0.7748453363, blue: 0.07571335323, alpha: 1), for: .selected)
            
            
        }
    }
    
    @IBAction func done(_ sender: UIButton) {
        self.update()
    }
    
    @IBAction func cancel(_ sender: UIButton) {
         dismiss(animated: true, completion: nil)
        
    }

    func update(){
        let alert = UIAlertController(title: "Update Values", message: "Are you sure you want update thsee values .This will update the existing records.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "yes", style: UIAlertAction.Style.default){
            UIAlertAction in
            
            if self.subjectName.text == nil || self.subjectName.text == "" || (self.subjectName.text?.trimmingCharacters(in: .whitespaces).isEmpty)!
            {
                self.present(ShowError(with: "All fields are required."), animated: true, completion: nil)
            }else if self.regex.firstMatch(in: self.subjectName.text!, options: [], range: NSMakeRange(0, (self.subjectName.text?.count)!)) != nil {
                self.present(ShowError(with: "Must not contain Number or any special charcaters in Name", title: "Wrong Input"), animated: true, completion: nil)
            }else if (self.subjectName.text?.count)! > 30{
                self.present(ShowError(with: "Length of the string should be less than 30 characters", title: "Wrong Input"), animated: true, completion: nil)
            }
                else{
                self.StoreValueForCounter(self.tag)
             
                self.present(PresentVC(withName : HomepageID), animated: true, completion: nil)
            }
            
            }
        )
        alert.addAction(UIAlertAction(title: "cancel", style: UIAlertAction.Style.cancel))
        present(alert, animated: true, completion: nil)
    }
    
    var subjectCounter : Int {
        
        let realm = try! Realm()
        let count = realm.objects(UserRegisterationObject.self).first
        return (count?.subjectCount)!
    }
    
    var databasefiles: Results<SubjectDetailsObject>{
        let realm = try! Realm()
        let details = realm.objects(SubjectDetailsObject.self)
        return (details)
        
    }
    
   
   
    override func viewDidLoad() {
        super.viewDidLoad()
        coach.dataSource = self
        GetValueForCounter(tag)
        subjectName.becomeFirstResponder()
        subjectName.delegate = self
        
        if firstimeLaunch2 == true{
            coach.start(on: self)
        }
        view.setGradientBackgroundForColors(one: VeryDarkGray, two: darkgray)
      
        // Do any additional setup after loading the view.
    }
    
    
    func StoreValueForCounter(_ counter : Int){
        
        let realm = try! Realm()
        let subjectDetail = (realm.objects(SubjectDetailsObject.self).filter("tag==\(counter)").first)!
        let subjectDetails = SubjectDetailsObject()
        subjectDetails.setValue( subjectName.text!, forKey: "Name")
        subjectDetails.setValue(counter, forKey: "tag")
        if mon.isSelected {
            subjectDetails.mon = 1
            subjectDetails.monFrequency = Int(mondayfrequency.text!)!
        }
        if tue.isSelected {
            subjectDetails.tue = 1
             subjectDetails.tueFrequency = Int(tueFrequency.text!)!
        }
        if wed.isSelected{
            subjectDetails.wed = 1
             subjectDetails.wedFrequency = Int(wedFrequency.text!)!
        }
        if thu.isSelected {
            subjectDetails.thu = 1
             subjectDetails.thuFrequency = Int(thuFrequency.text!)!
        }
        if fri.isSelected {
            subjectDetails.fri = 1
             subjectDetails.friFrequency = Int(friFrequency.text!)!
        }
        if sat.isSelected {
            subjectDetails.sat = 1
             subjectDetails.satFrequency = Int(satFrequency.text!)!
        }
        if sun.isSelected {
            subjectDetails.sun = 1
             subjectDetails.sunFrequency = Int(sunFrequency.text!)!
        }
        
        subjectDetails.attendance = subjectDetail.attendance
        subjectDetails.bunksAvailable = subjectDetail.bunksAvailable
        subjectDetails.classedNeeded = subjectDetail.classedNeeded
        subjectDetails.classesAttended = subjectDetail.classesAttended
        subjectDetails.totalClasses = subjectDetail.totalClasses
       
        try! realm.write {
            realm.add(subjectDetails, update: true)
        }
        
        
    }
    
    
    func GetValueForCounter(_ counter : Int){
        let realm = try! Realm()
        
        let subjectDetails = (realm.objects(SubjectDetailsObject.self).filter("tag==\(counter)").first)!
        subjectName.text = subjectDetails.Name
        if subjectDetails.mon == 1{
            mon.isSelected = true
              mon.setTitleColor(#colorLiteral(red: 0, green: 0.7748453363, blue: 0.07571335323, alpha: 1), for: .selected)
            mondayfrequency.textColor = #colorLiteral(red: 0.1176470588, green: 0.768627451, blue: 0.1607843137, alpha: 1)
            mondayfrequency.text = "\(subjectDetails.monFrequency)"
        }
        if subjectDetails.tue == 1{
            tue.isSelected = true
            tue.setTitleColor(#colorLiteral(red: 0, green: 0.7748453363, blue: 0.07571335323, alpha: 1), for: .selected)
            tueFrequency.textColor = #colorLiteral(red: 0.1176470588, green: 0.768627451, blue: 0.1607843137, alpha: 1)
            tueFrequency.text = "\(subjectDetails.tueFrequency)"
        }
        if subjectDetails.wed == 1{
            wed.isSelected = true
            wed.setTitleColor(#colorLiteral(red: 0, green: 0.7748453363, blue: 0.07571335323, alpha: 1), for: .selected)
            wedFrequency.textColor = #colorLiteral(red: 0.1176470588, green: 0.768627451, blue: 0.1607843137, alpha: 1)
            wedFrequency.text = "\(subjectDetails.wedFrequency)"
        }
        if subjectDetails.thu == 1{
            thu.isSelected = true
            thu.setTitleColor(#colorLiteral(red: 0, green: 0.7748453363, blue: 0.07571335323, alpha: 1), for: .selected)
            thuFrequency.textColor = #colorLiteral(red: 0.1176470588, green: 0.768627451, blue: 0.1607843137, alpha: 1)
            thuFrequency.text = "\(subjectDetails.thuFrequency)"
        }
        if subjectDetails.fri == 1{
            fri.isSelected = true
            fri.setTitleColor(#colorLiteral(red: 0, green: 0.7748453363, blue: 0.07571335323, alpha: 1), for: .selected)
            friFrequency.textColor = #colorLiteral(red: 0.1176470588, green: 0.768627451, blue: 0.1607843137, alpha: 1)
            friFrequency.text = "\(subjectDetails.friFrequency)"
        }
        if subjectDetails.sat == 1{
            sat.isSelected = true
            sat.setTitleColor(#colorLiteral(red: 0, green: 0.7748453363, blue: 0.07571335323, alpha: 1), for: .selected)
            satFrequency.textColor = #colorLiteral(red: 0.1176470588, green: 0.768627451, blue: 0.1607843137, alpha: 1)
            satFrequency.text = "\(subjectDetails.satFrequency)"
        }
        if subjectDetails.sun == 1{
            sun.isSelected = true
            sun.setTitleColor(#colorLiteral(red: 0, green: 0.7748453363, blue: 0.07571335323, alpha: 1), for: .selected)
            sunFrequency.textColor = #colorLiteral(red: 0.1176470588, green: 0.768627451, blue: 0.1607843137, alpha: 1)
            sunFrequency.text = "\(subjectDetails.sunFrequency)"
        }
    
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            self.update()
        return true
    }
    
}
