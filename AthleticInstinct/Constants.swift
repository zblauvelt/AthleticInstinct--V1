//
//  Constants.swift
//  AthleticInstinct
//
//  Created by Zachary Blauvelt on 9/27/17.
//  Copyright © 2017 ZackBlauvelt. All rights reserved.
//

import UIKit


let SHADOW_GRAY: CGFloat = 120.0/255

let KEY_UID = "uid"

extension UIViewController
{
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}




