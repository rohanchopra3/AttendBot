//
//  Step2ViewController.swift
//  AttendBot
//
//  Created by Rohan Chopra on 29/04/18.
//  Copyright © 2018 RohanChopra. All rights reserved.
//

import UIKit
import RealmSwift
import Instructions

class Step2ViewController: UIViewController ,CoachMarksControllerDataSource,UITextFieldDelegate {

    @IBOutlet weak var previoussubject: UIButton!
    let brain = Brain()
    @IBOutlet weak var Done: UIButton!
    @IBOutlet weak var subjectNumber: UILabel!
    @IBOutlet weak var stackView: UIStackView!
     let coachMarksController = CoachMarksController()
    var array = [#colorLiteral(red: 1, green: 0.4585048266, blue: 0.3536286348, alpha: 1) , #colorLiteral(red: 0.607717266, green: 0.1518765705, blue: 0.8053647077, alpha: 1) ,#colorLiteral(red: 1, green: 0.4585048266, blue: 0.3536286348, alpha: 1) , #colorLiteral(red: 0.3939671592, green: 0.4863877695, blue: 1, alpha: 1) , #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1),#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1),#colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1) , #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1), #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1),#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1),#colorLiteral(red: 0.1209454388, green: 0.8790454259, blue: 1, alpha: 1) ,#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1), #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1),#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1),#colorLiteral(red: 0.1209454388, green: 0.8790454259, blue: 1, alpha: 1) ,#colorLiteral(red: 1, green: 0.4585048266, blue: 0.3536286348, alpha: 1) , #colorLiteral(red: 0.607717266, green: 0.1518765705, blue: 0.8053647077, alpha: 1) ,#colorLiteral(red: 1, green: 0.4585048266, blue: 0.3536286348, alpha: 1) , #colorLiteral(red: 0.3939671592, green: 0.4863877695, blue: 1, alpha: 1) , #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1),#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1),#colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1) ,]
    let set = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ ")
    var classFrequency = ["Mon" : 1,"Tue" : 1 ,"Wed" : 1 ,"Thu" : 1 ,"Fri" : 1 ,"Sat" : 1,"Sun" : 1]
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var mon: UIButton!
    @IBOutlet weak var tue: UIButton!
    @IBOutlet weak var wed: UIButton!
    @IBOutlet weak var thu: UIButton!
    @IBOutlet weak var fri: UIButton!
    @IBOutlet weak var sat: UIButton!
    @IBOutlet weak var sun: UIButton!
    @IBOutlet weak var backButtonOutlet: UIButton!
    @IBOutlet weak var nextButtonOutlet: UIButton!
    @IBOutlet weak var dayname: UILabel!
    
    @IBOutlet weak var sliderValue: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet var weekDays: [UIButton]!
    @IBAction func days(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            sender.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
            classFrequency.updateValue(1, forKey: sender.currentTitle!)
            sliderValue.text = "\(1)"
             dayname.text = ""
            slider.setValue(1, animated: true)
            
        }else
        {
            sender.isSelected = true
            sender.setTitleColor(#colorLiteral(red: 0, green: 0.7748453363, blue: 0.07571335323, alpha: 1), for: .selected)
            dayname.text = sender.currentTitle!
            slider.setValue(1, animated: true)
            sliderValue.text = "\(1)"
            slider.tag = sender.tag
        }
    }
    @IBAction func sliderChanged(_ sender: UISlider) {
        let value = Int(round(sender.value))
        sender.setValue(Float(value), animated: true)
        sliderValue.text = "\(value)"
        
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
    
    var ForwardCounter = 0
    var backWardCounter = 0
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var Subview: UIView!
    
    let regex = try! NSRegularExpression(pattern: ".*[^A-Za-z ].*", options: [])
    @IBAction func doneButton(_ sender: UIButton) {
     
       
        if subjectName.text == nil || subjectName.text == "" || (subjectName.text?.trimmingCharacters(in: .whitespaces).isEmpty)!
        {
            present(ShowError(with: "All fields are required."), animated: true, completion: nil)
        }else if !mon.isSelected && !tue.isSelected && !wed.isSelected && !thu.isSelected && !fri.isSelected && !sat.isSelected && !sun.isSelected {
            present(ShowError(with: "Select a class day for the subject by tapping any day ,green is for selected ."), animated: true, completion: nil)
        }else if (subjectName.text?.count)! > 30{
            present(ShowError(with: "Length of the string should be less than 25 characters", title: "Wrong Input"), animated: true, completion: nil)
        } else if regex.firstMatch(in: subjectName.text!, options: [], range: NSMakeRange(0, (subjectName.text?.count)!)) != nil {
          present(ShowError(with: "Must not contain Number or any special charcaters in Name", title: "Wrong Input"), animated: true, completion: nil)
        }
        else
        {
        StoreValueForCounter(ForwardCounter)
            UserDefaults.standard.setValue("on", forKey: autoUpdateKey)
        UserDefaults.standard.set(1, forKey: registeration)
        present(PresentVC(withName : HomepageID), animated: true, completion: nil)
        }
    }
    @IBAction func previousButton(_ sender: UIButton) {
       
        previousButtonFucntion()
        
    }
    
    @IBAction func nextButton(_ sender: UIButton) {
        nextButtonAction()
    }
    func nextButtonAction(){
    
        colorView.backgroundColor =  array[ForwardCounter]
        if subjectName.text == nil || subjectName.text == "" || (subjectName.text?.trimmingCharacters(in: .whitespaces).isEmpty)!
        {
            present(ShowError(with: "All fields are required."), animated: true, completion: nil)
        } else if regex.firstMatch(in: subjectName.text!, options: [], range: NSMakeRange(0, (subjectName.text?.count)!)) != nil {
            present(ShowError(with: "Must not contain Number in Name", title: "Wrong Input"), animated: true, completion: nil)
        }else if !mon.isSelected && !tue.isSelected && !wed.isSelected && !thu.isSelected && !fri.isSelected && !sat.isSelected && !sun.isSelected {
             present(ShowError(with: "Select a class day for the subject by tapping any day ,green is for selected ."), animated: true, completion: nil)
        }else if (subjectName.text?.count)! > 30{
              present(ShowError(with: "Length of the string should be less than 30 characters", title: "Wrong Input"), animated: true, completion: nil)
        }
        else
        {
                 previoussubject.isHidden = false
            StoreValueForCounter(ForwardCounter)
            Subview.slideInFromRight()
            setButtonToNotselected()
            checkIfSubjectObjectisCreatedfor(tag: ForwardCounter+1)
            CheckForwardCounter()
            slider.tag = 8
            slider.setValue(1, animated: true)
            dayname.text = ""
            sliderValue.text = "\(1)"
        }
    }
    func checkIfSubjectObjectisCreatedfor(tag: Int)
    {
        let realm = try! Realm()
        if  realm.objects(SubjectDetailsObject.self).filter("tag==\(tag)").first != nil{
            
            GetValueForCounter(tag)
        }else{
            setButtonToNotselected()
            subjectName.text = ""
        }
    }
    
    func previousButtonFucntion(){
        
        colorView.backgroundColor =  array[backWardCounter]
         StoreValueForCounter(backWardCounter)
        Subview.slideInFromleft()
        setButtonToNotselected()
        GetValueForCounter(backWardCounter - 1)
        Done.isHidden = true
        CheckBackwardCounter()
        slider.tag = 8
        slider.setValue(1, animated: true)
        dayname.text = ""
         sliderValue.text = "\(1)"
       
    }
    
    
    @IBOutlet weak var subjectName: UITextField!
    

    
    var subjectCounter : Int {
        
        let realm = try! Realm()
        let count = realm.objects(UserRegisterationObject.self).first
        return (count?.subjectCount)!
    }
   
    // VIEW DID LOAD FUNCTION
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackgroundForColors(one: VeryDarkGray, two: darkgray)
        coachMarksController.dataSource = self
        subjectName.delegate = self
        subjectName.becomeFirstResponder()
        backButtonOutlet.layer.cornerRadius = 0.5 * backButtonOutlet.frame.width
        backButtonOutlet.clipsToBounds = true
        nextButtonOutlet.layer.cornerRadius = 0.5 * nextButtonOutlet.frame.width
        nextButtonOutlet.clipsToBounds = true
        
        
        if subjectCounter == 1{
            nextButton.isHidden = true
            previoussubject.isHidden = true
            Done.isHidden = false
            
        }
        print(ForwardCounter)
       
            previoussubject.isHidden = true
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        coachMarksController.start(on: self)
    }
    
    func CheckBackwardCounter(){
        backWardCounter -= 1
        ForwardCounter = backWardCounter
        print(ForwardCounter)
        print(backWardCounter)
         nextButton.isHidden = false
        subjectNumber.text = String(describing: ForwardCounter + 1)
        if backWardCounter == 0  {
            previoussubject.isHidden = true
            nextButton.isHidden = false
          
        }
        
    }
    func CheckForwardCounter(){
        ForwardCounter += 1
        backWardCounter = ForwardCounter
        subjectNumber.text = String(describing: ForwardCounter + 1)
        if ForwardCounter == (subjectCounter - 1)  {
            nextButton.isHidden = true
            Done.isHidden = false
        }
        if ForwardCounter > 0 {
                previoussubject.isHidden = false
        }
        
    }
    
    func StoreValueForCounter(_ counter : Int){
        
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
        
        
            
            let realm = try! Realm()
            try! realm.write {
                realm.add(subjectDetails, update: true)
            }
        
        
    }
    func setButtonToNotselected(){
        
        for i in weekDays{
            i.isSelected = false
        }
    }
    
    func GetValueForCounter(_ counter : Int){
        let realm = try! Realm()
        
        let subjectDetails = (realm.objects(SubjectDetailsObject.self).filter("tag==\(counter)").first)!
        subjectName.text = subjectDetails.Name
        if subjectDetails.mon == 1{
            mon.isSelected = true
            classFrequency.updateValue(subjectDetails.monFrequency, forKey: "Mon")
        }
        if subjectDetails.tue == 1{
            tue.isSelected = true
              classFrequency.updateValue(subjectDetails.tueFrequency, forKey: "Tue")
        }
        if subjectDetails.wed == 1{
            wed.isSelected = true
              classFrequency.updateValue(subjectDetails.wedFrequency, forKey: "Wed")
        }
        if subjectDetails.thu == 1{
            thu.isSelected = true
              classFrequency.updateValue(subjectDetails.thuFrequency, forKey: "Thu")
        }
        if subjectDetails.fri == 1{
            fri.isSelected = true
              classFrequency.updateValue(subjectDetails.friFrequency, forKey: "Fri")
        }
        if subjectDetails.sat == 1{
            sat.isSelected = true
              classFrequency.updateValue(subjectDetails.satFrequency, forKey: "Sat")
        }
        if subjectDetails.sun == 1{
            sun.isSelected = true
              classFrequency.updateValue(subjectDetails.sunFrequency, forKey: "Sun")
        }
    }
    
    func numberOfCoachMarks(for coachMarksController: CoachMarksController) -> Int {
        return 3
    }
    func coachMarksController(_ coachMarksController: CoachMarksController,
                              coachMarkAt index: Int) -> CoachMark {
        switch index {
        case 0:
            
            return coachMarksController.helper.makeCoachMark(for:subjectName )
        case 1:
            
            return coachMarksController.helper.makeCoachMark(for:stackView )
        case 2:
            
            return coachMarksController.helper.makeCoachMark(for: slider )
        default:
            return coachMarksController.helper.makeCoachMark(for:stackView )
        }
    }
    
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
            coachViews.bodyView.hintLabel.text = "Select the number of lectures on a day.Example 2 classes on monday."
        coachViews.bodyView.nextLabel.text = "Done"
        default:
            break
        }
        return (bodyView: coachViews.bodyView, arrowView: coachViews.arrowView)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nextButtonAction()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}
