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

    
    var workOutSelectedKey: String!
    var exerciseDetail = [ExerciseDetail]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
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
                
                //Adjusting table height based on rows
                 func viewDidLayoutSubviews() {
                    super.viewDidLayoutSubviews()
                    let height = min(self.view.bounds.size.height, self.tableView.contentSize.height)
                    self.tableViewHeightConstraint.constant = height
                    self.view.layoutIfNeeded()
                }
                viewDidLayoutSubviews()
            })
   
        }
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
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
    


}
