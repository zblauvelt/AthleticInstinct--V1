//
//  CreateExercisesVC.swift
//  AthleticInstinct
//
//  Created by Zachary Blauvelt on 2/22/18.
//  Copyright © 2018 ZackBlauvelt. All rights reserved.
//

import UIKit

class CreateExercisesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var repsLbl: UITextField!
    @IBOutlet weak var exerciseLbl: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        hideKeyboard()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ExerciseDetail.exerciseArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let exercise = ExerciseDetail.exerciseArray[indexPath.row]
        let cellIdentifier = "addExerciseCell"
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CreateExerciseCell {
            cell.configureAddExerciseDetailCell(exerciseDetail: exercise)
            return cell
        } else {
            return CreateExerciseCell()
        }
        
        
    }
    
    
    @IBAction func addExerciseTapped(_ sender: Any) {
        if let reps = repsLbl.text, let exercise = exerciseLbl.text {
            let newExercise = ExerciseDetail(reps: reps, exercise: exercise)
    
            do {
                try newExercise.addExercise(newExercise: newExercise)
                self.tableView.reloadData()
                repsLbl.text = nil
                exerciseLbl.text = nil
            } catch CreateExerciseError.invalidReps {
                showAlert(message: CreateExerciseError.invalidReps.rawValue)
            } catch CreateExerciseError.invalidExercise {
                showAlert(message: CreateExerciseError.invalidExercise.rawValue)
            } catch let error {
                print("\(error)")
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
    

    
    @IBAction func saveExercisesTapped(_ sender: Any) {
        let exercises = ExerciseDetail.exerciseArray
        for exercise in exercises {
            let newWorkout: Dictionary<String, String> = [
                "reps": exercise.reps,
                "exercise": exercise.exercise
            ]
            
            DataService.ds.REF_EXERCISES.child(CategoryDetails.globalWorkout.key).childByAutoId().setValue(newWorkout)
        
        }
        
        ExerciseDetail.exerciseArray.removeAll()
        CategoryDetails.globalWorkout = DataService.ds.REF_ALL_WORKOUTS.childByAutoId()
        self.performSegue(withIdentifier: "closeNewExercise", sender: nil)
        
    }
    
    

}
