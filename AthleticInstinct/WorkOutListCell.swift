//
//  WorkOutListCell.swift
//  AthleticInstinct
//
//  Created by Zachary Blauvelt on 10/7/17.
//  Copyright © 2017 ZackBlauvelt. All rights reserved.
//

import UIKit
import Firebase

class WorkOutListCell: UITableViewCell {
    
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var coachLabel: UILabel!
    @IBOutlet weak var workOutNameLabel: UILabel!
    @IBOutlet weak var levellabel: UILabel!
    @IBOutlet weak var workOutImage: UIImageView!
    
    var categoryDetail: CategoryDetails!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCategoryDetailCell(categoryDetail: CategoryDetails, img: UIImage? = nil) {
        self.categoryDetail = categoryDetail
        self.workOutNameLabel.text = categoryDetail.workOutName
        self.coachLabel.text = categoryDetail.coach
        self.durationLabel.text = categoryDetail.duration
        self.levellabel.text = categoryDetail.level
        
        //Image Caching
        if img != nil {
            self.workOutImage.image = img
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
                                self.workOutImage.image = img
                                WorkOutListVC.workOutImageCache.setObject(img, forKey: imageURL as NSString)
                            }
                        }
                    }
                })
            }
        }
        
    }

}
