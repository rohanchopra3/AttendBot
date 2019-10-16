//
//  SelectsubejctVC.swift
//  AttendBot
//
//  Created by Rohan Chopra on 01/02/18.
//  Copyright © 2018 RohanChopra. All rights reserved.
//

import UIKit
import RealmSwift
class SelectsubejctVC: UIViewController, UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    let brain = Brain()
    var home : AttendanceHomeVC?
    var subjectCountForTodaysClasses = 0
    var selectedIndexes = [Int]()
    
    
    var databasefiles: Results<SubjectDetailsObject>{
        let realm = try! Realm()
        return (realm.objects(SubjectDetailsObject.self))
        
    }
    var ImageDictionary :[String.Element:UIImage] =  ["a": #imageLiteral(resourceName: "icons8-circled-a-50-selected") ,"b": #imageLiteral(resourceName: "icons8-circled-b-50-selected"),"c": #imageLiteral(resourceName: "icons8-circled-c-50-selected"),"d": #imageLiteral(resourceName: "icons8-circled-d-50-selected"),"e": #imageLiteral(resourceName: "icons8-circled-e-50-selected"),"f": #imageLiteral(resourceName: "icons8-circled-f-50-selected"),"g": #imageLiteral(resourceName: "icons8-circled-g-50-selected"),"h": #imageLiteral(resourceName: "icons8-circled-h-50-selected"),"i": #imageLiteral(resourceName: "icons8-circled-i-50-selected"),"j": #imageLiteral(resourceName: "icons8-circled-j-50-selected"),"k": #imageLiteral(resourceName: "icons8-circled-k-50-selected"),"l": #imageLiteral(resourceName: "icons8-circled-l-50-selected"),"m": #imageLiteral(resourceName: "icons8-circled-m-50-selected"),"n": #imageLiteral(resourceName: "icons8-circled-n-50-selected"),"o": #imageLiteral(resourceName: "icons8-circled-o-50-selected"),"p": #imageLiteral(resourceName: "icons8-circled-p-50-selected"),"q": #imageLiteral(resourceName: "icons8-circled-q-50-selected"),"r": #imageLiteral(resourceName: "icons8-circled-r-50-selected"),"s": #imageLiteral(resourceName: "icons8-circled-s-50-selected"),"t": #imageLiteral(resourceName: "icons8-circled-t-50-selected"),"u": #imageLiteral(resourceName: "icons8-circled-u-50-selected"),"v": #imageLiteral(resourceName: "icons8-circled-v-50-selected"),"w": #imageLiteral(resourceName: "icons8-circled-w-50-selected"),"x": #imageLiteral(resourceName: "icons8-circled-x-50-selected"),"y": #imageLiteral(resourceName: "icons8-circled-y-50-selected"),"z": #imageLiteral(resourceName: "icons8-circled-z-50-selected")]
    
    
    var subjetDetailsArray = [SubjectDetailsObject]()
    var subjectCounter : Int {
        let realm = try! Realm()
        let count = realm.objects(UserRegisterationObject.self).first
        return (count?.subjectCount)!
    }
    @IBAction func done(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Update Selected", message: "This will mark all the selected classes as attended and all the non selected classes as bunked.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertAction.Style.default){
            UIAlertAction in
            self.bunkedSelected()
            storeMessage(msg: "Selected classes has been marked attended")
            self.home?.CollectionView.reloadData()
            self.dismiss(animated: true, completion: nil)
            }
        )
        alert.addAction(UIAlertAction(title: "cancel", style: UIAlertAction.Style.cancel))
        present(alert, animated: true, completion: nil)
        
        
        
    }
    
    @IBOutlet weak var Collectionview: UICollectionView!

    override func viewWillAppear(_ animated: Bool) {
        Collectionview.delegate = self
        Collectionview.dataSource = self
        Collectionview.allowsSelection = true
        Collectionview.allowsMultipleSelection = true
        
        self.returnTodayClassesValues()
        
        if subjetDetailsArray.count == 0 {
            let alert = UIAlertController(title: "Oops", message: "You dont have any class today", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Done", style: UIAlertAction.Style.default){
                UIAlertAction in
                self.dismiss(animated: true, completion: nil)
                }
            )
            present(alert, animated: true, completion: nil)
        }
        
    }
    @IBAction func cancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return subjetDetailsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCellForSubjectSelection
        
        cell.subjectName.text  = subjetDetailsArray[indexPath.item].Name
        let char = subjetDetailsArray[indexPath.item].Name?.lowercased().first
        cell.characterImageView.image = SelectedImageToBeReturened(for : char!)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = Collectionview.cellForItem(at: indexPath) as! CollectionViewCellForSubjectSelection
        cell.ImageSelectionView.image = #imageLiteral(resourceName: "radiobutton-checked")
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = Collectionview.cellForItem(at: indexPath) as! CollectionViewCellForSubjectSelection
        
        cell.ImageSelectionView.image = #imageLiteral(resourceName: "radiobutton-unchecked")
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 57)
    }
    
    
    func SelectedImageToBeReturened(for char: String.Element)-> UIImage{
        return ImageDictionary[char]!
    }
    
    func returnTodayClassesValues(){
        for i in 0 ..< subjectCounter{
            print(getTodaysDay())
            if databasefiles.filter("tag==\(i)").first?.value(forKey: getTodaysDay()) as! Int == 1 {
                let values =  (databasefiles.filter("tag==\(i)").first)!
                subjetDetailsArray.append(values)
                subjectCountForTodaysClasses += 1
            }
        }
        
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
    
    
    func bunkedSelected(){
        
        let realm = try! Realm()
        
        for i in 0..<subjetDetailsArray.count{
            let tag = subjetDetailsArray[i].tag
            let temp = realm.objects(SubjectDetailsObject.self).filter("tag==\(tag)").first!
            
            if temp.attendance < 100{
                let indexPath = IndexPath(row: i, section: 0)
                let cell = Collectionview.cellForItem(at: indexPath)
                
                if (cell?.isSelected)! {
                    let classAttended =  temp.classesAttended
                    try! realm.write {
                        realm.objects(SubjectDetailsObject.self).filter("tag==\(tag)").first?.classesAttended = classAttended + 1
                    }
                }
            }
            brain.CalcValues(i: tag)
        }
        brain.ClassesAttended()
        brain.calcTotalAttendance()
        brain.calcClassesNeeded()
        brain.CalcBunksAvailable()
        
    }
}
