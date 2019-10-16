//
//  Model.swift
//  AttendBot
//
//  Created by Rohan Chopra on 14/10/17.
//  Copyright © 2017 RohanChopra. All rights reserved.
//

import Foundation
import  RealmSwift

// User Defaults Keys

let messageKey =  "message"
let messageTimestampKey = "messageTimestamp"
var UpdatedForTheDateKey = "UpdatedForTheDate"
var HolidayForDateKey = "HolidayForDate"
var autoUpdateKey = "AutoUpdateTotalClass"
var firstimeLauncheKey = "firstimeLaunch"
var registeration = "RegisterationKey2"
var appLaunchTimesCountKey = "appLaunchTimesCount"
var alreadyReviewedKey = "alreadyReviewed"
var firstimeLauncheKey2 = "registerationKey2"

// User Defaults get value and store them in corresponding variables
var UpdatedForTheDate : String {
    var text =  " "
    if let textFromDb = UserDefaults.standard.value(forKey: UpdatedForTheDateKey ){
        
        text = textFromDb as! String
    }
    
    return text
}


var HolidayForDate : String {
    var text =  " "
    if let textFromDb = UserDefaults.standard.value(forKey: HolidayForDateKey){
        
        text = textFromDb as! String
    }
    
    return text
}



var AutoUpdateTotalClass : String {
    var text =  "on"
    if let textFromDb = UserDefaults.standard.value(forKey:autoUpdateKey ){
        
        text = textFromDb as! String
    }
    
    return text
}


var firstimeLaunch: Bool {
    var text =  true
    if let textFromDb = UserDefaults.standard.value(forKey: firstimeLauncheKey){
        
        text = textFromDb as! Bool
    }
    
    return text
}

var appLaunchTimesCount: Int {
    var text =  0
    if let textFromDb = UserDefaults.standard.value(forKey: appLaunchTimesCountKey
        ){
        
        text = textFromDb as! Int
    }
    
    return text
}
var alreadyReviewed: Bool {
    var text =  false
    if let textFromDb = UserDefaults.standard.value(forKey: alreadyReviewedKey){
        
        text = textFromDb as! Bool
    }
    
    return text
}

var firstimeLaunch2: Bool {
    var text =  true
    if let textFromDb = UserDefaults.standard.value(forKey: firstimeLauncheKey2){
        
        text = textFromDb as! Bool
    }
    
    return text
}
// Function to store message along with message time

func storeMessage(msg: String){
    UserDefaults.standard.setValue(msg, forKey:messageKey)
    let date = getTimeWith(format: "HH:mm a dd/M/YY")
    UserDefaults.standard.setValue(date, forKey: messageTimestampKey)
    let messageObject = OperationListObject()
    let realm = try! Realm()
    
     try! realm.write {
        messageObject.operationName = msg
        messageObject.date = getTimeWith(format: "dd/M/YY")
    }
}


// Function To retrive message of the last made transaction
func getmessageFor(key : String)->String{
    if let msg = UserDefaults.standard.value(forKey: key){
        return msg as! String
    }
    else{
        return " "
    }
}

//Fucntion to get time in format  "HH:mm a dd/M/YY" and return a string
func getTimeWith(format:String)->String{
    let date = Date()
    let dataformatter = DateFormatter()
    
    dataformatter.dateFormat = format
    
    return dataformatter.string(from: date)
}



//User Registeration Object -  Only one row for a every app
class UserRegisterationObject : Object
{
   @objc dynamic  var prim : Int = 0
   @objc dynamic  var subjectCount : Int = 0
   @objc dynamic  var RequiredAttendance : Int = 0
   @objc dynamic  var freeclasses : Int = 0
   @objc dynamic  var totalattendance : Int = 0
   @objc dynamic  var classedNeeded : Int = 0
   @objc dynamic  var totalClasses : Int = 0
   @objc dynamic  var bunkedClasses : Int = 0
   @objc dynamic  var classesAttended : Int = 0
   @objc dynamic  var SemStartDate : String!
   @objc dynamic  var SemEndDate : String!
    @objc dynamic  var lastUpdated : String!
    override static func primaryKey() -> String? {
        return "prim"
    }
    
}

//Subject details object , Contains all the information about the subjects
// Mutiple rows in teh DB depending upon the subejct count

class SubjectDetailsObject : Object {
    
   @objc dynamic var tag : Int = 0
   @objc dynamic var Name : String?
   @objc dynamic var attendance : Int = 0
   @objc dynamic var classesAttended : Int = 0
   @objc dynamic var totalClasses : Int = 0
   @objc dynamic var bunksAvailable : Int = 0
   @objc dynamic var  classedNeeded : Int = 0
    @objc dynamic var mon : Int = 0
    @objc dynamic var tue : Int = 0
    @objc dynamic  var wed : Int = 0
    @objc dynamic var thu : Int = 0
    @objc dynamic  var fri : Int = 0
    @objc dynamic var sat : Int = 0
    @objc dynamic var sun : Int = 0
    @objc dynamic var monFrequency : Int = 0
    @objc dynamic var tueFrequency : Int = 0
    @objc dynamic  var wedFrequency : Int = 0
    @objc dynamic var thuFrequency : Int = 0
    @objc dynamic  var friFrequency : Int = 0
    @objc dynamic var satFrequency : Int = 0
    @objc dynamic var sunFrequency : Int = 0
    @objc var LastupdationDate: String?
    override static func primaryKey() -> String? {
        return "tag"
    }
}

class OperationListObject:Object
{
    @objc dynamic var sno : Int = 0
    @objc dynamic var operationName : String?
    @objc dynamic var date : String?
    override static func primaryKey() -> String? {
        return "tag"
    }
}


