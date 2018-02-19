//
//  FavoriteWorkoutCell.swift
//  AthleticInstinct
//
//  Created by Zachary Blauvelt on 2/19/18.
//  Copyright © 2018 ZackBlauvelt. All rights reserved.
//

import UIKit

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
    
    func configureCategoryDetailCell(categoryDetail: CategoryDetails) {
        self.categoryDetail = categoryDetail
        self.favWorkoutName.text = categoryDetail.workOutName
        self.favWorkoutCoach.text = categoryDetail.coach
        self.favWorkoutDuration.text = categoryDetail.duration
        self.favWorkoutDifficulty.text = categoryDetail.level
        self.favWorkoutImage.image = UIImage(named: categoryDetail.workOutImage)
    }

}

