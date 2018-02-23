//
//  FavoriteWorkoutCell.swift
//  AthleticInstinct
//
//  Created by Zachary Blauvelt on 2/19/18.
//  Copyright © 2018 ZackBlauvelt. All rights reserved.
//

import UIKit
import Firebase

class FavoriteWorkoutCell: UITableViewCell {
    
    @IBOutlet weak var favWorkoutImage: UIImageView!
    @IBOutlet weak var favWorkoutDuration: UILabel!
    @IBOutlet weak var favWorkoutCoach: UILabel!
    @IBOutlet weak var favWorkoutName: UILabel!
    @IBOutlet weak var favWorkoutDifficulty: UILabel!
    

    var categoryDetail: CategoryDetails!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCategoryDetailCell(categoryDetail: CategoryDetails, img: UIImage? = nil) {
        self.categoryDetail = categoryDetail
        self.favWorkoutName.text = categoryDetail.workOutName
        self.favWorkoutCoach.text = categoryDetail.coach
        self.favWorkoutDuration.text = categoryDetail.duration
        self.favWorkoutDifficulty.text = categoryDetail.level
        
        //Image Caching
        if img != nil {
            self.favWorkoutImage.image = img
        } else {
            
            if let imageURL = categoryDetail.workOutImage {
                
                let ref = FIRStorage.storage().reference(forURL: imageURL)
                ref.data(withMaxSize: 2 * 1024 * 1024, completion: { (data, error) in
                    if error != nil {
                        print("ZACK: Unable to download image from Firebase Storage")
                    } else {
                        print("ZACK: Image downloaded from Firebase Storage")
                        if let imgData = data {
                            if let img = UIImage(data: imgData) {
                                self.favWorkoutImage.image = img
                                FavoriteTableVC.favoriteWorkOutImageCache.setObject(img, forKey: imageURL as NSString)
                            }
                        }
                    }
                })
            }
        }
        
    }

}

