//
//  CategoryDetails.swift
//  AthleticInstinct
//
//  Created by Zachary Blauvelt on 10/7/17.
//  Copyright © 2017 ZackBlauvelt. All rights reserved.
//

import Foundation

  //Model for List of workouts in a category Selected (WorkOutListVC)
class CategoryDetails {
    private var _workOutName: String!
    private var _WorkOutImage: String!
    private var _level: String!
    private var _duration: String!
    private var _categoryPickedKey: String!
    private var _coach: String!
    private var _videoid: String!
    
    var workOutName: String {
        return _workOutName
    }
    
    var workOutImage: String {
        return _WorkOutImage
    }
    
    var level: String {
        return _level
    }
    
    var duration: String {
        return _duration
    }
    
    var categoryPickedKey: String {
        return _categoryPickedKey
    }
    
    var coach: String {
        return _coach
    }
    
    var videoid: String {
        return _videoid
    }
    
    init(workOutName: String, workOutImage: String, level: String, duration: String, coach: String) {
        self._workOutName = workOutName
        self._WorkOutImage = workOutImage
        self._level = level
        self._duration = duration
        self._coach = coach
        self._videoid = videoid
    }
    
    init (categoryPickedKey: String, categoryPickedData: Dictionary<String, String>) {
        self._categoryPickedKey = categoryPickedKey
        
        if let workOutName = categoryPickedData["name"] {
            self._workOutName = workOutName
        }
        
        if let workOutImage = categoryPickedData["image"] {
            self._WorkOutImage = workOutImage
        }
        
        if let level = categoryPickedData["level"] {
            self._level = level
        }
        
        if let duration = categoryPickedData["duration"] {
            self._duration = duration
        }
        
        if let coach = categoryPickedData["coach"] {
            self._coach = coach
        }
        
        if let video = categoryPickedData["videoid"] {
            self._videoid = video
        }
    }
    
}

