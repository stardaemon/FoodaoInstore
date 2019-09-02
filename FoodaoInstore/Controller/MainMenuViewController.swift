//
//  MainMenuViewController.swift
//  FoodaoInstore
//
//  Created by UNIVERSE on 13/7/19.
//  Copyright © 2019 Yunhong Li. All rights reserved.
//

import UIKit
import EzPopup

class MainMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate, AddDelegate {
    // The number user input in the previous page
    var tableNumber:String?
    
    @IBOutlet var sideMenuTable: UITableView!
    @IBOutlet var orderSummaryTable: UITableView!
    @IBOutlet var dishesCollection: UICollectionView!
    
    var allCategories = ["All Dishes", "Rices", "Noodles", "Drinks", "Meals"]
    var rices:Category?
    var noodles:Category?
    var drinks:Category?
    var meals:Category?
    var allDishes:[Category]!
    var orders:[Dish] = []
    // Get unique dishes used to be displayed inside order summary table and the dictionary
    // is used to save the relationship between number of orders of different dishes
    var uniqueDishesDictionary = [Dish:Int]()
    var totalPrice = 0.0
    
    // Detecting which column of category table has been clicked, default is All Dishes
    var highlightedCategory = "All Dishes"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Navigation bar color
        navigationController?.navigationBar.barTintColor = UIColor.init(red: 0.5725, green: 0.1922, blue: 0.1647, alpha: 1.0)
        
        // Initiate tables
        self.sideMenuTable.delegate = self
        self.sideMenuTable.dataSource = self
        self.orderSummaryTable.delegate = self
        self.orderSummaryTable.dataSource = self
        // Initiate collection
        self.dishesCollection.delegate = self
        self.dishesCollection.dataSource = self
        
        // Table background color
        self.sideMenuTable.backgroundColor = UIColor.red
        self.orderSummaryTable.backgroundColor = UIColor.yellow
        // Collection background color
        self.dishesCollection.backgroundColor = UIColor.green
        
        // Clear displayed rows format without data
        sideMenuTable.tableFooterView = UIView()
        orderSummaryTable.tableFooterView = UIView()
        
        // Define height of tables
        self.sideMenuTable.rowHeight = 65
        self.orderSummaryTable.rowHeight = 120
        
        // Initialize all dishes
        self.allDishes = initDishes()
    }
    
    // Hard coding all dishes, meals and their belonged categories
    func initDishes()->[Category] {
        // Display all dishes
        var dish1 = Dish(dishName: "dish1", detail: "There is something about this dish", elements: "Element1, Element2, Element3", imageName: "Dish1", videoName: "Video1", price: 7.99, tastes: ["salt","sugar","hot"])
        var dish2 = Dish(dishName: "dish2", detail: "There is something about this dish", elements: "Element1, Element2, Element3", imageName: "Dish2", videoName: "Video2", price: 8.99, tastes: ["salt","sugar","hot"])
        var dish3 = Dish(dishName: "dish3", detail: "There is something about this dish", elements: "Element1, Element2, Element3", imageName: "Dish3", videoName: "Video3", price: 6.99, tastes: ["salt","sugar","hot"])
        var dish4 = Dish(dishName: "dish4", detail: "There is something about this dish", elements: "Element1, Element2, Element3", imageName: "Dish4", videoName: "Video4", price: 10.99, tastes: ["salt","sugar","hot"])
        var dish5 = Dish(dishName: "dish5", detail: "There is something about this dish", elements: "Element1, Element2, Element3", imageName: "Dish5", videoName: "Video5", price: 2.99, tastes: ["salt","sugar","hot"])
        var dish6 = Dish(dishName: "dish6", detail: "There is something about this dish", elements: "Element1, Element2, Element3", imageName: "Dish6", videoName: "Video6", price: 2.99, tastes: ["salt","sugar","hot"])
        var dish7 = Dish(dishName: "dish7", detail: "There is something about this dish", elements: "Element1, Element2, Element3", imageName: "Dish7", videoName: "Video7", price: 1.99, tastes: ["salt","sugar","hot"])
        var dish8 = Dish(dishName: "dish8", detail: "There is something about this dish", elements: "Element1, Element2, Element3", imageName: "Dish8", videoName: "Video8", price: 4.99, tastes: ["salt","sugar","hot"])
        var dish9 = Dish(dishName: "dish9", detail: "There is something about this dish", elements: "Element1, Element2, Element3", imageName: "Dish9", videoName: "Video9", price: 3.99, tastes: ["salt","sugar","hot"])
      
        // Init meals
        dish1.meals.append(dish2)
        dish1.meals.append(dish3)
        dish2.meals.append(dish3)
        dish2.meals.append(dish4)
        
        // Init all categories
        self.rices = Category(categoryName: "Rices", categoryImage: "Rice", categoryDishes:[dish1, dish2, dish3])
        self.noodles = Category(categoryName: "Noodles", categoryImage: "Noodle", categoryDishes: [dish4, dish5])
        self.drinks  = Category(categoryName:"Drinks", categoryImage: "Drinks", categoryDishes: [dish6, dish7])
        self.meals = Category(categoryName: "Meals", categoryImage: "Meals", categoryDishes: [dish8, dish9])
        var categoryDishes:[Category] = []
        categoryDishes.insert(self.rices!, at: 0)
        categoryDishes.insert(self.noodles!,at: 1)
        categoryDishes.insert(self.drinks!, at:2)
        categoryDishes.insert(self.meals!,at: 3)
        return categoryDishes
    }
    
    // Number of rows in a table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // detect which table it is
        if (tableView === sideMenuTable) {
            return allCategories.count
        } else {
            return self.uniqueDishesDictionary.count
        }
    }
    
    // Detail information inside each row of a table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // detect which table it is
        if (tableView === sideMenuTable) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCellIdentifier", for: indexPath) as! MenuTableViewCell
            
            // Guarantee the table is not empty
            if (allCategories.count > 0) {
                let currentCategory = allCategories[indexPath.row]
                cell.CategoryNameLabel.text = currentCategory
            }
            
            cell.backgroundColor = .blue
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderDishIdentifier", for: indexPath) as! OrderDishTableViewCell
            if (uniqueDishesDictionary.count > 0) {
                let dish = Array(uniqueDishesDictionary.keys)[indexPath.row]
                cell.dishModel = dish
                var number = uniqueDishesDictionary[dish]!
                cell.number = number
                cell.awakeFromNib()
                cell.setStepper()
                cell.onSteperButtonTapped = {
                    number += 1
                    self.uniqueDishesDictionary[dish] = number
                    let tempTotal = dish.price! * Double(number)
                    cell.dishTatseLabel.text = "NUMBER: \(number)\nPRICE: $\(tempTotal)"
                }
                cell.onSteperCalButtonTapped = {
                    number -= 1
                    self.uniqueDishesDictionary[dish] = number
                    let tempTotal = dish.price! * Double(number)
                    if (number == 0) {
                        self.uniqueDishesDictionary.removeValue(forKey: dish)
                        self.orderSummaryTable.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
                        self.orderSummaryTable.reloadData()
                    } else {
                        cell.dishTatseLabel.text = "NUMBER: \(number)\nPRICE: $\(tempTotal)"
                    }
                }
            }
            
            cell.backgroundColor = .blue
            return cell
        }
    }
    
    // Applied this method to get clicked category row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (tableView == sideMenuTable) {
            self.highlightedCategory = allCategories[indexPath.row]
            self.dishesCollection.reloadData()
        }
    }
    
    // Just all categories have multiple sections
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if (highlightedCategory == "All Dishes") {
            return self.allCategories.count
        }
        
        return 1
    }
    
    // number of itmes in each section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch highlightedCategory {
        case "Rices":
            return self.rices!.categoryDishes!.count
        case "Noodles":
            return self.noodles!.categoryDishes!.count
        case "Drinks":
            return self.drinks!.categoryDishes!.count
        case "Meals":
            return self.meals!.categoryDishes!.count
        default:
            if (section == 0) {
                return 0
            }
           return self.allDishes![section - 1].categoryDishes!.count
        }
    }
    
    // Detail information showed in one cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuCellIdentifier", for: indexPath) as! MenuCollectionViewCell
        
        switch self.highlightedCategory {
        case "Rices":
            cell.dishModel = self.rices!.categoryDishes![indexPath.row]
        case "Noodles":
            cell.dishModel = self.noodles!.categoryDishes![indexPath.row]
        case "Drinks":
            cell.dishModel = self.drinks!.categoryDishes![indexPath.row]
        case "Meals" :
            cell.dishModel = self.meals!.categoryDishes![indexPath.row]
        default: // all categories
            cell.dishModel = self.allDishes![indexPath.section - 1].categoryDishes?[indexPath.row]
        }
        
        // Control cell button click action to access detail page
        cell.onDetailClicked = {
            let detailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detailViewStoryboard") as! DetailViewController
            detailViewController.dish = cell.dishModel
            detailViewController.delegate = self
            let popupVC = PopupViewController(contentController: detailViewController, popupWidth: 1000, popupHeight: 800)
            
            self.present(popupVC, animated: true, completion: nil)
        }
        
        return cell
    }
    
    // Headers used for sections
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "menuHeaderIdentifier", for: indexPath) as! MenuHeaderCollectionReusableView
        
        // hide the first section header, which should be all categories for all category, or a specific header for specific category
        if ((indexPath as NSIndexPath).section == 0) {
            headerView.categoryNameLabel.isHidden = true
        }
        
        headerView.categoryNameLabel.text = self.allCategories[(indexPath as NSIndexPath).section]
        
        return headerView
    }
    
    func addToCart(dish: Dish) {
        self.orders.append(dish)
        
        // refresh the dictionary which is used to store values of
        if (self.uniqueDishesDictionary.index(forKey: dish) != nil) {
            uniqueDishesDictionary[dish] = uniqueDishesDictionary[dish]! + 1
        } else {
            uniqueDishesDictionary[dish] = 1
        }
        
        // Force Refresh summary table
        self.orderSummaryTable.reloadData()
    }
    
    // Calculathe the total price of the user's order
    func calculateSummary () {
        for (dish, number) in self.uniqueDishesDictionary {
            self.totalPrice += dish.price! * Double(number)
        }
    }
}
