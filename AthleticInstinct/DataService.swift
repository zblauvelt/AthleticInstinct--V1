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

class DataService {
    
    static let ds = DataService()
    
    //DB references
    private var _REF_BASE = DB_BASE
    private var _REF_CATEGORY = DB_BASE.child("Category")
    private var _REF_CATEGORY_WORKOUTS = DB_BASE.child("workOuts")
    
    var REF_BASE: FIRDatabaseReference {
        return _REF_BASE
    }
    
    var REF_CATEGORY: FIRDatabaseReference {
        return _REF_CATEGORY
    }
    
    var REF_CATEGORY_WORKOUTS: FIRDatabaseReference {
        return _REF_CATEGORY_WORKOUTS
    }
    
    
    
    
    
    
    
}
