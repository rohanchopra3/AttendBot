//
//  SelectSubjectViewController.swift
//  AttendBot
//
//  Created by Rohan Chopra on 30/04/18.
//  Copyright © 2018 RohanChopra. All rights reserved.
//

import UIKit
import RealmSwift
class SelectSubjectViewController: UIViewController, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
   var array = [#colorLiteral(red: 1, green: 0.4585048266, blue: 0.3536286348, alpha: 1) , #colorLiteral(red: 0.607717266, green: 0.1518765705, blue: 0.8053647077, alpha: 1) , #colorLiteral(red: 0.3939671592, green: 0.4863877695, blue: 1, alpha: 1) , #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1),#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1),#colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1) , #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1), #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1),#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1),#colorLiteral(red: 0.1209454388, green: 0.8790454259, blue: 1, alpha: 1) ,#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1), #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1),#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1),#colorLiteral(red: 0.1209454388, green: 0.8790454259, blue: 1, alpha: 1) ,#colorLiteral(red: 1, green: 0.4585048266, blue: 0.3536286348, alpha: 1) , #colorLiteral(red: 0.607717266, green: 0.1518765705, blue: 0.8053647077, alpha: 1) ,#colorLiteral(red: 1, green: 0.4585048266, blue: 0.3536286348, alpha: 1) , #colorLiteral(red: 0.3939671592, green: 0.4863877695, blue: 1, alpha: 1) , #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1),#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1),#colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1) ,]
    

    
    var subjectCounter : Int {
        
        let realm = try! Realm()
        let count = realm.objects(UserRegisterationObject.self).first
        return (count?.subjectCount)!
    }
    
    @IBOutlet weak var collectionVew: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    @IBAction func cancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    collectionVew.isScrollEnabled = true
        collectionVew.allowsSelection = true

       
     
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
       
        return subjectCounter
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "my Cell", for: indexPath) as! myCell
        let realm = try! Realm()
          let temp = realm.objects(SubjectDetailsObject.self).filter("tag==\(indexPath.row)").first!
        cell.subjectName.text = temp.Name
        cell.colorView.backgroundColor = array[indexPath.item]
        cell.lineView.backgroundColor = array[indexPath.item]
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name:"Main",bundle : nil)
        let VCtoPresent = storyboard.instantiateViewController(withIdentifier: "editSubject") as! updateSubjectsVC
        VCtoPresent.tag = indexPath.item
        present(VCtoPresent, animated: true, completion: nil)
    }
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        
        return CGSize(width:view.frame.width,height: 55)
    }

}

class myCell: UICollectionViewCell {
    
    /* This is the view class for step 2 collection view cell */
    
    @IBOutlet weak var subjectName: UILabel!
    
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var lineView: UIView!
}

