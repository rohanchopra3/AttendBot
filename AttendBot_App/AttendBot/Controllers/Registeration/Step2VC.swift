//
//  Step2VC.swift
//  AttendBot
//
//  Created by Rohan Chopra on 15/10/17.
//  Copyright © 2017 RohanChopra. All rights reserved.
//

import UIKit
import RealmSwift
import Instructions



class Step2VC: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate ,UICollectionViewDelegateFlowLayout,CoachMarksControllerDataSource{

    var subjectCounter : Int {
        
        let realm = try! Realm()
        let count = realm.objects(UserRegisterationObject.self).first
        return (count?.subjectCount)!
    }
    var days = ["Mon","Tue","Wed","Thu","Fri","Sat","Sun"]
    @IBOutlet weak var nextButton: UIButton!
    
    var array = [ #colorLiteral(red: 0.607717266, green: 0.1518765705, blue: 0.8053647077, alpha: 1) ,#colorLiteral(red: 1, green: 0.4585048266, blue: 0.3536286348, alpha: 1) , #colorLiteral(red: 0.3939671592, green: 0.4863877695, blue: 1, alpha: 1) , #colorLiteral(red: 0.5135922709, green: 1, blue: 0.4735239333, alpha: 1), #colorLiteral(red: 0.1209454388, green: 0.8790454259, blue: 1, alpha: 1)]
    var temp = [Int]()
    let Subview = UIView()
    @IBOutlet weak var collectionView: UICollectionView!
    let coachMarksController = CoachMarksController()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        self.coachMarksController.dataSource = self
        layout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5)
        collectionView.isScrollEnabled = true
        Subview.setGradientBackgroundForColors(one: darkgray, two: VeryDarkGray)
         view.setGradientBackgroundForColors(one: VeryDarkGray, two: darkgray)
        collectionView.backgroundColor = Subview.backgroundColor
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        setupViewResizerOnKeyboardShown()
         self.coachMarksController.start(on: self)

        
        // Do any additional setup after loading the view.
    }
   
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
       // collectionView.endEditing(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
         super.viewDidAppear(animated)
        self.coachMarksController.start(on: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
    
        return subjectCounter
        
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "my Cell", for: indexPath) as! myCell
       
        let value = calcColorValueFor(indexPath.item)
        if indexPath.row == 0 {
            cell.subjectName.becomeFirstResponder()
        }
        StoreLowValuesFor(tag:indexPath.row)
        cell.backgroundColor = UIColor.black.withAlphaComponent(0.1)
       
        return cell
    }
  
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        
        
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
      
    }

  
    func StoreLowValuesFor(tag:Int){
        for i in 0...6{
         UserDefaults.standard.set(0, forKey: "\(days[i])\(tag)")
        }
    }
    
    
    
    @IBAction func Next(_ sender: UIButton) {
        collectionView.endEditing(true)
        StoreValue()
        present(PresentVC(withName : HomepageID), animated: true, completion: nil)
    }
    
    func StoreValue(){
        for m in 0 ..< subjectCounter
            {
                let subjectDetails = SubjectDetailObject()
              
                if let SubjectName = UserDefaults.standard.value(forKey: "\(m)") as? String
                {
                        subjectDetails.setValue( SubjectName, forKey: "Name")
                }else{
                        present(ShowError(with: "All fileds are required"), animated: true, completion: {
                            let realm = try! Realm()
                            realm.delete(subjectDetails)
                        })
                    
                }
   
                subjectDetails.setValue(m, forKey: "tag")
                if let mon = UserDefaults.standard.value(forKey: "Mon\(m)"){
                    subjectDetails.setValue(mon as! Int, forKey: "mon")
                }
                if let tue = UserDefaults.standard.value(forKey: "Tue\(m)"){
                    subjectDetails.setValue(tue as! Int, forKey: "tue")
                }
                if let wed = UserDefaults.standard.value(forKey: "Wed\(m)"){
                    subjectDetails.setValue(wed as! Int, forKey: "wed")
                }
                if let thu = UserDefaults.standard.value(forKey: "Thu\(m)"){
                    subjectDetails.setValue(thu as! Int, forKey: "thu")
                }
                if let fri = UserDefaults.standard.value(forKey: "Fri\(m)"){
                    subjectDetails.setValue(fri as! Int, forKey: "fri")
                }
                if let sat = UserDefaults.standard.value(forKey: "Sat\(m)"){
                    subjectDetails.setValue(sat as! Int, forKey: "sat")
                }
                if let sun = UserDefaults.standard.value(forKey: "Sun\(m)"){
                    subjectDetails.setValue(sun as! Int, forKey: "sun")
                }
                
                let realm = try! Realm()
                try! realm.write {
                    realm.add(subjectDetails)
                }

        }
    
    }
    
    
    
    // To resize collection view when keyboard appears
    func setupViewResizerOnKeyboardShown() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyBoardWillShow),
                                               name: Notification.Name.UIKeyboardWillShow,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillHide),
                                               name: Notification.Name.UIKeyboardWillHide,
                                               object: nil)
    }
    
    @objc func keyBoardWillShow(notification : Notification){
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let window = self.view.window?.frame{
            self.view.frame = CGRect(x: self.view.frame.origin.x , y: self.view.frame.origin.y, width : self.view.frame.width , height :  window.origin.y + window.height - keyboardSize.height)
            
        }
        else {
            debugPrint("We're showing the keyboard and either the keyboard size or window is nil: panic widely.")
        }
        
    }
    @objc func keyboardWillHide(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let viewHeight = self.view.frame.height
            self.view.frame = CGRect(x: self.view.frame.origin.x,
                                     y: self.view.frame.origin.y,
                                     width: self.view.frame.width,
                                     height: viewHeight + keyboardSize.height)
        } else {
            debugPrint("We're about to hide the keyboard and the keyboard size is nil. Now is the rapture.")
        }
    }
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        
        return CGSize(width:view.frame.width,height: 100 )
    }
    // END
    
    //collection view cell subjectnames delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {

        if (textField.text?.trimmingCharacters(in: .whitespaces).isEmpty)!{
            textField.text = nil
        }else {
            UserDefaults.standard.set(textField.text, forKey: "\(textField.tag)")

        }
        
    }
    //
    func numberOfCoachMarks(for coachMarksController: CoachMarksController) -> Int {
        return 2
    }
    func coachMarksController(_ coachMarksController: CoachMarksController,
                              coachMarkAt index: Int) -> CoachMark {
        if index == 0{
            let cell = collectionView.cellForItem(at:IndexPath(row: 0, section : 0) ) as! myCell
            return coachMarksController.helper.makeCoachMark(for: cell.subjectName )

        }
        else{
            let cell = collectionView.cellForItem(at:IndexPath(row: 0, section : 0) ) as! myCell
          return coachMarksController.helper.makeCoachMark(for: nextButton )
        }
    }
    
    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkViewsAt index: Int, madeFrom coachMark: CoachMark) -> (bodyView: CoachMarkBodyView, arrowView: CoachMarkArrowView?) {
        let coachViews = coachMarksController.helper.makeDefaultCoachViews(withArrow: true, arrowOrientation: coachMark.arrowOrientation)
        if index == 0{
            coachViews.bodyView.hintLabel.text = "Write the subject name"
            coachViews.bodyView.nextLabel.text = "Next"
        }else{
            coachViews.bodyView.hintLabel.text = "Select the class days, tap on a day to select "
            coachViews.bodyView.nextLabel.text = "Done!"
        }
        return (bodyView: coachViews.bodyView, arrowView: coachViews.arrowView)
    }
   
   
}

func calcColorValueFor(_ i : Int ) -> Int
{
    
    if i <= 4 {
        return i
    }else
    {
        return  i - 5
    }
}

