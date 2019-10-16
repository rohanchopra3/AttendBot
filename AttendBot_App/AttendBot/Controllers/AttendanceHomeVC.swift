//
//  AttendanceHomeVC.swift
//  AttendBot
//
//  Created by Rohan Chopra on 19/11/17.
//  Copyright © 2017 RohanChopra. All rights reserved.
//

import UIKit
import RealmSwift
import Instructions
import StoreKit

class AttendanceHomeVC: UIViewController, UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,CoachMarksControllerDataSource,CoachMarksControllerDelegate {
    

    @IBOutlet weak var hiddenDoneForManualView: UIButton!
    
    @IBOutlet weak var QuickButtonOutlet: UIButton!
 
    @IBOutlet weak var CollectionView: UICollectionView!
    @IBOutlet weak var settingsButtonOutlet: UIButton!
    
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var messageTimestamp: UILabel!
     let coachMarksController = CoachMarksController()
      let coachMarksController2 = CoachMarksController()
    
    @IBAction func hiddenDoneForManualview(_ sender: UIButton) {
          sender.isHidden = true
        
        for i in 0..<subjectCounter{
            let indexPath = IndexPath(row: i, section: 0)
            let cell = CollectionView.cellForItem(at: indexPath) as! CollectionViewCellForHome
            
            cell.minusButton.isHidden = true
            cell.plusButton.isHidden = true
            cell.selectionSymbol.isHidden = false
        }
        QuickButtonOutlet.isHidden = false
        settingsButtonOutlet.isHidden = false
        
    }
    
    @IBAction func settings(_ sender: UIButton) {
        self.present(PresentVC(withName: settingsID), animated: true, completion: nil)
    }
    
    var ImageDictionary :[String.Element:UIImage] = ["a": #imageLiteral(resourceName: "icons8-circled-a-50") ,"b": #imageLiteral(resourceName: "icons8-circled-b-50"),"c": #imageLiteral(resourceName: "icons8-circled-c-50"),"d": #imageLiteral(resourceName: "icons8-circled-d-50"),"e": #imageLiteral(resourceName: "icons8-circled-e-50"),"f": #imageLiteral(resourceName: "icons8-circled-f-50"),"g": #imageLiteral(resourceName: "icons8-circled-g-50"),"h": #imageLiteral(resourceName: "icons8-circled-h-50"),"i": #imageLiteral(resourceName: "icons8-circled-i-50"),"j": #imageLiteral(resourceName: "icons8-circled-j-50"),"k": #imageLiteral(resourceName: "icons8-circled-k-50"),"l": #imageLiteral(resourceName: "icons8-circled-l-50"),"m": #imageLiteral(resourceName: "icons8-circled-m-50"),"n": #imageLiteral(resourceName: "icons8-circled-n-50"),"o": #imageLiteral(resourceName: "icons8-circled-o-50"),"p": #imageLiteral(resourceName: "icons8-circled-p-50"),"q": #imageLiteral(resourceName: "icons8-circled-q-50"),"r": #imageLiteral(resourceName: "icons8-circled-r-50"),"s": #imageLiteral(resourceName: "icons8-circled-s-50"),"t": #imageLiteral(resourceName: "icons8-circled-t-50"),"u": #imageLiteral(resourceName: "icons8-circled-u-50"),"v": #imageLiteral(resourceName: "icons8-circled-v-50"),"w": #imageLiteral(resourceName: "icons8-circled-w-50"),"x": #imageLiteral(resourceName: "icons8-circled-x-50"),"y": #imageLiteral(resourceName: "icons8-circled-y-50"),"z": #imageLiteral(resourceName: "icons8-circled-z-50")]
    
    var ImageDictionaryForSelected:[String.Element:UIImage] = ["a": #imageLiteral(resourceName: "icons8-circled-a-50-selected") ,"b": #imageLiteral(resourceName: "icons8-circled-b-50-selected"),"c": #imageLiteral(resourceName: "icons8-circled-c-50-selected"),"d": #imageLiteral(resourceName: "icons8-circled-d-50-selected"),"e": #imageLiteral(resourceName: "icons8-circled-e-50-selected"),"f": #imageLiteral(resourceName: "icons8-circled-f-50-selected"),"g": #imageLiteral(resourceName: "icons8-circled-g-50-selected"),"h": #imageLiteral(resourceName: "icons8-circled-h-50-selected"),"i": #imageLiteral(resourceName: "icons8-circled-i-50-selected"),"j": #imageLiteral(resourceName: "icons8-circled-j-50-selected"),"k": #imageLiteral(resourceName: "icons8-circled-k-50-selected"),"l": #imageLiteral(resourceName: "icons8-circled-l-50-selected"),"m": #imageLiteral(resourceName: "icons8-circled-m-50-selected"),"n": #imageLiteral(resourceName: "icons8-circled-n-50-selected"),"o": #imageLiteral(resourceName: "icons8-circled-o-50-selected"),"p": #imageLiteral(resourceName: "icons8-circled-p-50-selected"),"q": #imageLiteral(resourceName: "icons8-circled-q-50-selected"),"r": #imageLiteral(resourceName: "icons8-circled-r-50-selected"),"s": #imageLiteral(resourceName: "icons8-circled-s-50-selected"),"t": #imageLiteral(resourceName: "icons8-circled-t-50-selected"),"u": #imageLiteral(resourceName: "icons8-circled-u-50-selected"),"v": #imageLiteral(resourceName: "icons8-circled-v-50-selected"),"w": #imageLiteral(resourceName: "icons8-circled-w-50-selected"),"x": #imageLiteral(resourceName: "icons8-circled-x-50-selected"),"y": #imageLiteral(resourceName: "icons8-circled-y-50-selected"),"z": #imageLiteral(resourceName: "icons8-circled-z-50-selected")]
    
    let Subview = UIView()
    let brain = Brain()
    var subjectCounter : Int {
        
        let realm = try! Realm()
        let count = realm.objects(UserRegisterationObject.self).first
        return (count?.subjectCount)!
    }
    var registerObjec: Results<UserRegisterationObject>{
        
        let realm = try! Realm()
        
        return(realm.objects(UserRegisterationObject.self))
    }
    
    let QuickView : UIView = {
        let temp = UIView()
        temp.backgroundColor = UIColor.white
        temp.heightAnchor.constraint(equalToConstant: 300).isActive = true
        temp.widthAnchor.constraint(equalToConstant: 200).isActive = true
        temp.translatesAutoresizingMaskIntoConstraints = true
        return temp
        
    }()
    
    var databasefiles: Results<SubjectDetailsObject>{
        let realm = try! Realm()
        let details = realm.objects(SubjectDetailsObject.self)
        return (details)
        
    }
    
   
    
    
    
    func updateMessageField(){
        
        message.text = getmessageFor(key : messageKey)
        messageTimestamp.text = getmessageFor(key : messageTimestampKey)
    }
    
    
    @IBAction func quickVIew(_ sender: UIButton) {
    
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        optionMenu.popoverPresentationController?.sourceView = self.view
        let allAttended =  UIAlertAction(title: "All Attended", style: .default){ (alert : UIAlertAction!) in
            
            let alert = UIAlertController(title: "Attend All", message: "This will mark all todays classes as attended.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Done", style: UIAlertAction.Style.default){
                UIAlertAction in
                 self.allAttended()
                
                }
            )
            alert.addAction(UIAlertAction(title: "cancel", style: UIAlertAction.Style.cancel))
            self.present(alert, animated: true, completion: nil)
         
            
        }
        let Bunked =  UIAlertAction(title: "Attend Selected", style: .default){ (alert : UIAlertAction!) in
            let bunkedSelection = SelectsubejctVC()
            bunkedSelection.home = self
   
            self.present( PresentVC(withName: QuickselectionSubjectsID), animated: true, completion: nil)
            self.CollectionView.reloadData()
            
        }
        let Holiday =  UIAlertAction(title: "Holiday", style: .default){ (alert : UIAlertAction!) in
            let alert = UIAlertController(title: "Holiday", message: "This will decrement any auto upadated total class for today.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Done", style: UIAlertAction.Style.default){
                UIAlertAction in
                self.Holiday()
                
                }
            )
            alert.addAction(UIAlertAction(title: "cancel", style: UIAlertAction.Style.cancel))
            self.present(alert, animated: true, completion: nil)
            
           
            
        }
        let Manualedit =  UIAlertAction(title: "Manually edit", style: .default){ (alert : UIAlertAction!) in
            
            self.toggleButtonsInMycell()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (alert : UIAlertAction!) in
        }
        
        optionMenu.addAction(allAttended)
        optionMenu.addAction(Bunked)
        optionMenu.addAction(Holiday)
        optionMenu.addAction(Manualedit)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
        
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
       
        print(brain.CheckIfSemeterHasEnded())
        if brain.CheckIfSemeterHasEnded() == true{
            let alert = UIAlertController(title: "Semeester Ended", message: "Semester has ended .You have to register for a new semester", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default){
                UIAlertAction in
               self.present(PresentVC(withName: step1ID), animated: true, completion:nil)
                }
            )
            self.present(alert, animated: true, completion: nil)
            
        }
        
        if firstimeLaunch == true{
            coachMarksController.start(on: self)
        }
        
        self.CollectionView.reloadData()
        let TodaysDate = returnTodaysDate()
        if !TodaysDate.elementsEqual(UpdatedForTheDate){
            if AutoUpdateTotalClass.elementsEqual("on"){
                brain.CalculateTotalClassesForAllSubjects()
                self.present(ShowError(with: "Total Classes Updated", title: "Total lectures for all todays class has been updated by 1 " ), animated: true, completion: nil)
                
            }
 
                self.brain.calcClassesNeeded()
                self.brain.CalcBunksAvailable()
            
        }
       
        updateMessageField()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendNotification()
        coachMarksController.dataSource = self
        coachMarksController2.dataSource = self
        brain.ClassesAttended()
        Subview.setGradientBackgroundForColors(one: darkgray, two: VeryDarkGray)
        view.setGradientBackgroundForColors(one: VeryDarkGray, two: darkgray)
        CollectionView.backgroundColor = Subview.backgroundColor
        CollectionView.delegate = self
        CollectionView.dataSource = self
        CollectionView.alwaysBounceVertical = true
        CollectionView.isScrollEnabled = true
        CollectionView.allowsSelection  = true
        updateLauncCount()
        reviewStatus()
        let flow: UICollectionViewFlowLayout = CollectionView?.collectionViewLayout as! UICollectionViewFlowLayout  
        flow.sectionHeadersPinToVisibleBounds = true
        flow.sectionFootersPinToVisibleBounds = true
        
        
    }
    func updateLauncCount(){
        var count = appLaunchTimesCount + 1
        UserDefaults.standard.set(count, forKey: appLaunchTimesCountKey)
        
    }
    func reviewStatus(){
        
        if appLaunchTimesCount % 10 == 20{
            if #available(iOS 10.3, *) {
                SKStoreReviewController.requestReview()
            } else {
                // Fallback on earlier versions
            }
        }
        if appLaunchTimesCount == 2 {
            if #available(iOS 10.3, *) {
                SKStoreReviewController.requestReview()
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return subjectCounter
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCellForHome
        
        //  cell.setGradientBackgroundForColors(one: darkgray, two: VeryDarkGray)
        cell.attendancehome = self
        cell.roundedCircleButtons()
        let name =  databasefiles.filter("tag==\(indexPath.item)").first?.Name!
        cell.subjectname.text = name
        let char = name?.lowercased().first
        if databasefiles.filter("tag==\(indexPath.item)").first?.value(forKey: getTodaysDay()) as! Int == 1{
            cell.characterImageView.image = SelectedImageToBeReturened(for : char!)
        }else
        {
            cell.characterImageView.image = ImageToBeReturened(for : char!)
        }
       
        let requiredAttendance = registerObjec.first?.RequiredAttendance
        if let attendance = (databasefiles.filter("tag==\(indexPath.item)").first?.attendance){
            if attendance >= requiredAttendance! {
                cell.TotalAttendance.textColor = #colorLiteral(red: 0.1785123322, green: 0.9196541878, blue: 0.4676677369, alpha: 1)
            }else{
                cell.TotalAttendance.textColor = #colorLiteral(red: 0.8722438135, green: 0.3944672821, blue: 0.3672754214, alpha: 1)
            }
            cell.TotalAttendance.text = "\(String(describing: attendance))%"
        }
        
        cell.plusButton.tag = indexPath.item
        cell.minusButton.tag = indexPath.item
        cell.collectionview = self.CollectionView
        
        return cell
    }
    
    func ImageToBeReturened(for char: String.Element)-> UIImage{
        
        return ImageDictionary[char]!
        
    }
    
    func SelectedImageToBeReturened(for char: String.Element)-> UIImage{
        
        return ImageDictionaryForSelected[char]!
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name:"Main",bundle : nil)
        let VCtoPresent = storyboard.instantiateViewController(withIdentifier: "subjectView") as! subjectViewController
        VCtoPresent.tag = indexPath.row

        present(VCtoPresent, animated: true, completion: nil)
    }
    
    

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
            
        case UICollectionView.elementKindSectionHeader:
        
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerview", for: indexPath) as! HeaderViewForHome
            
            let FirstOBj = registerObjec.first
            headerView.totalattendance.text = "\((FirstOBj?.totalattendance)!)%"
            
            headerView.bunkedClasses.text = "\((FirstOBj?.bunkedClasses)!)"
            headerView.classesNeeded.text = "\((FirstOBj?.classesAttended)!)"
            headerView.classedAttended.text = "\((FirstOBj?.classedNeeded)!)"
            if FirstOBj?.totalClasses != 0 {
                headerView.classesneededPV.progress = (Float((FirstOBj?.classesAttended)!) / Float((FirstOBj?.totalClasses)!))
            
            }else{
                headerView.classesneededPV.progress = 0
            }

            return headerView
            
        default :
            
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerview", for: indexPath)
            return headerView
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:view.frame.width,height: 63 )
    }
    
    func getTodaysDay() -> String {
        let date = Date()
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: date)
        switch weekDay {
            
        case 1:
            return "sun"
            
        case 2:
            return "mon"
            
        case 3 :
            return "tue"
            
        case 4 :
            return "wed"
            
        case 5 :
            
            return "thu"
            
        case 6:
            
            return "fri"
            
        case 7 :
            return "sat"
            
            
        default:
            return "sun"
            
        }
    }
    
    func numberOfCoachMarks(for coachMarksController: CoachMarksController) -> Int {
    
        return 3
    }
    func coachMarksController(_ coachMarksController: CoachMarksController,
                              coachMarkAt index: Int) -> CoachMark {
        switch index {
        case 0:
           
            return coachMarksController.helper.makeCoachMark(for:QuickButtonOutlet )
        case 1:
            
             let cell = CollectionView.cellForItem(at:IndexPath(row: 0, section : 0) ) as! CollectionViewCellForHome
            return coachMarksController.helper.makeCoachMark(for:cell.characterImageView )
        case 2:
            
            
            return coachMarksController.helper.makeCoachMark(for: message )
        default:
            return coachMarksController.helper.makeCoachMark(for:QuickButtonOutlet )
        }
    }
    
    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkViewsAt index: Int, madeFrom coachMark: CoachMark) -> (bodyView: CoachMarkBodyView, arrowView: CoachMarkArrowView?) {
        let coachViews = coachMarksController.helper.makeDefaultCoachViews(withArrow: true, arrowOrientation: coachMark.arrowOrientation)
        
        
        switch index {
        case 0:
            
            coachViews.bodyView.hintLabel.text = "Quick Options for easier use"
            coachViews.bodyView.nextLabel.text = "Next"
        case 1:
            coachViews.bodyView.hintLabel.text = "Green image indaicates class is today"
            coachViews.bodyView.nextLabel.text = "next"
        case 2:
            UserDefaults.standard.set(false, forKey: firstimeLauncheKey)
            coachViews.bodyView.hintLabel.text = "Last updation with date"
            coachViews.bodyView.nextLabel.text = "Done"
    
        default:
            break
        }
        return (bodyView: coachViews.bodyView, arrowView: coachViews.arrowView)
    }
    
    
    func toggleButtonsInMycell(){
        
        for i in 0..<subjectCounter{
            let indexPath = IndexPath(row: i, section: 0)
            let cell = CollectionView.cellForItem(at: indexPath) as! CollectionViewCellForHome
            
            cell.minusButton.isHidden = false
            cell.plusButton.isHidden = false
            cell.selectionSymbol.isHidden = true
        }
        hiddenDoneForManualView.isHidden = false
        QuickButtonOutlet.isHidden = true
        settingsButtonOutlet.isHidden = true
        
    }
    
    func allAttended() {
        let realm = try! Realm()
        let day = weekDay[returnTodaysDay()]
        for i in 0..<subjectCounter{
            let temp = realm.objects(SubjectDetailsObject.self).filter("tag==\(i)").first
            if (temp?.attendance)! < 100 {
                
                if temp?.value(forKey: day!) as! Int == 1{
                    let attendance = temp?.classesAttended
                    try! realm.write {
                        temp?.classesAttended = attendance!+1
                    }
                    
                    
                }
            }
            
        }
        brain.CalcValues()
        brain.ClassesAttended()
        brain.calcTotalAttendance()
        brain.calcClassesNeeded()
        brain.CalcBunksAvailable()
        storeMessage(msg: "Marked class attended for all todays classes")
        updateMessageField()
        CollectionView.reloadData()
        
    }
    
    func Holiday(){
        if AutoUpdateTotalClass.elementsEqual("on"){
            
            let TodayDate = returnTodaysDate()
            let day = weekDay[returnTodaysDay()]
            print(HolidayForDate)
            if TodayDate.elementsEqual(HolidayForDate){
                
                present(ShowError(with: "Holiday for today has already been taken"), animated: true, completion: nil)
                
            }
            else
            {
                
                
                let realm = try! Realm()
                for i in 0..<subjectCounter{
                    let temp = realm.objects(SubjectDetailsObject.self).filter("tag==\(i)").first
                    if (temp?.attendance)! < 100 {
                        
                        let totalClasses = temp?.totalClasses
                        if temp?.value(forKey: day!) as! Int == 1{
                            try! realm.write {
                                temp?.totalClasses = totalClasses!-1
                                
                            }
                            
                            
                        }
                    }
                }
                brain.CalcValues()
                brain.calcTotalClasses()
                brain.ClassesAttended()
                brain.calcTotalAttendance()
                brain.calcClassesNeeded()
                brain.CalcBunksAvailable()
                storeMessage(msg: "Holiday recorded and total classes adjusted accordingly ")
                updateMessageField()
                CollectionView.reloadData()
                
                UserDefaults.standard.setValue(TodayDate, forKey: HolidayForDateKey)
                
            }
        }
        else{
            present(ShowError(with: "AutoUpdate is off ,so total classes has not been incremented"), animated: true, completion: nil)
            
            
        }
        
    }

   
}
    

    
    
    var weekDay = [1:"sun",2:"mon",3:"tue",4:"wed",5:"thu",6:"fri",7:"sat",]
    
    func returnTodaysDate() -> String
    {
        let date = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat =  "dd MMMM yyyy"
        
        return formatter.string(from: date)
    }
    
    func returnTodaysDay() -> Int
    {
        let date = Date()
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: date)
        return weekDay
        
}
