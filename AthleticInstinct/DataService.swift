//
//  DataService.swift
//  AthleticInstinct
//
//  Created by Zachary Blauvelt on 10/3/17.
//  Copyright © 2017 ZackBlauvelt. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = FIRDatabase.database().reference()
let STORAGE_BASE = FIRStorage.storage().reference()

class DataService {
    
    static let ds = DataService()
    
    //DB references
    private var _REF_BASE = DB_BASE
    private var _REF_CATEGORY = DB_BASE.child("Category")
    private var _REF_CATEGORY_WORKOUTS = DB_BASE.child("workOuts")
    private var _REF_EXERCISES = DB_BASE.child("workOutList")
    private var _REF_FAVORITE = DB_BASE.child("favorite")
    private var _REF_ALL_WORKOUTS = DB_BASE.child("allWorkOuts")
    
    var REF_BASE: FIRDatabaseReference {
        return _REF_BASE
    }
    
    var REF_CATEGORY: FIRDatabaseReference {
        return _REF_CATEGORY
    }
    
    var REF_CATEGORY_WORKOUTS: FIRDatabaseReference {
        return _REF_CATEGORY_WORKOUTS
    }
    
    var REF_EXERCISES: FIRDatabaseReference {
        return _REF_EXERCISES
    }
    
    var REF_FAVORITE: FIRDatabaseReference {
        return _REF_FAVORITE
    }
    
    var REF_ALL_WORKOUTS: FIRDatabaseReference {
        return _REF_ALL_WORKOUTS
    }
    
    //Storage References
    private var _REF_CATEGORY_PICTURES = STORAGE_BASE.child("category-pics")
    private var _REF_WORKOUT_PICTURES = STORAGE_BASE.child("workout-pics")
    
    
    var REF_CATEGORY_PICTURES: FIRStorageReference {
        return _REF_CATEGORY_PICTURES
    }
    
    var REF_WORKOUT_PICTURES: FIRStorageReference {
        return _REF_WORKOUT_PICTURES
    }
    
    
    
    
    
    
}
