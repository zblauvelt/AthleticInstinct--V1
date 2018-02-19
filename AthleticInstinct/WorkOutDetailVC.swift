//
//  WorkOutDetailVC.swift
//  AthleticInstinct
//
//  Created by Zachary Blauvelt on 10/9/17.
//  Copyright © 2017 ZackBlauvelt. All rights reserved.
//

import UIKit
import Firebase

class WorkOutDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var workoutNameLbl: UILabel!
    
    @IBOutlet weak var coachLbl: UILabel!
    @IBOutlet weak var dynamicView: UIView!
    @IBOutlet var topView: UIView!
    @IBOutlet weak var levelLbl: UILabel!
    @IBOutlet weak var durationLbl: UILabel!
    @IBOutlet weak var favoriteButtonImage: UIImageView!
    
    
    var workOutSelectedKey: String!
    var workOutName: String!
    var level: String!
    var duration: String!
    var coach: String!
    var videoid: String!
    var exerciseDetail = [ExerciseDetail]()
    var favoriteWorkouts = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        getFavoriteWorkouts()
        if let workoutSelected = workOutSelectedKey {
            DataService.ds.REF_EXERCISES.child(workoutSelected).observe(.value, with: { (snapshot) in
                if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                    self.exerciseDetail.removeAll()
                    for snap in snapshot {
                        print("SNAP: \(snap)")
                        if let exerciseData = snap.value as? Dictionary<String, String> {
                            let key = snap.key
                            let exercises = ExerciseDetail(workOutKey: key, exerciseData: exerciseData)
                            self.exerciseDetail.append(exercises)
                        }
                    }
                }
                self.tableView.reloadData()
                
                //MARK: labels
                self.workoutNameLbl.text = self.workOutName
                self.levelLbl.text = self.level
                self.durationLbl.text = self.duration
                if let coach = self.coach {
                self.coachLbl.text = "Workout by \(coach)"
                }
                //MARK: Adjusting table height based on rows
                 func viewDidLayoutSubviews() {
                    super.viewDidLayoutSubviews()
                    let tvHeight = CGFloat(self.exerciseDetail.count) * CGFloat(75)
                    self.tableViewHeightConstraint.constant = tvHeight
                   
                    
                    self.view.layoutIfNeeded()
                }
                viewDidLayoutSubviews()
            })
   
        }
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exerciseDetail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let exerciseDetails = exerciseDetail[indexPath.row]
        let cellIdentifier = "exerciseCell"
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? WorkOutDetailCell {
            cell.configureExerciseDetailCell(exerciseDetail: exerciseDetails)
            return cell
        } else {
            return WorkOutDetailCell()
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToVideo" {
            //if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! WorkOutVideoVC
                destinationController.videoid = videoid
            //}
        }
    }
    
    
    @IBAction func favoriteButtonTapped(_ sender: Any) {
        //check to see status of favorite button
        if favoriteButtonImage.image == UIImage(named: "StarUnfilled.png") {
            //Favorite button was unfilled then tapped:
            favoriteButtonImage.image = UIImage(named: "StarFilled.png")
            let favoriteWorkout: Dictionary<String, String> = [
            "favorite" : "yes"
            ]
            DataService.ds.REF_FAVORITE.child(userID).child(workOutSelectedKey).setValue(favoriteWorkout)
            
        } else {
            favoriteButtonImage.image = UIImage(named: "StarUnfilled.png")
            DataService.ds.REF_FAVORITE.child(userID).child(workOutSelectedKey).removeValue()
        }
        
    }
    
    func getFavoriteWorkouts() {
        DataService.ds.REF_FAVORITE.child(userID).observe(.value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                self.favoriteWorkouts.removeAll()
                for snap in snapshot {
                    print("SNAP: \(snap)")
                    if let favoriteData = snap.value as? Dictionary<String, String> {
                        let key = snap.key
                        let favoriteWorkout = Favorite(workOutKey: key, favoriteData: favoriteData)
                        if favoriteWorkout.workOutKey == self.workOutSelectedKey {
                            self.favoriteButtonImage.image = UIImage(named: "StarFilled.png")
                        }
                    }
                }
            }
        })
        
    }
    
    /*unc checkFavoriteStatus() {
        getFavoriteWorkouts()
        if favoriteWorkouts.contains(workOutSelectedKey) {
            print("ZACK: Contains Workout")
            favoriteButtonImage.image = UIImage(named: "StarFilled.png")
        } else {
            favoriteButtonImage.image = UIImage(named: "StarUnfilled.png")
            print("ZACK: Doesn't Contrain Workout")
        }
    }*/

}
