//
//  WorkOutListVC.swift
//  AthleticInstinct
//
//  Created by Zachary Blauvelt on 10/5/17.
//  Copyright © 2017 ZackBlauvelt. All rights reserved.
//

import UIKit
import Firebase

class WorkOutListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var categoryPicked: String!
    var categoryDetailWorkOuts = [CategoryDetails]()
    static var workOutImageCache: NSCache<NSString, UIImage> = NSCache()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = categoryPicked
        DataService.ds.REF_CATEGORY_WORKOUTS.child(categoryPicked).observe(.value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                self.categoryDetailWorkOuts.removeAll()
                for snap in snapshot {
                    print("SNAP: \(snap)")
                    if let categoryWorkOutData = snap.value as? Dictionary<String, String> {
                        let key = snap.key
                        let workouts = CategoryDetails(categoryPickedKey: key, categoryPickedData: categoryWorkOutData)
                        self.categoryDetailWorkOuts.append(workouts)
                    }
                }
            }
            self.tableView.reloadData()
        })
     
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryDetailWorkOuts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let workOutSelected = categoryDetailWorkOuts[indexPath.row]
        let cellIdentifier = "goToWorkOutList"
        
        // Configure the cell...
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? WorkOutListCell {
            if let imageURL = workOutSelected.workOutImage {
                if let img = WorkOutListVC.workOutImageCache.object(forKey: imageURL as NSString) {
                    cell.configureCategoryDetailCell(categoryDetail: workOutSelected, img: img)
                    
                } else {
                    cell.configureCategoryDetailCell(categoryDetail: workOutSelected)
                }
                return cell
            } else {
                return WorkOutListCell()
            }
        } else {
            return WorkOutListCell()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToWorkOutDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! WorkOutDetailVC
                destinationController.workOutSelectedKey = categoryDetailWorkOuts[indexPath.row].categoryPickedKey
                destinationController.workOutName = categoryDetailWorkOuts[indexPath.row].workOutName
                destinationController.level = categoryDetailWorkOuts[indexPath.row].level
                destinationController.duration = categoryDetailWorkOuts[indexPath.row].duration
                destinationController.coach = categoryDetailWorkOuts[indexPath.row].coach
                destinationController.videoid = categoryDetailWorkOuts[indexPath.row].videoid
                destinationController.workoutStructure = categoryDetailWorkOuts[indexPath.row].workoutStructure
                if let image =  categoryDetailWorkOuts[indexPath.row].workOutImage {
                 destinationController.workoutImageURL = image  
                }
                
            }
        }
    }
    
    

}
    


