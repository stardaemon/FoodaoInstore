//
//  MenuCollectionViewCell.swift
//  FoodaoInstore
//
//  Created by UNIVERSE on 20/7/19.
//  Copyright © 2019 Yunhong Li. All rights reserved.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    @IBOutlet var dishBackgroundImage: UIImageView!
    @IBOutlet var dishNameLabel: UILabel!
    @IBOutlet var dishPriceLabel: UILabel!
    @IBOutlet var transparentImage: UIImageView!
    
    var onDetailClicked: (() -> Void)? = nil
    
    @IBAction func detaiViewClicked(_ sender: Any) {
        if let onDetailClicked = self.onDetailClicked {
            onDetailClicked()
        }
    }
    
    // Set values of the cell
    var dishModel:Dish? {
        didSet {
            if let imageName = dishModel?.imageName {
                dishBackgroundImage.image = UIImage(named: imageName)
            }
            
            if let dishName = dishModel?.dishName {
                dishNameLabel.text = dishName
            }
            
            if let dishPrice = dishModel?.price {
                dishPriceLabel.text = "$\(dishPrice)"
            }
            
            transparentImage.image = UIImage(named: "Transparent")
        }
    }
    
}
