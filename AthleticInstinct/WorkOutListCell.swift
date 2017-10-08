//
//  WorkOutListCell.swift
//  AthleticInstinct
//
//  Created by Zachary Blauvelt on 10/7/17.
//  Copyright © 2017 ZackBlauvelt. All rights reserved.
//

import UIKit

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
    
    func configureCategoryDetailCell(categoryDetail: CategoryDetails) {
        self.categoryDetail = categoryDetail
        self.workOutNameLabel.text = categoryDetail.workOutName
        self.coachLabel.text = categoryDetail.coach
        self.durationLabel.text = categoryDetail.duration
        self.levellabel.text = categoryDetail.level
        self.workOutImage.image = UIImage(named: categoryDetail.workOutImage)
    }

}
