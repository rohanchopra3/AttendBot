//
//  Brain.swift
//  AttendBot
//
//  Created by Rohan Chopra on 08/01/18.
//  Copyright © 2018 RohanChopra. All rights reserved.
//

import Foundation
import RealmSwift
class Brain {

    var realm = try! Realm()

    var registerDetails : UserRegisterationObject{
        return  (realm.objects(UserRegisterationObject.self).first)!
        
    }
    
    var databasefiles: Results<SubjectDetailsObject>{
        
        return  realm.objects(SubjectDetailsObject.self)
        
    }
    
    
    
    //This Funtion increments the total classes for sujects everyday , it calcaulates from last updated Date to todays date
    func CalculateTotalClassesForAllSubjects(){
        
        let date = Date()
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        var StartDate : Date?
        if let lastUpdatedDate = registerDetails.lastUpdated {
            StartDate = ReturnDateFromString(lastUpdatedDate)
        }else{
            StartDate = ReturnDateFromString(registerDetails.SemStartDate as String)
        }
        while StartDate!.compare(date) != .orderedDescending {
            let weekDay = myCalendar.component(.weekday , from: StartDate! )
            
            for i in 0 ..< registerDetails.subjectCount
            {
                
                switch weekDay
                {
                case 1 :
                    if databasefiles.filter("tag==\(i)").first?.sun == 1 {
                        for _ in 0..<(databasefiles.filter("tag==\(i)").first?.sunFrequency)!{
                            updateValueForTotalClassWithTag(i)
                        }
                    }
                case 2:
                    if databasefiles.filter("tag==\(i)").first?.mon == 1 {
                        for _ in 0..<(databasefiles.filter("tag==\(i)").first?.monFrequency)!{
                        updateValueForTotalClassWithTag(i)
                        }
                    }
                    
                    
                case 3:
                    if databasefiles.filter("tag==\(i)").first?.tue == 1 {
                        for _ in 0..<(databasefiles.filter("tag==\(i)").first?.tueFrequency)!{
                            updateValueForTotalClassWithTag(i)
                        }
                    }
                    
                    
                case 4 :
                    if databasefiles.filter("tag==\(i)").first?.wed == 1 {
                        for _ in 0..<(databasefiles.filter("tag==\(i)").first?.wedFrequency)!{
    
                            updateValueForTotalClassWithTag(i)
                        }
                    
                     }
                case 5 :
                    if databasefiles.filter("tag==\(i)").first?.thu == 1 {
                        for _ in 0..<(databasefiles.filter("tag==\(i)").first?.thuFrequency)!{
                            updateValueForTotalClassWithTag(i)
                        }
                    }
                    
                    
                case 6 :
                    if databasefiles.filter("tag==\(i)").first?.fri == 1 {
                        for _ in 0..<(databasefiles.filter("tag==\(i)").first?.friFrequency)!{
                            updateValueForTotalClassWithTag(i)
                        }
                     }
                    
                case 7:
                    if databasefiles.filter("tag==\(i)").first?.sat == 1 {
                        for _ in 0..<(databasefiles.filter("tag==\(i)").first?.satFrequency)!{
                            updateValueForTotalClassWithTag(i)
                        }
                    }
                    
                    
                    
                default:
                    print("0")
                    
                    
                }
                
            }
            StartDate = myCalendar.date(byAdding: .day, value: 1, to: StartDate!)!
            UserDefaults.standard.setValue(ReturnStringFromDate(date), forKey: UpdatedForTheDateKey)
            let realm = try! Realm()
            try! realm.write {
                registerDetails.lastUpdated = ReturnStringFromDate(date)
            }
        }
        
        CalcValues()
        
        storeMessage(msg: "Updated total classes for all todays classes")
        
    }
    
    
    
    
    
    // SubjectDetaislObject modification fucntions
    
    // FUNCTION TO CALCULATE Total Attendance for subject with tag i
    func CalcValues(){
        
        for i in 0..<registerDetails.subjectCount{
            let totalClasses =  (databasefiles.filter("tag==\(i)").first?.totalClasses)!
            let classattended = (databasefiles.filter("tag==\(i)").first?.classesAttended)!
            
            let realm = try! Realm()
            if totalClasses != 0 {
                
                let attendance  = (classattended * 100) / totalClasses
                
                try! realm.write {
                    databasefiles.filter("tag==\(i)").first?.attendance = attendance
                }
            }
            CalcBunks(i: i, totalClases: totalClasses, classAttended: classattended)
            CalcClassesRequird(i: i, totalClases: totalClasses, classAttended: classattended)
        }
    }
    // Overriding calcvalues fucntion 
    func CalcValues(i: Int){
        
        let totalClasses =  (databasefiles.filter("tag==\(i)").first?.totalClasses)!
        let classattended = (databasefiles.filter("tag==\(i)").first?.classesAttended)!
        
        let realm = try! Realm()
        if totalClasses != 0 {
            
            let attendance  = (classattended * 100) / totalClasses
            
            try! realm.write {
                databasefiles.filter("tag==\(i)").first?.attendance = attendance
            }
        
        CalcBunks(i: i, totalClases: totalClasses, classAttended: classattended)
        CalcClassesRequird(i: i, totalClases: totalClasses, classAttended: classattended)
        }
        
    }
    
    // FUNCTION TO CALCULATE Bunks available for subject with tag i
    func CalcBunks(i : Int , totalClases : Int , classAttended: Int)
    {
        
        var classAttendedTemp = classAttended
        let totalClasses = totalClases
        var totalAttendance =  (databasefiles.filter("tag==\(i)").first?.attendance)!
        var bunks = -1
        let attendanceNeeded = registerDetails.RequiredAttendance
        if totalClases != 0 {
        while totalAttendance >= attendanceNeeded {
            bunks += 1
            classAttendedTemp -= 1
            totalAttendance = (classAttendedTemp*100)/totalClasses
            
        }
        }
        if bunks >= 0{
        try! realm.write {
            databasefiles.filter("tag==\(i)").first?.bunksAvailable = bunks
        }
        }
        
    }
    // FUNCTION TO CALCULATE class needed for subject with tag i
    func CalcClassesRequird(i : Int, totalClases : Int , classAttended: Int) {
        
        var classAttendedTemp = classAttended
        let totalClasses = totalClases
        var totalAttendance =  (databasefiles.filter("tag==\(i)").first?.attendance)!
        var classNeeded = 0
        let attendanceNeeded = registerDetails.RequiredAttendance
        if totalClases != 0 {
        while totalAttendance <= attendanceNeeded {
            classNeeded += 1
            classAttendedTemp += 1
            totalAttendance = (classAttendedTemp*100)/totalClasses
            }
        }
        try! realm.write {
            databasefiles.filter("tag==\(i)").first?.classedNeeded = classNeeded
        }
        
    }
    // END
    
    
    // function to increase total class by 1
    func updateValueForTotalClassWithTag( _ i: Int)
    {
        let realm = try! Realm()
        let totalClasses = (databasefiles.filter("tag==\(i)").first?.totalClasses)!
        let totalClassesForAll = registerDetails.totalClasses
        try! realm.write {
            
            databasefiles.filter("tag==\(i)").first?.totalClasses = totalClasses+1
           
        }
        try! realm.write {
             registerDetails.totalClasses = totalClassesForAll+1
        }
        
    }
    
    
    
    
    func getDayOfWeek(_ today:Date ) -> Int?
    {
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: today )
        return weekDay
    }
    
    
    
    
   
    
        func calcTotalClass(){
            let realm = try! Realm()
            let totalClasses = (registerDetails.totalClasses)
    
            try! realm.write {
                registerDetails.totalClasses = totalClasses+1
            }
    
        }
    
    
    func calcTotalAttendance(){
        let realm = try! Realm()
        let totalClasses = (registerDetails.totalClasses)
        let classAttended = (registerDetails.classesAttended)
         if totalClasses != 0 {
        try! realm.write {
            registerDetails.totalattendance = (classAttended*100)/totalClasses
        }
        }
    }
    
    
    
    // increse or decrease total class attended by 1
    func clacTotalClassesAttended(By: String)// incrementing or decrementing
    {
        let realm = try! Realm()
        let classAttended = (registerDetails.classesAttended)
        try! realm.write {
            if By == "+1"{
                registerDetails.classesAttended  = classAttended + 1
            }else if By == "-1" {
                registerDetails.classesAttended  = classAttended - 1
            }
        }
        
    }
    // increse or decrease total class  by 1
    func calcTotalClassesforSubject(By: String ) // incrementing or decrementing
    {
        let realm = try! Realm()
        let totalClasses = (registerDetails.totalClasses)
        try! realm.write {
            if By == "+1"{
                registerDetails.totalClasses = totalClasses + 1
            }else if By == "-1" {
                registerDetails.totalClasses = totalClasses - 1
            }
        }
    }
    // Calc total Class attended
    func ClassesAttended(){

        var classesAttended = 0
        for i in 0..<registerDetails.subjectCount
        {
            classesAttended += (databasefiles.filter("tag==\(i)").first?.classesAttended)!
        }
        try! realm.write {
            registerDetails.classesAttended = classesAttended
        }
        
    }
    
    // Calculate Classes Needed for register object
    
    func calcClassesNeeded(){
        let realm = try! Realm()
        var classAttended = registerDetails.classesAttended
        let totalClasses = registerDetails.totalClasses
        var totalAttendance =  registerDetails.totalattendance
        
        let attendanceNeeded = registerDetails.RequiredAttendance
        var classNeeded = 0
        if totalClasses != 0 {
        while totalAttendance <= attendanceNeeded {
            classNeeded += 1
            classAttended += 1
            if totalClasses != 0 {
                totalAttendance = (classAttended*100)/totalClasses
            }
        }
        }
        try! realm.write {
            registerDetails.classedNeeded = classNeeded
        }
        
        
    }
    
    // Calculate Bunks available for register object
    func CalcBunksAvailable(){
        let realm = try! Realm()
        var classAttended = registerDetails.classesAttended
        let totalClasses = registerDetails.totalClasses
        var totalAttendance =  registerDetails.totalattendance
        var bunks = 0
        let attendanceNeeded = registerDetails.RequiredAttendance
        if totalClasses != 0 {
        while totalAttendance >= attendanceNeeded {
            bunks += 1
            classAttended -= 1
            if totalClasses != 0 {
                totalAttendance = (classAttended*100)/totalClasses
            }
        }
        }
        try! realm.write {
            registerDetails.bunkedClasses = bunks
        }
        
        
    }
    
    
    
    func calcTotalClasses(){
        let realm = try! Realm()
        var totalClasses = 0
        for i in 0..<registerDetails.subjectCount
        {
            totalClasses += (databasefiles.filter("tag==\(i)").first?.totalClasses)!
        }
        
        try! realm.write {
            registerDetails.totalClasses = totalClasses
        }
    }
    
    //    func clacClassesNeededForSubjectwithTag( i : Int){
    //        let realm = try! Realm()
    //        var classAttended = (databasefiles.filter("tag==\(i)").first?.classesAttended)!
    //        let totalClasses = (databasefiles.filter("tag==\(i)").first?.totalClasses)!
    //        var totalAttendance =  (databasefiles.filter("tag==\(i)").first?.attendance)!
    //        var classNeeded = 0
    //        let attendanceNeeded = registerDetails.RequiredAttendance
    //        while totalAttendance <= attendanceNeeded {
    //            classNeeded += 1
    //            classAttended += 1
    //            totalAttendance = (classAttended*100)/totalClasses
    //
    //        }
    //        try! realm.write {
    //            databasefiles.filter("tag==\(i)").first?.classedNeeded = classNeeded
    //        }
    //
    //
    //    }
    //
    //    func clacBunksForSubjectwithTag( i : Int){
    //        let realm = try! Realm()
    //        var classAttended = (databasefiles.filter("tag==\(i)").first?.classesAttended)!
    //        let totalClasses = (databasefiles.filter("tag==\(i)").first?.totalClasses)!
    //        var totalAttendance =  (databasefiles.filter("tag==\(i)").first?.attendance)!
    //          var bunks = 0
    //         let attendanceNeeded = registerDetails.RequiredAttendance
    //
    //        while totalAttendance >= attendanceNeeded {
    //            bunks += 1
    //            classAttended -= 1
    //            totalAttendance = (classAttended*100)/totalClasses
    //
    //        }
    //        try! realm.write {
    //            databasefiles.filter("tag==\(i)").first?.bunksAvailable = bunks
    //        }
    //
    //
    //    }
    
    func CheckIfSemeterHasEnded()-> Bool{
        
        let semEndDate = (registerDetails.SemEndDate)!
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        let today = dateFormatter.string(from: date)
        print(today)
        print(semEndDate)
        if today.compare(semEndDate) == .orderedSame{
            
            return true
        }else{
            return false
        }
        
    }
    
    func claculateClassDaysforSubejctWithTag(_ i : Int){
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let SemStartDate = registerDetails.SemStartDate as String
        
        var semStartDate = dateFormatter.date(from: SemStartDate)
        
        while semStartDate?.compare(date) != .orderedDescending {
            let weekDay = myCalendar.component(.weekday , from: semStartDate! )
            
            
            switch weekDay
            {
            case 1 :
                if databasefiles.filter("tag==\(i)").first?.sun == 1 {
                    for _ in 0..<(databasefiles.filter("tag==\(i)").first?.sunFrequency)!{
                        updateValueForTotalClassWithTag(i)
                    }
                }
            case 2:
                if databasefiles.filter("tag==\(i)").first?.mon == 1 {
                    for _ in 0..<(databasefiles.filter("tag==\(i)").first?.monFrequency)!{
                        updateValueForTotalClassWithTag(i)
                    }
                }
                
                
            case 3:
                if databasefiles.filter("tag==\(i)").first?.tue == 1 {
                    for _ in 0..<(databasefiles.filter("tag==\(i)").first?.tueFrequency)!{
                        updateValueForTotalClassWithTag(i)
                    }
                }
                
                
            case 4 :
                if databasefiles.filter("tag==\(i)").first?.wed == 1 {
                    for _ in 0..<(databasefiles.filter("tag==\(i)").first?.wedFrequency)!{
                        
                        updateValueForTotalClassWithTag(i)
                    }
                    
                }
            case 5 :
                if databasefiles.filter("tag==\(i)").first?.thu == 1 {
                    for _ in 0..<(databasefiles.filter("tag==\(i)").first?.thuFrequency)!{
                        updateValueForTotalClassWithTag(i)
                    }
                }
                
                
            case 6 :
                if databasefiles.filter("tag==\(i)").first?.fri == 1 {
                    for _ in 0..<(databasefiles.filter("tag==\(i)").first?.friFrequency)!{
                        updateValueForTotalClassWithTag(i)
                    }
                }
                
            case 7:
                if databasefiles.filter("tag==\(i)").first?.sat == 1 {
                    for _ in 0..<(databasefiles.filter("tag==\(i)").first?.satFrequency)!{
                        updateValueForTotalClassWithTag(i)
                    }
                }
                
                
            default:
                print("0")
                
            }
            semStartDate = myCalendar.date(byAdding: .day, value: 1, to: semStartDate!)
            UserDefaults.standard.setValue(dateFormatter.string(from: date), forKey: UpdatedForTheDateKey)
        }
        CalcValues()
        storeMessage(msg: "Updated total classes for all todays classes")
        
        
    }
}
