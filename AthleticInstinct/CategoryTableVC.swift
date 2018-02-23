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
    static var categoryImageCache: NSCache<NSString, UIImage> = NSCache()
    
    @IBOutlet weak var addWorkout: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkAdminStatus()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        DataService.ds.REF_CATEGORY.observe(.value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                self.categories.removeAll()
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
        
        //Configure cell
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CategoryCell {
            if let imageURL = category.image {
                if let img = CategoryTableVC.categoryImageCache.object(forKey: imageURL as NSString) {
                    cell.configureCell(category: category, img: img)
                    
                } else {
                    cell.configureCell(category: category)
                }
                return cell
            } else {
                return CategoryCell()
            }
        } else {
            return CategoryCell()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "categoryDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! WorkOutListVC
                destinationController.categoryPicked = categories[indexPath.row].name
            }
        }
    }
    
    
    @IBAction func signOutBtnTapped(_ sender: Any) {
        try! FIRAuth.auth()?.signOut()
        userID = ""
        print("ZACK: Signed out of Firebase Successfully")
        dismiss(animated: true, completion: nil)
    }
    
    //Check if uid is the admin if so add icon
    func checkAdminStatus() {
        if userID == "J5PDq7Q6CDQ7upooaQ1dKn20fb02" {
            self.navigationItem.rightBarButtonItem = self.addWorkout
        } else {
            self.navigationItem.rightBarButtonItem = nil
        }
    }
    
    @IBAction func cancel(segue: UIStoryboardSegue) {}
    

}
