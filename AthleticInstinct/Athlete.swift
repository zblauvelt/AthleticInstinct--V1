//
//  Athlete.swift
//  AthleticInstinct
//
//  Created by Zachary Blauvelt on 2/16/18.
//  Copyright © 2018 ZackBlauvelt. All rights reserved.
//

import Foundation
import Firebase

enum FIRAthleteData: String {
    case email = "email"
}

class Athlete {
    var email: String = ""
    var athleteID: String = ""
    var REF_ATHLETE: FIRDatabaseReference = DB_BASE.child("athlete")
    
    init() {}
    
    init(athleteID: String, userData: Dictionary<String, String>) {
        self.athleteID = athleteID
        
        if let email = userData[FIRAthleteData.email.rawValue] {
            self.email = email
        }
    }
    
    
    //Create Athlete in Database
    func createAthleteDB(email: String) {
        let newAthlete = [
            FIRAthleteData.email.rawValue: email
        ]
        
        REF_ATHLETE.childByAutoId().setValue(newAthlete)
        
    }
    
}
