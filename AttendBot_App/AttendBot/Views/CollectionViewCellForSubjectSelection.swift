//
//  CollectionViewCellForSubjectSelection.swift
//  AttendBot
//
//  Created by Rohan Chopra on 02/02/18.
//  Copyright © 2018 RohanChopra. All rights reserved.
//

import UIKit

class CollectionViewCellForSubjectSelection: UICollectionViewCell {
    
    @IBOutlet weak var ImageSelectionView: UIImageView!
    
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var subjectName: UILabel!
    var isSubjectSelected : Bool = false
}
