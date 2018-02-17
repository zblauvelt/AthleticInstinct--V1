//
//  FirebaseAuth.swift
//  AthleticInstinct
//
//  Created by Zachary Blauvelt on 2/16/18.
//  Copyright © 2018 ZackBlauvelt. All rights reserved.
//

import Foundation
import Firebase

enum FIRAuthError: String, Error {
    case invalidSignIn = "Email and password do not match. Please try again."
    case invalidEmail = "Please provide a valid email."
    case invalidPassword = "Passwords must be atleast 6 characters, contain one uppercase letter, and one of the following !&^%$#@()/?"
    case somethingWentWrong = "Something went wrong! Please try again."
}

class FirebaseAuth {
    //checks to see if user typed a valid email
    func validateEmail(enteredEmail:String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
    }
    
    //checks to make sure user followed password guidelines
    func validatePassword(text : String) -> Bool{
        
        let capitalLetterRegEx  = ".*[A-Z]+.*"
        let texttest = NSPredicate(format: "SELF MATCHES %@", capitalLetterRegEx)
        let capitalresult = texttest.evaluate(with: text)
        
        let numberRegEx  = ".*[0-9]+.*"
        let texttest1 = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        let numberresult = texttest1.evaluate(with: text)
        print("\(numberresult)")
        
        let specialCharacterRegEx  = ".*[!&^%$#@()/?]+.*"
        let texttest2 = NSPredicate(format:"SELF MATCHES %@", specialCharacterRegEx)
        
        let specialresult = texttest2.evaluate(with: text)
        print("\(specialresult)")
        
        return capitalresult && numberresult && specialresult
        
    }
    
    ///Creates user for Firebase Auth()
    //MARK: Create FirebaseAuth() User
    func createSignInUser(email: String, password: String/*topVC: UIViewController*/) throws {
        //let rootVC = topVC
        guard validateEmail(enteredEmail: email) == true else{
            throw FIRAuthError.invalidEmail
        }
        guard validatePassword(text: password) == true else {
            throw FIRAuthError.invalidPassword
        }
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                print("ZACK: Email user authenticated with Firebase")
                //if let user = user {
                //let userData = ["provider": user.providerID]
                //self.completeSignIn(id: user.uid, userData: userData)
                //}
                //self.completeSignIn()
            } else {
                FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                    if error != nil {
                        print("ZACK: Unable to authenticate with Firebase user email")
                    } else {
                        print("ZACK: Successfully authenticated with Firebase")
                        
                        //if let user = user {
                        //let userData = ["provider": user.providerID]
                        //self.completeSignIn(id: user.uid, userData: userData)
                        //}
                        //self.completeSignIn()
                    }
                })
            }
        })
        
        
    }




}
