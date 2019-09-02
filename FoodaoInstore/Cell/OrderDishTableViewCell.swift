//
//  OrderDishTableViewCell.swift
//  FoodaoInstore
//
//  Created by UNIVERSE on 16/7/19.
//  Copyright © 2019 Yunhong Li. All rights reserved.
//

import UIKit

class OrderDishTableViewCell: UITableViewCell {

    var number = 1
    var price = 1.0
    var total = 0.0
    var oldValue = 1
    
    var onSteperButtonTapped : (() -> Void)? = nil
    var onSteperCalButtonTapped : (() -> Void)? = nil
    var dishModel:Dish?
    
    @IBOutlet var dishImage: UIImageView!
    @IBOutlet var dishNamePriceLabel: UILabel!
    @IBOutlet var dishTatseLabel: UILabel!
    @IBOutlet var stepper: UIStepper!
    @IBAction func count(_ sender: UIStepper) {
        if ((dishModel) != nil) {
            number = Int(sender.value)
            
            // Detect whether add or minus button is clicked
            if number > oldValue
            {
                oldValue = oldValue + 1
                onSteperButtonTapped!()
            }
            
            if number < oldValue
            {
                oldValue = oldValue - 1
                onSteperCalButtonTapped!()
            }
            
        }
    }
    
    func setStepper()
    {
        self.stepper.value = Double(number)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if ((dishModel) != nil) {
            dishImage.image = UIImage(named: dishModel!.imageName!)
            var dishTaste = dishModel!.tastes!.joined(separator: "")
            var temPrice = dishModel!.price! * Double(number)
            
            self.oldValue = Int(stepper.value)
            
            dishNamePriceLabel.text = "\(dishModel!.dishName!) \(dishTaste)"
            dishTatseLabel.text = "NUMBER: \(number)\nPRICE: $\(temPrice)"
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
