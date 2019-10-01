//
//  ViewController.swift
//  Climate
//
//  Created by Esmaeil MIRZAEE on 2019-09-30.
//  Copyright © 2019 Esmaeil MIRZAEE. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire //6
import SwiftyJSON //6

class WeatherViewController: UIViewController, CLLocationManagerDelegate {
  
  // Constants
  let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
  let APP_ID = "894f130231441d5e5b0c37596bc79c58"
  
  let locationManager = CLLocationManager() //2
  
  // Pre-linked IBOutlets
  @IBOutlet weak var temperatureLabel: UILabel!
  @IBOutlet weak var weatherIcon: UIImageView!
  @IBOutlet weak var cityLabel: UILabel!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    locationManager.delegate = self //2
    locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation //2
    locationManager.requestWhenInUseAuthorization() //2
    locationManager.startUpdatingLocation() //4
  }
  
  //MARK 6 - Networking
  func getWeatherData(url: String, parameters: [String: String]) {
    Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
      response in
      if response.result.isSuccess {
        print("Success! Got the weather data.")
      } else {
        print("Error: \(response.result.error)")
        self.cityLabel.text = "Connection issue 😔"
      }
    }
  }
  
  //MARK - JSON Parsing
  func updateWeatherData() {
    
  }
  
  //MARK - UI Updates
  func updateUIWithWeatherData() {
  
  }
  
  //MARK 5 - Location Manager Delegate Method
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let location = locations[locations.count - 1]
    if location.horizontalAccuracy > 0 {
      locationManager.stopUpdatingLocation()
      print("longitude = \(location.coordinate.longitude), latitude = \(location.coordinate.latitude)")
      
      let params: [String: String] = ["longitude": "\(location.coordinate.longitude)", "latitude": String(location.coordinate.latitude), "appid": APP_ID]
      
      getWeatherData(url: WEATHER_URL, parameters: params)
    }
  }
  
  // 6
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print(error)
    cityLabel.text = "Location's Unavailable"
  }
  
  //MARK - Change City Delegate Methods
  // userEnteredANewCityName delegate method
  // prepareForSegure method
}
