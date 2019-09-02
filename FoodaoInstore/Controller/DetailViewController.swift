//
//  DetailViewController.swift
//  FoodaoInstore
//
//  Created by UNIVERSE on 17/8/19.
//  Copyright © 2019 Yunhong Li. All rights reserved.
//

import UIKit

// Define a delegate to control add button clicked functions
protocol AddDelegate : class {
    func addToCart(dish:Dish)
}

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    // curernt dish which is used to display main contents
    var dish:Dish?
    // tastes and meals available for this dish
    var tastes = [String]()
    var meals = [Category]()
    
    weak var delegate:AddDelegate?
    
    @IBOutlet var dishImage: UIImageView!
    @IBOutlet var dishNameLabel: UILabel!
    @IBOutlet var elementLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var tasteTable: UITableView!
    @IBOutlet var suggestedTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Background color of the page 
        self.view.backgroundColor = UIColor.red
        initDish()
    }
    
    // Init layout and elemnts of the page
    func initDish() {
        if (self.dish != nil) {
            self.dishImage.image = UIImage(named: (self.dish!.imageName)!)
            self.dishNameLabel.text = self.dish!.dishName
            self.elementLabel.text = "Elements \(self.dish!.elements ?? "UNKNOWN")"
            self.priceLabel.text = "$\(self.dish!.price!)"
            self.tastes = self.dish!.tastes!
            self.tasteTable.dataSource = self
            self.suggestedTable.dataSource = self
            // Make the header of meal table can be displayed
            self.suggestedTable.delegate = self as? UITableViewDelegate
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView === self.tasteTable {
            return 1
        } else {
            // Sections in the Meal Table
            return self.dish?.meals.count ?? 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tasteTable {
            return self.tastes.count
        } else {
            // Number of rows in each meal's section
            return self.dish?.meals[section].tastes?.count ?? 0
        }
    }

    // Define header of each meal's section
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if (tableView === self.suggestedTable) {
            let vw = UIView()
            vw.backgroundColor = UIColor.lightGray
            let headImage = UIImage(named:(dish?.meals[section].imageName)!)
            let imageView = UIImageView(image:headImage)
            imageView.frame = CGRect(x: 5, y: 5, width: 100, height: 50)
            let headerLabel = UILabel(frame: CGRect(x: 120, y: 5, width:200, height: 40))
            let dishName = self.dish?.meals[section].dishName!
            let dishPrice = String(format:"%.2f", (self.dish?.meals[section].price!)!)
            headerLabel.text = dishName! + " $" +  dishPrice
            vw.addSubview(imageView)
            vw.addSubview(headerLabel)
            return vw
        } else {
            return nil
        }
    }
    
    // Define displayed height of meal's section headers
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (tableView === self.suggestedTable) {
            return 60
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (tableView == self.tasteTable) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "tasteCellIdentifier") as! TasteTableViewCell
            cell.tasteNameLabel.text = tastes[indexPath.row]
            cell.onAddButtonTapped = {
                // Make selected taste as a new dish
                let newTatse = Dish(dishName: self.dish!.dishName!, detail: self.dish!.detail!, elements: self.dish!.elements!, imageName: self.dish!.imageName!, videoName: self.dish!.videoName!, price: self.dish!.price!, tastes: [self.tastes[indexPath.row]])
                // Add new tatste dish to the cart
                self.delegate?.addToCart(dish: newTatse)
            }
            return cell

        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "mealTasteIdentifier") as! MealTasteTableViewCell
            cell.mealTasteNameLabel.text = self.dish?.meals[indexPath.section].tastes?[indexPath.row]
            cell.onMealAddButtonTapped = {
                // Make a new dish and transfer the value to delegate
                let newMealTaste = Dish(dishName: self.dish!.meals[indexPath.section].dishName!, detail: self.dish!.meals[indexPath.section].detail!, elements: self.dish!.meals[indexPath.section].elements!, imageName: self.dish!.meals[indexPath.section].imageName!, videoName: self.dish!.meals[indexPath.section].videoName!, price: self.dish!.meals[indexPath.section].price!, tastes: [self.dish!.meals[indexPath.section].tastes![indexPath.row]])
                self.delegate?.addToCart(dish: newMealTaste)
            }
            return cell
        }
    }

}
