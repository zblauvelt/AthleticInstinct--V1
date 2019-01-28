//
//  ForgotPasswordVC.swift
//  AthleticInstinct
//
//  Created by Zachary Blauvelt on 6/22/18.
//  Copyright © 2018 ZackBlauvelt. All rights reserved.
//

import UIKit

class ForgotPasswordVC: UIViewController {

    @IBOutlet weak var emailLbl: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitPasswordReset(_ sender: Any) {
        
        if let email = emailLbl.text {
            let user = FirebaseAuth()
            
            do {
                try user.sendPasswordReset(email: email, topVC: self)
            } catch FIRAuthError.invalidEmail {
                showAlert(message: FIRAuthError.invalidEmail.rawValue)
            } catch let error {
                showAlert(message: "\(error)")
            }
        }
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "" , message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel) { action in
            return
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    

}
