//
//  TasteTableViewCell.swift
//  FoodaoInstore
//
//  Created by UNIVERSE on 20/8/19.
//  Copyright © 2019 Yunhong Li. All rights reserved.
//

import UIKit

class TasteTableViewCell: UITableViewCell {

    @IBOutlet var tasteNameLabel: UILabel!
    
    // Gurantee the button action can be addressed by outside functions
    var onAddButtonTapped : (() -> Void)? = nil
    
    @IBAction func addToCart(_ sender: Any) {
        if let onAddButtonTapped = self.onAddButtonTapped {
            onAddButtonTapped()
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
