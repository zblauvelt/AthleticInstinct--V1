//
//  CategoryDetails.swift
//  AthleticInstinct
//
//  Created by Zachary Blauvelt on 10/7/17.
//  Copyright © 2017 ZackBlauvelt. All rights reserved.
//

import Foundation
import UIKit
import Firebase


enum CreateWorkOutDetailsError: String, Error {
    case invalidName = "Please provide a valid name."
    case invalidLevel = "Please provide a valid level."
    case invalidDuration = "Please provide a valid duration of work out."
    case invalidCoach = "Please provide a valid coach."
    case invalidImage = "Please provide a valid image."
    case invalidVideoID = "Please provide a valid vimeo id. You can find this by opening your Vimeo video and finding the string of numbers in the url."
    case invalidStructure = "Please provide a valid workout structure."
}

enum FIRWorkOutDetailData: String {
    case name = "name"
    case level = "level"
    case duration = "duration"
    case coach = "coach"
    case videoid = "videoid"
    case image = "image"
    case structure = "structure"
}
  //Model for List of workouts in a category Selected (WorkOutListVC)
class CategoryDetails {
    private var _workOutName: String!
    var workOutImage: String?
    private var _level: String!
    private var _duration: String!
    private var _categoryPickedKey: String!
    private var _coach: String!
    private var _videoid: String!
    private var _workoutStructure: String!
    static var globalWorkout = DataService.ds.REF_ALL_WORKOUTS.childByAutoId()
    
    var workOutName: String {
        return _workOutName
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
    
    var workoutStructure: String {
        return _workoutStructure
    }
    
    init(workOutName: String, level: String, duration: String, coach: String, videoid: String, workoutStructure: String) {
        self._workOutName = workOutName
        
        self._level = level
        self._duration = duration
        self._coach = coach
        self._videoid = videoid
        self._workoutStructure = workoutStructure
    }
    
    init (categoryPickedKey: String, categoryPickedData: Dictionary<String, String>) {
        self._categoryPickedKey = categoryPickedKey
        
        if let workOutName = categoryPickedData["name"] {
            self._workOutName = workOutName
        }
        
        if let workOutImage = categoryPickedData["image"] {
            self.workOutImage = workOutImage
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
        
        if let workoutStructure = categoryPickedData["structure"] {
            self._workoutStructure = workoutStructure
        }
    }
    
    
    func createWorkOutDB(workOut: CategoryDetails, image: UIImage, categoryKey: String) throws {
        guard workOut.workOutName != "" else {
            throw CreateWorkOutDetailsError.invalidName
        }
        guard workOut.level != "" else {
            throw CreateWorkOutDetailsError.invalidLevel
        }
        guard workOut.duration != "" else {
            throw CreateWorkOutDetailsError.invalidDuration
        }
        guard workOut.coach != "" else {
            throw CreateWorkOutDetailsError.invalidCoach
        }
        guard workOut.videoid != "" else {
            throw CreateWorkOutDetailsError.invalidVideoID
        }
        
        guard workOut.workoutStructure != "" else {
            throw CreateWorkOutDetailsError.invalidStructure
        }
        
        let img = image
        
        if let imgData = img.jpegData(compressionQuality: 0.2) {
            
            let imgUid = NSUUID().uuidString
            let metaData = FIRStorageMetadata()
            metaData.contentType = "image/jpeg"
            
            DataService.ds.REF_WORKOUT_PICTURES.child(imgUid).put(imgData, metadata: metaData) { (metaData, error) in
                if error != nil {
                    print("ZACK: Unable to upload to Firebase Storage")
                } else {
                    print("ZACK: Successfully uploaded image")
                    let downloadURL = metaData?.downloadURL()?.absoluteString
                    if let url = downloadURL {
                        let workOutDict: Dictionary<String, String> = [
                            FIRWorkOutDetailData.name.rawValue: workOut.workOutName,
                            FIRWorkOutDetailData.level.rawValue: workOut.level,
                            FIRWorkOutDetailData.duration.rawValue: workOut.duration,
                            FIRWorkOutDetailData.coach.rawValue: workOut.coach,
                            FIRWorkOutDetailData.videoid.rawValue: workOut.videoid,
                            FIRWorkOutDetailData.structure.rawValue: workOut.workoutStructure,
                            FIRWorkOutDetailData.image.rawValue: url
                        ]
                        
                        
                        CategoryDetails.globalWorkout.setValue(workOutDict)
                        DataService.ds.REF_CATEGORY_WORKOUTS.child(categoryKey).child(CategoryDetails.globalWorkout.key).setValue(workOutDict)
                        
                        
                    }
                }
                
            }
            
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

