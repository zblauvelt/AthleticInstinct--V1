//
//  Workouts.swift
//  AthleticInstinct
//
//  Created by Zachary Blauvelt on 10/3/17.
//  Copyright © 2017 ZackBlauvelt. All rights reserved.
//

import Foundation
//Model for Category tableView
class WorkOutCategory {
    private var _name: String!
    private var _image: String!
    private var _categoryKey: String!
    private var _workOuts: String!


    var name: String {
        return _name
    }
    
    var image: String {
        return _image
    }
    
    var categoryKey: String {
        return _categoryKey
    }
    
    var workOuts: String {
        return _workOuts
    }
    
    
    init(name: String, image: String, workOuts: String) {
        self._name = name
        self._image = image
        self._workOuts = workOuts
    }
    
    init(CategoryName: String, categoryData: Dictionary<String, String>) {
        self._categoryKey = CategoryName
        
        if let name = categoryData["name"] {
            self._name = name
        }
        
        if let image = categoryData["image"] {
            self._image = image
        }
        
        if let workOuts = categoryData["workOuts"] {
            self._workOuts = workOuts
        }
        

        
    }
    
}
    
  

    
    
    
    
    
    
    
    
    
    
    
    
    
    

