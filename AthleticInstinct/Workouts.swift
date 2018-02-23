//
//  Workouts.swift
//  AthleticInstinct
//
//  Created by Zachary Blauvelt on 10/3/17.
//  Copyright © 2017 ZackBlauvelt. All rights reserved.
//

import Foundation
import UIKit
import Firebase

enum CreateCategoryError: String, Error {
    case invalidCategoryName = "Please provide a valid category name."
    case invalidImage = "Please provide a valid image."
    case duplicateName = "This category name already exists. Please create a unique name."
}

enum FIRCategoryData: String {
    case categoryName = "name"
    case categoryImage = "image"
}


//Model for Category tableView
class WorkOutCategory {
    private var _name: String!
    var image: String?
    static var categoryDBKey: String = ""
    private var _categoryKey: String!


    var name: String {
        return _name
    }
    
    var categoryKey: String {
        return _categoryKey
    }

    
    
    init(name: String) {
        self._name = name
    }
    
    init(CategoryName: String, categoryData: Dictionary<String, String>) {
        self._categoryKey = CategoryName
        
        if let name = categoryData["name"] {
            self._name = name
        }
        
        if let image = categoryData["image"] {
            self.image = image
        }
        
    }
    
    func createCategory(category: WorkOutCategory, image: UIImage) throws {
        guard category.name != "" else {
            throw CreateCategoryError.invalidCategoryName
        }
        
        let img = image
        
        if let imgData = UIImageJPEGRepresentation(img, 0.2) {
            
            let imgUid = NSUUID().uuidString
            let metaData = FIRStorageMetadata()
            metaData.contentType = "image/jpeg"
            
            DataService.ds.REF_CATEGORY_PICTURES.child(imgUid).put(imgData, metadata: metaData) { (metaData, error) in
                if error != nil {
                    print("ZACK: unable to upload to firebase storage")
                } else {
                    print("ZACK: Successfully uploaded image")
                    let downloadURL = metaData?.downloadURL()?.absoluteString
                    if let url = downloadURL {
                        let category: Dictionary<String, String> = [
                            FIRCategoryData.categoryName.rawValue: category.name,
                            FIRCategoryData.categoryImage.rawValue: url
                        ]
                        let categoryKey = DataService.ds.REF_CATEGORY.childByAutoId()
                        categoryKey.setValue(category)
                        
                        
                    }
                }
                
            }
        }
    }
}
    
  

    
    
    
    
    
    
    
    
    
    
    
    
    
    

