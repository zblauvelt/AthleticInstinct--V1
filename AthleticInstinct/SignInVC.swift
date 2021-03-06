//
//  SignInVC.swift
//  AthleticInstinct
//
//  Created by Zachary Blauvelt on 9/27/17.
//  Copyright © 2017 ZackBlauvelt. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit
import SwiftKeychainWrapper

class SignInVC: UIViewController {
    
    //MARK: Outlets
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var facebookLogIn: FancyButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        facebookLogIn.isHidden = true
        hideKeyboard()
        
        
        
    }
    
   /* override func viewDidAppear(_ animated: Bool) {
        //print("keychainID: \(KeychainWrapper.standard.string(forKey: KEY_UID))")
        if let user = KeychainWrapper.standard.string(forKey: KEY_UID) {
            userID = user
            print("USERID: \(userID)ID")
            self.performSegue(withIdentifier: "goToMainScreen", sender: nil)
         
        }
    }*/
    
    override func viewDidAppear(_ animated: Bool) {
        if let keychain = KeychainWrapper.standard.string(forKey: KEY_UID) {
            print("Got ID: \(KeychainWrapper.standard.string(forKey: KEY_UID))")
            userID = keychain
            self.performSegue(withIdentifier: "goToMainScreen", sender: self)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.portrait, andRotateTo: UIInterfaceOrientation.portrait)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.all)
        
    }
    
    
    @IBAction func facebookButtonTapped(_ sender: Any) {
        
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("ZACK: Unable to authenticate with Facebook - \(String(describing: error))")
            } else if result?.isCancelled == true {
                print("ZACK: User cancelled Facebook authentication")
            } else {
                print("ZACK: Successfully authentication with Facebook")
                //let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                //self.firebaseAuth(credential)
                
                
            }
        }
    }
    
    
    /*func firebaseAuth(_ credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("ZACK: Unable to authenticate with Firebase - \(String(describing: error))")
            } else {
                print("ZACK: Successfully authenticated with Firebase")
                
                let graphRequest:FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"first_name,email, picture.type(large)"])
                
                graphRequest.start(completionHandler: { (connection, result, error) -> Void in
                    
                    if ((error) != nil)
                    {
                        print("Error: \(String(describing: error))")
                    }
                    else
                    {
                        let data:[String:AnyObject] = result as! [String : AnyObject]
                        print(data["email"]!)
                        userID = FIRAuth.auth()!.currentUser!.uid
                        let athlete = Athlete()
                        athlete.createAthleteDB(email: data["email"] as! String)                    }
                })
                
                self.completeSignIn()
            }
        })
        
    }*/
    
    
    //MARK: Firebase Email Authentication
    @IBAction func singInTapped(_ sender: Any) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            let user = FirebaseAuth()
            
            do {
                try user.createSignInUser(email: email, password: password, topVC: self)
                //self.completeSignIn()
                emailTextField.text = nil
                passwordTextField.text = nil
            } catch FIRAuthError.invalidEmail {
                showAlert(message: FIRAuthError.invalidEmail.rawValue)
            } catch FIRAuthError.invalidPassword {
                showAlert(message: FIRAuthError.invalidPassword.rawValue)
            } catch FIRAuthError.invalidSignIn {
                showAlert(message: FIRAuthError.invalidSignIn.rawValue)
            } catch FIRAuthError.somethingWentWrong {
                showAlert(message: FIRAuthError.somethingWentWrong.rawValue)
            } catch let error {
                print("\(error)")
            }
        }
    }
    
    //Alert message for error handling
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "" , message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel) { action in
            return
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

   /* func completeSignIn(id: String) {
        let keychainResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("ZACK: Data saved to keychain \(keychainResult)")
        
        emailTextField.text = nil
        passwordTextField.text = nil
        performSegue(withIdentifier: "goToMainScreen", sender: nil)
    }*/
    func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return false to ignore.
    {
        textField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func cancel(segue: UIStoryboardSegue) {}
    
}
