//
//  CategoryCell.swift
//  AthleticInstinct
//
//  Created by Zachary Blauvelt on 10/2/17.
//  Copyright © 2017 ZackBlauvelt. All rights reserved.
//

import UIKit
import Firebase

class CategoryCell: UITableViewCell {

    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    var category: WorkOutCategory!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(category: WorkOutCategory, img: UIImage? = nil) {
        self.category = category
        self.categoryNameLabel.text = category.name.uppercased()
        //self.CategoryImage.image = UIImage(named: category.image)
        //Image Caching
        if img != nil {
            self.categoryImage.image = img
        } else {
            if let imageURL = category.image {
                
                let ref = FIRStorage.storage().reference(forURL: imageURL)
                ref.data(withMaxSize: 2 * 1024 * 1024, completion: { (data, error) in
                    if error != nil {
                        print("ZACK: Unable to download image from Firebase Storage")
                    } else {
                        print("ZACK: Image downloaded from Firebase Storage")
                        if let imgData = data {
                            if let img = UIImage(data: imgData) {
                                self.categoryImage.image = img
                                CategoryTableVC.categoryImageCache.setObject(img, forKey: imageURL as NSString)
                            }
                        }
                    }
                })
            }
        }
        
        
    }

}
