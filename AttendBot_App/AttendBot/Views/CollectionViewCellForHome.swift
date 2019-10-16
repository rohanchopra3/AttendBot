//
//  CollectionViewCellForHome.swift
//  AttendBot
//
//  Created by Rohan Chopra on 25/01/18.
//  Copyright © 2018 RohanChopra. All rights reserved.
//

import UIKit
import Charts
import RealmSwift
class CollectionViewCellForHome: UICollectionViewCell {
    var registerDetaisl : UserRegisterationObject{
        let realm = try! Realm()
        let count = realm.objects(UserRegisterationObject.self).first
        return (count)!
        
    }
    
    var databasefiles: Results<SubjectDetailsObject>{
        let realm = try! Realm()
        let details = realm.objects(SubjectDetailsObject.self)
        return (details)
        
    }
    let brain = Brain()
    var collectionview : UICollectionView?
    var attendancehome : AttendanceHomeVC?
    @IBOutlet weak var selectionSymbol: UILabel!
    
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var plusButtonOutlet: UIButton!
    @IBOutlet weak var minusButtonOutlet: UIButton!
    
    @IBOutlet weak var subjectname: UILabel!
    @IBOutlet weak var classAttended: UILabel!
    @IBOutlet weak var bunksAvailable: UILabel!
    @IBOutlet weak var TotalAttendance: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var pieChartView: PieChartView!
    
    @IBAction func plusButton(_ sender: UIButton) {
        let classAttended = (databasefiles.filter("tag==\(sender.tag)").first?.classesAttended)!
        let totalClasses =  (databasefiles.filter("tag==\(sender.tag)").first?.totalClasses)!
        
        if 0 <= classAttended && classAttended < totalClasses
        {
            let realm = try! Realm()
            try! realm.write {
                databasefiles.filter("tag==\(sender.tag)").first?.classesAttended = classAttended + 1
            }
            brain.clacTotalClassesAttended(By: "+1")
            brain.CalcValues(i: sender.tag)
            brain.calcTotalAttendance()
            brain.calcClassesNeeded()
            brain.CalcBunksAvailable()
            collectionview?.reloadData()
            
            storeMessage(msg: "Increased class attended by 1 for \(String(describing: subjectname.text!))")
            attendancehome?.updateMessageField()
        }
    }
    
    @IBAction func minusButton(_ sender: UIButton) {
        
        let classAttended = (databasefiles.filter("tag==\(sender.tag)").first?.classesAttended)!
        if classAttended > 0 {
            let realm = try! Realm()
            try! realm.write {
                databasefiles.filter("tag==\(sender.tag)").first?.classesAttended = classAttended - 1
            }
            brain.clacTotalClassesAttended(By: "-1")
            brain.CalcValues(i: sender.tag)
            brain.calcTotalAttendance()
            brain.calcClassesNeeded()
            brain.CalcBunksAvailable()
            collectionview?.reloadData()
        
            storeMessage(msg: "Decreased class attended by 1 for \(String(describing: subjectname.text!))")
            attendancehome?.updateMessageField()
        
        }
    }
    func roundedCircleButtons(){
        plusButtonOutlet.layer.cornerRadius = 0.5 * plusButtonOutlet.bounds.size.width
        plusButtonOutlet.clipsToBounds = true
        
        minusButtonOutlet.layer.cornerRadius = 0.5 * minusButtonOutlet.bounds.size.width
        minusButtonOutlet.clipsToBounds = true
    }
   
}
