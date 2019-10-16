//
//  settingsVC.swift
//  AttendBot
//
//  Created by Rohan Chopra on 14/02/18.
//  Copyright © 2018 RohanChopra. All rights reserved.
//

import UIKit

class settingsVC: UIViewController {

    @IBAction func updateSubjects(_ sender: UIButton) {
         self.present(PresentVC(withName: updatesubjectsID), animated: true, completion: nil)
    }
    @IBAction func Done(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var autoupdate: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        let val =  String(describing: UserDefaults.standard.value(forKey: autoUpdateKey)!)
        print(val)
        if val == "on"{
                autoupdate.isOn = true
            }else{
                autoupdate.isOn = false
        }

        // Do any additional setup after loading the view.
    }

    
    @IBAction func resetSemester(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Reset Semeester", message: "Are you sure you want reset semester ? This will delete all existing records.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "yes", style: UIAlertAction.Style.default){
            UIAlertAction in
             UserDefaults.standard.set(0, forKey: registeration)
            self.present(PresentVC(withName: step1ID), animated: true, completion:nil)
            
            }
        )
        alert.addAction(UIAlertAction(title: "cancel", style: UIAlertAction.Style.cancel))
          present(alert, animated: true, completion: nil)
        
        
    }
    
    @IBAction func autoUpdateSwitch(_ sender: UISwitch) {
        if sender.isOn {
            UserDefaults.standard.set("off", forKey: autoUpdateKey)
            sender.setOn(false, animated: true)
        }else{
            UserDefaults.standard.set( "on", forKey: autoUpdateKey)

             sender.setOn(true, animated: true)
        }
    }
    
    @IBAction func addSubject(_ sender: UIButton) {
        self.present(PresentVC(withName: "addsubject"), animated: true, completion: nil)
    }
}
