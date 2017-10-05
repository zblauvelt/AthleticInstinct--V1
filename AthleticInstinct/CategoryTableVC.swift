//
//  CategoryTableVC.swift
//  AthleticInstinct
//
//  Created by Zachary Blauvelt on 10/2/17.
//  Copyright © 2017 ZackBlauvelt. All rights reserved.
//

import UIKit
import Firebase

class CategoryTableVC: UITableViewController {
    
    var categories = [WorkOutCategory]()
    
    //var workOutCategory: WorkOutCategory!

    //var categories = ["10 Minutes", "15 Minutes", "20 Minutes", "25 Minutes", "Kettlebells", "Battle Ropes", "Bodyweight"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataService.ds.REF_CATEGORY.observe(.value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshot {
                    print("SNAP: \(snap)")
                    if let categoryData = snap.value as? Dictionary<String, String> {
                        let key = snap.key
                        let category = WorkOutCategory(CategoryName: key, categoryData: categoryData)
                        self.categories.append(category)
                    }
                }
            }
            self.tableView.reloadData()
        })
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let category = categories[indexPath.row]
        
        let cellIdentifier = "CategoryCell"
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CategoryCell {
            cell.configureCell(category: category)
            return cell
        } else {
            return CategoryCell()
        }
    }
    



}
