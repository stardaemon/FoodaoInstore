//
//  Category.swift
//  FoodaoInstore
//
//  Created by UNIVERSE on 16/7/19.
//  Copyright © 2019 Yunhong Li. All rights reserved.
//

import UIKit

// A category used to contain different meals
class Category: NSObject {
    var categoryName:String?
    var categoryImage: String?
    var categoryDishes:[Dish]?
    
    init(categoryName:String, categoryImage:String, categoryDishes:[Dish]) {
        self.categoryName = categoryName
        self.categoryImage = categoryImage
        self.categoryDishes = categoryDishes
    }
}
