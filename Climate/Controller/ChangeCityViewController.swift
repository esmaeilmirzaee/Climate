//
//  ChangeCityViewController.swift
//  Climate
//
//  Created by Esmaeil MIRZAEE on 2019-09-30.
//  Copyright © 2019 Esmaeil MIRZAEE. All rights reserved.
//


import UIKit

class ChangeCityViewController: UIViewController {
    
    // Declare the delegate variable
    
    // pre-linked IBoutlets to the text field
    @IBOutlet weak var changeCityTextField: UITextField!
    
    // This is the IBAction that gets call when the user taps on the "Get Weather" button
    @IBAction func getWeatherPressed(_ sender: UIButton) {
        // Get the city name the user entered in the text field
        
        // 2 If we have a delegate set, call the method userEnteredANEWCityName
        
        // 3 Dismiss the Change City View Controller to go back to the WeatherViewController
    }
    
    // This is the IBAction that gets called when the user taps the back button. It dismissed the ChangeCityViewController.
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
}
