//
//  Step1VC.swift
//  AttendBot
//
//  Created by Rohan Chopra on 11/10/17.
//  Copyright © 2017 RohanChopra. All rights reserved.
//

import UIKit
import DatePickerDialog
import RealmSwift
import Instructions

class Step1VC: UIViewController,CoachMarksControllerDataSource {

    @IBOutlet weak var SemesterStartDate: UITextField!
    @IBOutlet weak var numberOfSubjects: UITextField!
    @IBOutlet weak var requiredAttendance: UITextField!
    @IBOutlet weak var SemesterEndDate: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    let registerDetails = UserRegisterationObject()
      let coachMarksController = CoachMarksController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let realm = try! Realm()
    
        
        try! realm.write {
            realm.deleteAll()
            
        }
        UserDefaults.standard.setValue("", forKey: UpdatedForTheDateKey)
        view.setGradientBackgroundForColors(one: VeryDarkGray, two: darkgray)

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        coachMarksController.dataSource = self
        self.coachMarksController.start(on: self)
         UserDefaults.standard.set(0, forKey: "registerationComplete")
    }

    
    func datePickerTapped(textfield : UITextField) {
        DatePickerDialog().show("DatePicker", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", defaultDate: Date(), datePickerMode: .date) {
            (date) -> Void in
            if let dt = date {
                let formatter = DateFormatter()
                formatter.dateFormat = "dd MMMM yyyy"
                textfield.text = formatter.string(from: dt)
            }
        }
    }
    
    
    @IBAction func NextButton(_ sender: UIButton) {
     let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        let date = Date()
        if SemesterStartDate.text == "" || SemesterEndDate.text == "" || requiredAttendance.text == "" || numberOfSubjects.text == ""{
            present(ShowError(with : "All fields are required", title: "Wrong Input" ), animated: true, completion: nil)
            
        }else if Int(numberOfSubjects.text!) == 0 {
                   present(ShowError(with : "Number of subjects cannot be zero.", title: "Wrong Input"), animated: true, completion: nil)
                
        }else if Int(requiredAttendance.text!)! > 0 && Int(requiredAttendance.text!)! > 100{
            
             present(ShowError(with : "Required attendance connot be greater than 100 or equal to zero ", title: "Wrong Input"), animated: true, completion: nil)
        }
            
        else if SemesterStartDate.text == SemesterEndDate.text{
            
            present(ShowError(with : "Semester start date cannot be same as end date", title: "Wrong Input"), animated: true, completion: nil)
            
        }else if ((formatter.date(from: SemesterStartDate.text!)?.compare(formatter.date(from: SemesterEndDate.text!)!)) == .orderedDescending) {
            
            present(ShowError(with : "Semester start date cannot be greater than end date", title: "Wrong Input"), animated: true, completion: nil)
        }
            else if(Int(numberOfSubjects.text!)! >= 16){
            present(ShowError(with : "Number of subjects cannot be greater than 15", title: "Wrong Input"), animated: true, completion: nil)
        }else if date.compare(formatter.date(from:SemesterEndDate.text!)!) == .orderedDescending{
              present(ShowError(with : "Semedter end date cannot be before todays day", title: "Wrong Input"), animated: true, completion: nil)
        }
        else{
            do {
                let realm = try Realm()
                try realm.write {
                    realm.create(UserRegisterationObject.self, value:["subjectCount":  Int(numberOfSubjects.text!)! , "SemEndDate" : SemesterEndDate.text! , "SemStartDate": SemesterStartDate.text! , "RequiredAttendance" :Int(requiredAttendance.text!)!], update: true)

                }
            }catch {
                 present(ShowError(with : "Something went wrong"), animated: true, completion: nil)
            }
       
            present(PresentVC(withName : "Step2VC"), animated: true, completion: nil)
        }
        
        
    }
    
    @IBAction func semStartdateButton(_ sender: UIButton) {
        datePickerTapped(textfield :SemesterStartDate)
    }
    
    @IBAction func semEndDateButton(_ sender: UIButton) {
        datePickerTapped(textfield :SemesterEndDate)
    }
    
    
    func numberOfCoachMarks(for coachMarksController: CoachMarksController) -> Int {
        return 4
    }
    func coachMarksController(_ coachMarksController: CoachMarksController,
                              coachMarkAt index: Int) -> CoachMark {
        switch index {
        case 0:
            
            return coachMarksController.helper.makeCoachMark(for:numberOfSubjects )
        case 1:
            
            return coachMarksController.helper.makeCoachMark(for:requiredAttendance )
        case 2:
            
            return coachMarksController.helper.makeCoachMark(for:SemesterStartDate )
        case 3:
            
            return coachMarksController.helper.makeCoachMark(for:SemesterEndDate )
            
        default:
            return coachMarksController.helper.makeCoachMark(for:SemesterEndDate )
        }
    }
    
    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkViewsAt index: Int, madeFrom coachMark: CoachMark) -> (bodyView: CoachMarkBodyView, arrowView: CoachMarkArrowView?) {
        let coachViews = coachMarksController.helper.makeDefaultCoachViews(withArrow: true, arrowOrientation: coachMark.arrowOrientation)
      
        
        switch index {
        case 0:
            
            coachViews.bodyView.hintLabel.text = "Total Number of subjects"
            coachViews.bodyView.nextLabel.text = "Next"
        case 1:
            coachViews.bodyView.hintLabel.text = "Total attendance required in semester"
            coachViews.bodyView.nextLabel.text = "Next"
        case 2:
            
            coachViews.bodyView.hintLabel.text = "Start date for semester "
            coachViews.bodyView.nextLabel.text = "Next"
        case 3:
            
            coachViews.bodyView.hintLabel.text = "End date for semester"
            coachViews.bodyView.nextLabel.text = "Done"
            
        default:
            break
        }
        return (bodyView: coachViews.bodyView, arrowView: coachViews.arrowView)
    }
    
    
}
