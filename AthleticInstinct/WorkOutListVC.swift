//
//  WorkOutListVC.swift
//  AthleticInstinct
//
//  Created by Zachary Blauvelt on 10/5/17.
//  Copyright © 2017 ZackBlauvelt. All rights reserved.
//

import UIKit

class WorkOutListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var categoryPicked: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        print(categoryPicked)
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "goToWorkOutList"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        return cell
    }


    

}
