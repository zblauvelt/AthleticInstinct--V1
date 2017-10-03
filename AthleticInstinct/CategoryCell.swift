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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
