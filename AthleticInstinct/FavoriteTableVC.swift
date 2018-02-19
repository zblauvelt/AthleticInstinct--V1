//
//  FavoriteTableVC.swift
//  AthleticInstinct
//
//  Created by Zachary Blauvelt on 2/19/18.
//  Copyright © 2018 ZackBlauvelt. All rights reserved.
//

import UIKit
import Firebase

class FavoriteTableVC: UITableViewController {
    
    var favoriteWorkouts = [CategoryDetails]()
    var favoriteWorkoutKey = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //getFavoriteWorkouts()
        getFavoriteWorkouts()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return favoriteWorkouts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let favoriteWorkout = favoriteWorkouts[indexPath.row]
        let cellIdentifier = "favoriteCell"
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FavoriteWorkoutCell {
            cell.configureCategoryDetailCell(categoryDetail: favoriteWorkout)
            return cell
        } else {
            return FavoriteWorkoutCell()
        }
    }
    
    
 
    func getFavoriteWorkouts() {
        DataService.ds.REF_FAVORITE.child(userID).observe(.value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                self.favoriteWorkouts.removeAll()
                self.favoriteWorkoutKey.removeAll()
                for snap in snapshot {
                    print("SNAP: \(snap)")
                    if let favoriteData = snap.value as? Dictionary<String, String> {
                        let key = snap.key
                        let favoriteWorkout = Favorite(workOutKey: key, favoriteData: favoriteData)
                        self.favoriteWorkoutKey.append(favoriteWorkout.workOutKey)
                    }
                }
                self.getAllWorkouts()
            }
            self.tableView.reloadData()
        })
    }
    
    func getAllWorkouts() {
        DataService.ds.REF_ALL_WORKOUTS.observe(.value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshot {
                    print("SNAP: \(snap)")
                    if let workoutData = snap.value as? Dictionary<String, String> {
                        let key = snap.key
                        let workout = CategoryDetails(categoryPickedKey: key, categoryPickedData: workoutData)
                        if self.favoriteWorkoutKey.contains(workout.categoryPickedKey) {
                            self.favoriteWorkouts.append(workout)
                        }
                        print(self.favoriteWorkouts.count)
                    }
                }
            }
            self.tableView.reloadData()
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "favToWorkout" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! WorkOutDetailVC
                destinationController.workOutSelectedKey = favoriteWorkouts[indexPath.row].categoryPickedKey
                destinationController.workOutName = favoriteWorkouts[indexPath.row].workOutName
                destinationController.level = favoriteWorkouts[indexPath.row].level
                destinationController.duration = favoriteWorkouts[indexPath.row].duration
                destinationController.coach = favoriteWorkouts[indexPath.row].coach
                destinationController.videoid = favoriteWorkouts[indexPath.row].videoid
            }
        }
    }
    
    
    
   

}
