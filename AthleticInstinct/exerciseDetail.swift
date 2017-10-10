//
//  exerciseDetail.swift
//  AthleticInstinct
//
//  Created by Zachary Blauvelt on 10/9/17.
//  Copyright © 2017 ZackBlauvelt. All rights reserved.
//

import Foundation

class ExerciseDetail {
    private var _workOutKey: String!
    private var _reps: String!
    private var _exercise: String!
    
    var workOutKey: String {
        return _workOutKey
    }
    
    var reps: String {
        return _reps
    }
    
    var exercise: String {
        return _exercise
    }
    
    init(reps: String, exercise: String) {
        self._reps = reps
        self._exercise = exercise
    }
    
    init(workOutKey: String, exerciseData: Dictionary<String, String>) {
        self._workOutKey = workOutKey
        
        if let reps = exerciseData["reps"] {
            self._reps = reps
        }
        
        if let exercise = exerciseData["exercise"] {
            self._exercise = exercise
        }
    }
}
