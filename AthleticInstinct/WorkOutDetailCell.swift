//
//  WorkOutDetailCell.swift
//  AthleticInstinct
//
//  Created by Zachary Blauvelt on 10/9/17.
//  Copyright © 2017 ZackBlauvelt. All rights reserved.
//

import UIKit

class WorkOutDetailCell: UITableViewCell {
    
    @IBOutlet weak var repsLabel: UILabel!
    @IBOutlet weak var exerciseLabel: UILabel!
    

    var exerciseDetail: ExerciseDetail!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureExerciseDetailCell(exerciseDetail: ExerciseDetail) {
        self.exerciseDetail = exerciseDetail
        self.repsLabel.text = exerciseDetail.reps
        self.exerciseLabel.text = exerciseDetail.exercise
    }

}
