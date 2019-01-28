//
//  CreateWorkoutDetailsVC.swift
//  AthleticInstinct
//
//  Created by Zachary Blauvelt on 2/20/18.
//  Copyright © 2018 ZackBlauvelt. All rights reserved.
//

import UIKit

class CreateWorkoutDetailsVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var workNameLbl: UITextField!
    @IBOutlet weak var workoutLevelLbl: UITextField!
    @IBOutlet weak var workOutDurationLbl: UITextField!
    @IBOutlet weak var workoutCoachLbl: UITextField!
    @IBOutlet weak var workoutVideoidLbl: UITextField!
    @IBOutlet weak var workImage: UIImageView!
    @IBOutlet weak var structureLbl: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var constraintContentHeight: NSLayoutConstraint!
    @IBOutlet weak var contentView: UIView!
    
    var activeField: UITextField?
    var lastOffset: CGPoint!
    var keyboardHeight: CGFloat!
    var imagePicker: UIImagePickerController!
    var imageSelected = false
    var categoryKey: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.getLevelPickers(workoutLevelLbl)
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        hideKeyboard()
        
        // Observe keyboard change
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // Add touch gesture for contentView
        self.contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(returnTextView(gesture:))))
    }
    
    @objc func returnTextView(gesture: UIGestureRecognizer) {
        guard activeField != nil else {
            return
        }
        
        activeField?.resignFirstResponder()
        activeField = nil
    }

    

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
// Local variable inserted by Swift 4.2 migrator.
let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

        if let image = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.editedImage)] as? UIImage {
            workImage.image = image
            workImage.contentMode = .scaleToFill
            imageSelected = true
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func imagePickerTapped(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func saveWorkoutDetails(_ sender: Any) {
        if imageSelected {
            if let name = workNameLbl.text, let level = workoutLevelLbl.text, let duration = workOutDurationLbl.text, let coach = workoutCoachLbl.text, let videoid = workoutVideoidLbl.text, let workStructure = structureLbl.text, let image = workImage.image {
                let newWorkout = CategoryDetails(workOutName: name, level: level, duration: duration, coach: coach, videoid: videoid, workoutStructure: workStructure)
                
                do {
                    try newWorkout.createWorkOutDB(workOut: newWorkout, image: image, categoryKey: categoryKey)
                    workNameLbl.text = nil
                    workoutLevelLbl.text = nil
                    workOutDurationLbl.text = nil
                    workoutCoachLbl.text = nil
                    workoutVideoidLbl.text = nil
                    workImage.image = #imageLiteral(resourceName: "SignInBackground")
                    structureLbl.text = nil 
                    imageSelected = false
                    performSegue(withIdentifier: "goToExercises", sender: nil)
                } catch CreateWorkOutDetailsError.invalidName {
                    showAlert(message: CreateWorkOutDetailsError.invalidName.rawValue)
                } catch CreateWorkOutDetailsError.invalidDuration {
                    showAlert(message: CreateWorkOutDetailsError.invalidDuration.rawValue)
                } catch CreateWorkOutDetailsError.invalidLevel {
                    showAlert(message: CreateWorkOutDetailsError.invalidLevel.rawValue)
                } catch CreateWorkOutDetailsError.invalidVideoID {
                    showAlert(message: CreateWorkOutDetailsError.invalidVideoID.rawValue)
                } catch CreateWorkOutDetailsError.invalidCoach {
                    showAlert(message: CreateWorkOutDetailsError.invalidCoach.rawValue)
                } catch CreateWorkOutDetailsError.invalidImage {
                    showAlert(message: CreateWorkOutDetailsError.invalidImage.rawValue)
                } catch CreateWorkOutDetailsError.invalidStructure {
                    showAlert(message: CreateWorkOutDetailsError.invalidStructure.rawValue)
                } catch let error {
                    print("\(error)")
                }
            }
        } else {
            showAlert(message: CreateWorkOutDetailsError.invalidImage.rawValue)
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
    
    var levels = ["Beginner", "Intermediate", "Advanced"]
    
    
    //MARK:- PickerView Delegate & DataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return levels.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return levels[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.workoutLevelLbl.text = levels[row]
    }
    //MARK:- TextField Delegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.getLevelPickers(workoutLevelLbl)
    }
    
    //MARK: UIViewPicker for State
    func getLevelPickers(_ textField : UITextField){
        let levelPickerView = UIPickerView()
        levelPickerView.delegate = self
        textField.inputView = levelPickerView
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 40))
        
        toolBar.barStyle = UIBarStyle.blackTranslucent
        toolBar.tintColor = UIColor.white
        
        let cancel = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: self, action: #selector(CreateWorkoutDetailsVC.cancelPressed(sender:)))
        
        let done = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(CreateWorkoutDetailsVC.donePressed(sender:)))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width/3, height: 40))
        
        label.font = UIFont.systemFont(ofSize: 14)
        
        label.textColor = UIColor.white
        
        label.text = "Pick a Level"
        
        label.textAlignment = NSTextAlignment.center
        
        let textButton = UIBarButtonItem(customView: label)
        
        toolBar.setItems([cancel, flexSpace, textButton, flexSpace, done], animated: true)
        
        workoutLevelLbl.inputAccessoryView = toolBar
    }
    //MARK:- Button
    @objc func donePressed(sender: UIBarButtonItem) {
        workoutLevelLbl.resignFirstResponder()
    }
    
    @objc func cancelPressed(sender: UIBarButtonItem) {
        workoutLevelLbl.resignFirstResponder()
        workoutLevelLbl.text = nil
    }
    
    
}


extension CreateWorkoutDetailsVC {
    @objc func keyboardWillShow(notification: NSNotification) {
        if keyboardHeight != nil {
            return
        }
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            keyboardHeight = keyboardSize.height
            
            // so increase contentView's height by keyboard height
            UIView.animate(withDuration: 0.3, animations: {
                self.constraintContentHeight.constant += self.keyboardHeight
            })
            
            // move if keyboard hide input field
            let distanceToBottom = self.scrollView.frame.size.height - (activeField?.frame.origin.y)! - (activeField?.frame.size.height)!
            let collapseSpace = keyboardHeight - distanceToBottom
            
            if collapseSpace < 0 {
                // no collapse
                return
            }
            
            // set new offset for scroll view
            UIView.animate(withDuration: 0.3, animations: {
                // scroll to the position above keyboard 10 points
                self.scrollView.contentOffset = CGPoint(x: self.lastOffset.x, y: collapseSpace + 10)
            })
        }
    }
}

extension CreateWorkoutDetailsVC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        activeField = textField
        lastOffset = self.scrollView.contentOffset
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        activeField?.resignFirstResponder()
        activeField = nil
        return true
    }
}


// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}
