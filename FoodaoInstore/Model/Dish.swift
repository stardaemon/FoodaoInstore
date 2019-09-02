//
//  Dish.swift
//  FoodaoInstore
//
//  Created by UNIVERSE on 16/7/19.
//  Copyright © 2019 Yunhong Li. All rights reserved.
//

import UIKit

struct Dish: Hashable {
    
    // Basic information used to display or calculate for a dish
    var dishName:String?
    var detail: String?
    var elements: String?
    var imageName:String?
    var videoName: String?
    
    // Information used for pricing, number of orders and discounts
    var price:Double?
    var discount:Double?
    var orderNum:Int = 0
    
    // different tastes of one dish, such as salt and sugar
    var tastes:[String]?
    // different meals associated with current dish
    var meals:[Dish]
    
    // Initiate a dish 
    init(dishName:String, detail:String, elements:String, imageName:String,
                  videoName:String, price:Double, tastes:[String]) {
        self.dishName = dishName
        self.detail = detail
        self.elements = elements
        self.imageName = imageName
        self.videoName = videoName
        self.price = price
        self.tastes = tastes
        self.meals = []
    }
    
    // Detect if two objects are the same one
    static func == (lhs: Dish, rhs: Dish) -> Bool {
        return lhs.dishName == rhs.dishName &&
            lhs.price == rhs.price &&
            lhs.tastes?.joined() == rhs.tastes?.joined()
    }
    
}
