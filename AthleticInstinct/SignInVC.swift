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

class SignInVC: UIViewController {
    
    //MARK: Outlets
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!


    override func viewDidLoad() {
        super.viewDidLoad()

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
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                
                self.firebaseAuth(credential)
                
            }
        }
    }
    
    
    func firebaseAuth(_ credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("ZACK: Unable to authenticate with Firebase - \(String(describing: error))")
            } else {
                print("ZACK: Successfully authenticated with Firebase")
                
                //if let user = user {
                    //let userData = ["provider": credential.provider]
                //}
                self.completeSignIn()
            }
        })
        
    }
    
    
    //MARK: Firebase Email Authentication
    @IBAction func singInTapped(_ sender: Any) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            let user = FirebaseAuth()
            
            do {
                try user.createSignInUser(email: email, password: password)
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
        
        
        
        
        /*if let email = emailTextField.text, let password = passwordTextField.text {
            
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {
                    print("ZACK: Email user authenticated with Firebase")
                    //if let user = user {
                        //let userData = ["provider": user.providerID]
                        //self.completeSignIn(id: user.uid, userData: userData)
                    //}
                    self.completeSignIn()
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
                            self.completeSignIn()
                        }
                    })
                }
            })
            
        }*/
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

    func completeSignIn() {
        //DataService.ds.createFirebaseDBUser(uid: id, userData: userData)
        //let keychainResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        //print("ZACK: Data saved to keychain \(keychainResult)")
        emailTextField.text = nil
        passwordTextField.text = nil
        performSegue(withIdentifier: "goToMainScreen", sender: nil)
    }
    
}
