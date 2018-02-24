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
        
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
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
        
        let cancel = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action: #selector(CreateWorkoutDetailsVC.cancelPressed(sender:)))
        
        let done = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(CreateWorkoutDetailsVC.donePressed(sender:)))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        
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
