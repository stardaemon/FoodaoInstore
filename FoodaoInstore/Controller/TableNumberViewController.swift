//
//  TableNumberController.swift
//  FoodaoInstore
//
//  Created by UNIVERSE on 13/7/19.
//  Copyright © 2019 Yunhong Li. All rights reserved.
//

import UIKit

class TableNumberViewController: UIViewController {

    @IBOutlet var logoImg: UIImageView!
    @IBOutlet var tableNumberLabel: UILabel!
    @IBOutlet var tableNumberInput: UITextField!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var inputSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(red: 0.5725, green: 0.1922, blue: 0.1647, alpha: 1.0)
        
        // Initial contexts
        logoImg.image = UIImage(named: "Logo")
        tableNumberInput.text = " "
        tableNumberInput.isUserInteractionEnabled = false
        inputSwitch.backgroundColor = UIColor(red: 0.5725, green: 0.1922, blue: 0.1647, alpha: 1.0)
        inputSwitch.onTintColor = UIColor(red: 0.5725, green: 0.1922, blue: 0.1647, alpha: 1.0)
    }
    
    @IBAction func InputableSwitch(_ sender: Any) {
        return tableNumberInput.isUserInteractionEnabled = !tableNumberInput.isUserInteractionEnabled
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mainMenuIdentifier" {
            let mainMenuController = segue.destination as! MainMenuViewController
            mainMenuController.tableNumber = self.tableNumberInput.text
        }
    }

}
