//
//  subjectViewController.swift
//  AttendBot
//
//  Created by Rohan Chopra on 21/04/18.
//  Copyright © 2018 RohanChopra. All rights reserved.
//

import UIKit
import Charts
import RealmSwift

class subjectViewController: UIViewController {
    @IBAction func done(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBOutlet weak var totalAttendance: UILabel!
    @IBOutlet var ClassDaysLabels: [UILabel]!
    var attendancehome : AttendanceHomeVC?
    
    @IBOutlet weak var subjectName: UILabel!
    
    @IBOutlet weak var increaseClassattended: UIButton!
    @IBOutlet weak var decreaseClassAttended: UIButton!
    @IBOutlet weak var increaseTotalClasses: UIButton!
    @IBOutlet weak var classAttendedLabel: UILabel!
    @IBOutlet weak var totalClassesLabel: UILabel!
    
    @IBOutlet weak var classNeededLabel: UILabel!
    @IBOutlet weak var classattendedView: UIView!
    @IBOutlet weak var totalClassesView: UIView!
    @IBOutlet weak var bunksAvaailableLabel: UILabel!
    
    @IBOutlet weak var decreaseTotalClasses: UIButton!
    
    @IBOutlet weak var pieChartView: PieChartView!
    
    let brain = Brain()
    var tag = 100
    var databasefiles: Results<SubjectDetailsObject>{
        let realm = try! Realm()
        let details = realm.objects(SubjectDetailsObject.self)
        return (details)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
       subjectName.text =  databasefiles.filter("tag==\(tag)").first?.Name
        UpdateLabels()
        setWorkingDays()
        
       
    }
    func UpdateLabels(){
        totalAttendance.text = "\(String(describing: (databasefiles.filter("tag==\(tag)").first?.attendance)!))%"
        classAttendedLabel.text  =  "\(String(describing: (databasefiles.filter("tag==\(tag)").first?.classesAttended)!))"
        if (databasefiles.filter("tag==\(tag)").first?.classedNeeded)! == 1 {
             classNeededLabel.text  =   "You need to attend \(String(describing : (databasefiles.filter("tag==\(tag)").first?.classedNeeded)!)) class"
        }else{
            classNeededLabel.text  =   "You need to attend \(String(describing : (databasefiles.filter("tag==\(tag)").first?.classedNeeded)!)) classes"
        }
        totalClassesLabel.text  =  "\(String(describing: (databasefiles.filter("tag==\(tag)").first?.totalClasses)!))"
        bunksAvaailableLabel.text  =  "You have \(String(describing : (databasefiles.filter("tag==\(tag)").first?.bunksAvailable)!)) free class available"
        
    }
    
    func setWorkingDays(){
        
        if databasefiles.filter("tag==\(tag)").first?.mon == 1{
            ClassDaysLabels[0].textColor = #colorLiteral(red: 0.09791557723, green: 0.741751269, blue: 0.0423458505, alpha: 1)
        }
        if databasefiles.filter("tag==\(tag)").first?.tue == 1{
             ClassDaysLabels[1].textColor = #colorLiteral(red: 0.09791557723, green: 0.741751269, blue: 0.0423458505, alpha: 1)
        }
        if databasefiles.filter("tag==\(tag)").first?.wed == 1{
             ClassDaysLabels[2].textColor = #colorLiteral(red: 0.09791557723, green: 0.741751269, blue: 0.0423458505, alpha: 1)
        }
        if databasefiles.filter("tag==\(tag)").first?.thu == 1{
             ClassDaysLabels[3].textColor = #colorLiteral(red: 0.09791557723, green: 0.741751269, blue: 0.0423458505, alpha: 1)
        }
        if databasefiles.filter("tag==\(tag)").first?.fri == 1{
             ClassDaysLabels[4].textColor = #colorLiteral(red: 0.09791557723, green: 0.741751269, blue: 0.0423458505, alpha: 1)
        }
        if databasefiles.filter("tag==\(tag)").first?.sat == 1{
             ClassDaysLabels[5].textColor = #colorLiteral(red: 0.09791557723, green: 0.741751269, blue: 0.0423458505, alpha: 1)
        }
        if databasefiles.filter("tag==\(tag)").first?.sun == 1{
             ClassDaysLabels[6].textColor = #colorLiteral(red: 0.09791557723, green: 0.741751269, blue: 0.0423458505, alpha: 1)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let Classes = ["Bunked classes", "Classes attended"]
        let Values = [Double((databasefiles.filter("tag==\(tag)").first?.totalClasses)! - (databasefiles.filter("tag==\(tag)").first?.classesAttended)!), Double((databasefiles.filter("tag==\(tag)").first?.classesAttended)!)]
        setChart(dataPoints: Classes, values: Values, pieChartView: pieChartView)
        
       roundButton(button: increaseClassattended)
          roundButton(button: decreaseClassAttended)
        roundButton(button: increaseTotalClasses)
        roundButton(button: decreaseTotalClasses)
        classattendedView.layer.cornerRadius = 0.5 * classattendedView.bounds.size.width
          classattendedView.clipsToBounds = true
        totalClassesView.layer.cornerRadius = 0.5 * totalClassesView.bounds.size.width
          totalClassesView.clipsToBounds = true
        print(tag)
    }
    func roundButton(button: UIButton){
//        button.layer.cornerRadius =  0.5 * button.bounds.size.width
//        button.clipsToBounds = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setChart(dataPoints: [String], values: [Double],pieChartView: PieChartView) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: values[i], y: Double(i))
            dataEntries.append(dataEntry)
        }
        let entries = ( 0..<2).map { (i) -> PieChartDataEntry in
            // IMPORTANT: In a PieChart, no values (Entry) should have the same xIndex (even if from different DataSets), since no values can be drawn above each other
            return PieChartDataEntry(value: values[i],
                                     label: dataPoints[i])}
        
        let pieChartDataSet = PieChartDataSet(entries: entries, label: "")
        
        
        let pieChartData = PieChartData( dataSet: pieChartDataSet)
        pieChartDataSet.selectionShift = 0
        pieChartDataSet.sliceSpace = 2
        pieChartDataSet.drawIconsEnabled = false
        pieChartView.highlightValues(nil)
        pieChartView.holeColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        pieChartView.legend.enabled = true
        pieChartView.legend.textColor = UIColor.white
        pieChartView.legend.font.withSize(13)
        pieChartView.chartDescription?.text = " "
        pieChartView.drawEntryLabelsEnabled = false
        var colors: [UIColor] = []
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .none
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1
        pFormatter.percentSymbol = " %"
    pieChartData.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
        
        pieChartData.setValueFont(.systemFont(ofSize: 11, weight: .light))
        
        
        
        for _ in 0..<dataPoints.count {
            let tag = Int(arc4random_uniform(10))
          
            var array = [ #colorLiteral(red: 0.607717266, green: 0.1518765705, blue: 0.8053647077, alpha: 1) ,#colorLiteral(red: 1, green: 0.4585048266, blue: 0.3536286348, alpha: 1) , #colorLiteral(red: 0.3939671592, green: 0.4863877695, blue: 1, alpha: 1) , #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1),#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1),#colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1) , #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1), #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1),#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1),#colorLiteral(red: 0.1209454388, green: 0.8790454259, blue: 1, alpha: 1)]
         
            colors.append(array[tag])
        }
        
        pieChartDataSet.colors = colors
        pieChartView.data = pieChartData
        pieChartView.animate(xAxisDuration: 1.4, easingOption: .easeOutBack)
        
    }
    
    @IBAction func increaseClassAttended(_ sender: UIButton) {
        
        let classAttended = (databasefiles.filter("tag==\(tag)").first?.classesAttended)!
        let totalClasses =  (databasefiles.filter("tag==\(tag)").first?.totalClasses)!
        
        if 0 <= classAttended && classAttended < totalClasses
        {
            let realm = try! Realm()
            try! realm.write {
                databasefiles.filter("tag==\(tag)").first?.classesAttended = classAttended + 1
            }
            brain.clacTotalClassesAttended(By: "+1")
            brain.CalcValues(i: tag)
            brain.calcTotalAttendance()
            brain.calcClassesNeeded()
            brain.CalcBunksAvailable()
            UpdateLabels()
              updateChartData()
            storeMessage(msg: "Increased class attended by 1 for \(String(describing: subjectName.text!))")
            attendancehome?.updateMessageField()
        }
    }
    
    @IBAction func decreaseClassAttended(_ sender: UIButton) {
        let classAttended = (databasefiles.filter("tag==\(tag)").first?.classesAttended)!
         let totalClasses =  (databasefiles.filter("tag==\(tag)").first?.totalClasses)!
        if classAttended > 0 && classAttended <= totalClasses{
            let realm = try! Realm()
            try! realm.write {
                databasefiles.filter("tag==\(tag)").first?.classesAttended = classAttended - 1
            }
            brain.clacTotalClassesAttended(By: "-1")
            brain.CalcValues(i: tag)
            brain.calcTotalAttendance()
            brain.calcClassesNeeded()
            brain.CalcBunksAvailable()
            UpdateLabels()
            updateChartData()
            storeMessage(msg: "Decreased class attended by 1 for \(String(describing: subjectName.text!))")
            attendancehome?.updateMessageField()
            
        }
    }
    
    @IBAction func increaseTotalClasses(_ sender: UIButton) {
     
        let totalClasses =  (databasefiles.filter("tag==\(tag)").first?.totalClasses)!
      
        
            let realm = try! Realm()
            try! realm.write {
                databasefiles.filter("tag==\(tag)").first?.totalClasses = totalClasses  + 1
            }
            brain.calcTotalClassesforSubject(By:"+1")
            brain.CalcValues(i: tag)
            brain.calcTotalAttendance()
            brain.calcClassesNeeded()
            brain.CalcBunksAvailable()
            UpdateLabels()
            updateChartData()
            storeMessage(msg: "Increased total classes by 1 for \(String(describing: subjectName.text!))")
            attendancehome?.updateMessageField()
            
        
    }
    
    @IBAction func decreaseTotalClasses(_ sender: UIButton) {
      
        let classAttended = (databasefiles.filter("tag==\(tag)").first?.classesAttended)!
        let totalClasses =  (databasefiles.filter("tag==\(tag)").first?.totalClasses)!
        if classAttended < totalClasses {
            let realm = try! Realm()
            try! realm.write {
                databasefiles.filter("tag==\(tag)").first?.totalClasses = totalClasses  - 1
            }
            brain.calcTotalClassesforSubject(By:"+1")
            brain.CalcValues(i: tag)
            brain.calcTotalAttendance()
            brain.calcClassesNeeded()
            brain.CalcBunksAvailable()
            brain.calcTotalClasses()
            UpdateLabels()
            updateChartData()
            storeMessage(msg: "Decreased total classes by 1 for \(String(describing: subjectName.text!))")
            attendancehome?.updateMessageField()
        }
        
    }
    
    func updateChartData() {

        
        let months = ["Bunked classes", "classed attended"]
        let unitsSold = [Double((databasefiles.filter("tag==\(tag)").first?.totalClasses)! - (databasefiles.filter("tag==\(tag)").first?.classesAttended)!), Double((databasefiles.filter("tag==\(tag)").first?.classesAttended)!)]
        setChart(dataPoints: months, values: unitsSold, pieChartView: pieChartView)
    }
}


