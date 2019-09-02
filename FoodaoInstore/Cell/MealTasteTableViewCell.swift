//
//  MealTasteTableViewCell.swift
//  FoodaoInstore
//
//  Created by UNIVERSE on 20/8/19.
//  Copyright © 2019 Yunhong Li. All rights reserved.
//

import UIKit

class MealTasteTableViewCell: UITableViewCell {

    @IBOutlet var mealTasteNameLabel: UILabel!

    // Gurantee the button action can be addressed by outside functions 
    var onMealAddButtonTapped : (() -> Void)? = nil

    @IBAction func mealAddButtonTapped(_ sender: Any) {
        if let onMealAddButtonTapped = self.onMealAddButtonTapped {
            onMealAddButtonTapped()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
