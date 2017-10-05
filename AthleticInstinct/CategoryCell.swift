//
//  CategoryCell.swift
//  AthleticInstinct
//
//  Created by Zachary Blauvelt on 10/2/17.
//  Copyright © 2017 ZackBlauvelt. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {

    @IBOutlet weak var CategoryImage: UIImageView!
    @IBOutlet weak var CategoryNameLabel: UILabel!
    
    var category: WorkOutCategory!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(category: WorkOutCategory) {
        self.category = category
        self.CategoryNameLabel.text = category.name.uppercased()
        self.CategoryImage.image = UIImage(named: category.image)
        
    }

}
