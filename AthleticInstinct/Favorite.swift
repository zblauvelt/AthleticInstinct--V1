//
//  Favorite.swift
//  AthleticInstinct
//
//  Created by Zachary Blauvelt on 2/19/18.
//  Copyright © 2018 ZackBlauvelt. All rights reserved.
//

import Foundation
import UIKit

class Favorite {
    var favorite: String = ""
    var workOutKey: String = ""
    
    init() {}
    
    init(workOutKey: String, favoriteData: Dictionary<String, String>) {
        self.workOutKey = workOutKey
        
        if let favorite = favoriteData["favorite"] {
            self.favorite = favorite
        }
    }
}


