//
//  ChangeCityViewController.swift
//  Climate
//
//  Created by Esmaeil MIRZAEE on 2019-09-30.
//  Copyright © 2019 Esmaeil MIRZAEE. All rights reserved.
//


import UIKit

// 8 Write the protocol declaration:
protocol ChangeCityDelegate {
  func userEnteredANewCityName(city: String)
}


class ChangeCityViewController: UIViewController {
    
  // Declare the delegate variable
  var delegate: ChangeCityDelegate?
  
  // pre-linked IBoutlets to the text field
  @IBOutlet weak var changeCityTextField: UITextField!
  
  // MARK 9
  // This is the IBAction that gets call when the user taps on the "Get Weather" button
  @IBAction func getWeatherPressed(_ sender: UIButton) {
    // 1 Get the city name the user entered in the text field
    if let cityName = changeCityTextField.text {
    
      // 2 If we have a delegate set, call the method userEnteredANEWCityName
      delegate?.userEnteredANewCityName(city: cityName)
    
      // 3 Dismiss the Change City View Controller to go back to the WeatherViewController
      self.dismiss(animated: true, completion: nil)
    }
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
