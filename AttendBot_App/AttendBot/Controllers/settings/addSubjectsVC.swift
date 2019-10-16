//
//  addSubjectsVC.swift
//  AttendBot
//
//  Created by Rohan Chopra on 30/04/18.
//  Copyright © 2018 RohanChopra. All rights reserved.
//

import UIKit
import RealmSwift

class addSubjectsVC: UIViewController ,UITextFieldDelegate{

    let brain = Brain()
    @IBOutlet weak var subjectName: UITextField!
    @IBOutlet weak var mon: UIButton!
    @IBOutlet weak var tue: UIButton!
    @IBOutlet weak var wed: UIButton!
    @IBOutlet weak var thu: UIButton!
    @IBOutlet weak var fri: UIButton!
    @IBOutlet weak var sat: UIButton!
    @IBOutlet weak var sun: UIButton!
    @IBOutlet weak var slider: UISlider!
      var classFrequency = ["Mon" : 1,"Tue" : 1 ,"Wed" : 1 ,"Thu" : 1 ,"Fri" : 1 ,"Sat" : 1,"Sun" : 1]
    @IBOutlet weak var dayname: UILabel!
    @IBOutlet weak var slidervalue: UILabel!
    var subjectCounter : Int {
        
        let realm = try! Realm()
        let count = realm.objects(UserRegisterationObject.self).first
        return (count?.subjectCount)!
    }
    
    var i = 0
    var registerObjec: Results<UserRegisterationObject>{
        
        let realm = try! Realm()
        
        return(realm.objects(UserRegisterationObject.self))
    }
    @IBAction func done(_ sender: UIButton) {
         update()
        
    }
    
    func update(){
         let regex = try! NSRegularExpression(pattern: ".*[^A-Za-z ].*", options: [])
        let alert = UIAlertController(title: "Add subject", message: "Are you sure you want to add this subject.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "yes", style: UIAlertAction.Style.default){
            UIAlertAction in
            
            if self.subjectName.text == nil || self.subjectName.text == "" || (self.subjectName.text?.trimmingCharacters(in: .whitespaces).isEmpty)!
            {
                
                self.present(ShowError(with: "All fields are required."), animated: true, completion: nil)
            }else if !self.mon.isSelected && !self.tue.isSelected && !self.wed.isSelected && !self.thu.isSelected && !self.fri.isSelected && !self.sat.isSelected && !self.sun.isSelected {
                self.present(ShowError(with: "Select a class day for the subject by tapping any day ,green is for selected ."), animated: true, completion: nil)
            } else if regex.firstMatch(in: self.subjectName.text!, options: [], range: NSMakeRange(0, (self.subjectName.text?.count)!)) != nil {
                self.present(ShowError(with: "Must not contain Number or any special charcaters in Name", title: "Wrong Input"), animated: true, completion: nil)
            }else if (self.subjectName.text?.count)! > 30{
                self.present(ShowError(with: "Length of the string should be less than 30 characters", title: "Wrong Input"), animated: true, completion: nil)
            }else{
                self.StoreValueForCounter(self.i)
                
                self.brain.claculateClassDaysforSubejctWithTag(self.i)
                self.brain.calcTotalClasses()
                self.brain.calcClassesNeeded()
                self.brain.CalcBunksAvailable()
                self.present(PresentVC(withName : HomepageID), animated: true, completion: nil)
            }
            
            }
        )
        alert.addAction(UIAlertAction(title: "cancel", style: UIAlertAction.Style.cancel))
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func weekdays(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            sender.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
            classFrequency.updateValue(1, forKey: sender.currentTitle!)
            slidervalue.text = "\(1)"
            slider.setValue(1, animated: true)
            
        }else
        {
            sender.isSelected = true
            sender.setTitleColor(#colorLiteral(red: 0, green: 0.7748453363, blue: 0.07571335323, alpha: 1), for: .selected)
            dayname.text = sender.currentTitle!
            slider.setValue(1, animated: true)
            slidervalue.text = "\(1)"
            slider.tag = sender.tag
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        subjectName.becomeFirstResponder()
        subjectName.delegate = self
        i = subjectCounter
        // Do any additional setup after loading the view.
    }
    @IBAction func sliderValuechanged(_ sender: UISlider) {
        let value = Int(round(sender.value))
        sender.setValue(Float(value), animated: true)
        slidervalue.text = "\(value)"
        
        switch sender.tag {
        case 0:
            classFrequency.updateValue(value, forKey: "Mon")
        case 1:
            classFrequency.updateValue(value, forKey: "Tue")
        case 2:
            classFrequency.updateValue(value, forKey: "Wed")
        case 3:
            classFrequency.updateValue(value, forKey: "Thu")
        case 4:
            classFrequency.updateValue(value, forKey: "Fri")
        case 5:
            classFrequency.updateValue(value, forKey: "Sat")
        case 6:
            classFrequency.updateValue(value, forKey: "Sun")
        default:
            NSLog("error in slider tag")
            break
        }
    }
    
    func StoreValueForCounter(_ counter : Int){
        
        let realm = try! Realm()
        
        let subjectDetails = SubjectDetailsObject()
        subjectDetails.setValue( subjectName.text!, forKey: "Name")
        subjectDetails.setValue(counter, forKey: "tag")
        if mon.isSelected {
            subjectDetails.mon = 1
            subjectDetails.monFrequency = classFrequency["Mon"]!
        }
        if tue.isSelected {
            subjectDetails.tue = 1
            subjectDetails.tueFrequency = classFrequency["Tue"]!
        }
        if wed.isSelected{
            subjectDetails.wed = 1
            subjectDetails.wedFrequency = classFrequency["Wed"]!
        }
        if thu.isSelected {
            subjectDetails.thu = 1
            subjectDetails.thuFrequency = classFrequency["Thu"]!
        }
        if fri.isSelected {
            subjectDetails.fri = 1
            subjectDetails.friFrequency = classFrequency["Fri"]!
        }
        if sat.isSelected {
            subjectDetails.sat = 1
            subjectDetails.satFrequency = classFrequency["Sat"]!
        }
        if sun.isSelected {
            subjectDetails.sun = 1
            subjectDetails.sunFrequency = classFrequency["Sun"]!
        }
        
        
        try! realm.write {
            realm.add(subjectDetails)
        }
        let registerobj = UserRegisterationObject()
        registerobj.subjectCount = subjectCounter + 1
        registerobj.bunkedClasses = (registerObjec.first?.bunkedClasses)!
        registerobj.classesAttended = (registerObjec.first?.classesAttended)!
        registerobj.freeclasses = (registerObjec.first?.freeclasses)!
        registerobj.RequiredAttendance = (registerObjec.first?.RequiredAttendance)!
        registerobj.SemEndDate = registerObjec.first?.SemEndDate
        registerobj.SemStartDate = registerObjec.first?.SemStartDate
        registerobj.totalattendance =  (registerObjec.first?.totalattendance)!
        registerobj.totalClasses = (registerObjec.first?.totalClasses)!
        try! realm.write {
            realm.add(registerobj, update: true)
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        update()
        return true
    }
   

}
