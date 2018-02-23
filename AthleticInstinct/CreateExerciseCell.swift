//
//  CreateExerciseCell.swift
//  AthleticInstinct
//
//  Created by Zachary Blauvelt on 2/22/18.
//  Copyright © 2018 ZackBlauvelt. All rights reserved.
//

import UIKit

class CreateExerciseCell: UITableViewCell {

    @IBOutlet weak var cellRepsLbl: UILabel!
    @IBOutlet weak var cellExerciseLbl: UILabel!
    
    var exerciseDetail: ExerciseDetail!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureAddExerciseDetailCell(exerciseDetail: ExerciseDetail) {
        self.exerciseDetail = exerciseDetail
        self.cellRepsLbl.text = exerciseDetail.reps
        self.cellExerciseLbl.text = exerciseDetail.exercise
    }

}
