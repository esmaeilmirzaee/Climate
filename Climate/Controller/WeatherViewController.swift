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

class WeatherViewController: UIViewController, CLLocationManagerDelegate, ChangeCityDelegate {
  
  // Constants
  let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
  let APP_ID = "894f130231441d5e5b0c37596bc79c58"
  
  let locationManager = CLLocationManager() //2
  let weatherDataModel = WeatherDataModel() // 7
  
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
        
        if let weatherJSON = response.result.value {
          print(weatherJSON)
          self.updateWeatherData(json: JSON(weatherJSON))
        }
      } else {
        print("Error: \(response.result.error)")
        self.cityLabel.text = "Connection issue 😔"
      }
    }
  }
  
  //MARK 7 - JSON Parsing
  func updateWeatherData(json: JSON) {
    if let weatherData = json["main"]["temp"].double {
      weatherDataModel.temperature = Int(weatherData - 273.15)
      weatherDataModel.city = "\(json["name"].stringValue), (\(json["sys"]["country"].stringValue))"
      weatherDataModel.condition = Int(json["weather"]["id"].intValue)
      weatherDataModel.weatherIconName = weatherDataModel.weatherIcon(condition: weatherDataModel.condition)
      updateUIWithWeatherData()
    } else {
      cityLabel.text = "Weather's unavilable"
    }
  }
  
  //MARK - UI Updates
  func updateUIWithWeatherData() {
    cityLabel.text = weatherDataModel.city
    temperatureLabel.text = "\(weatherDataModel.temperature)º"
    weatherIcon.image = UIImage(named: weatherDataModel.weatherIconName)
    
  }
  
  //MARK 5 - Location Manager Delegate Method
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let location = locations[locations.count - 1]
    if location.horizontalAccuracy > 0 {
      locationManager.stopUpdatingLocation()
      print("longitude = \(location.coordinate.longitude), latitude = \(location.coordinate.latitude)")
      
      let params: [String: String] = ["lat": String(location.coordinate.latitude), "lon": "\(location.coordinate.longitude)",  "appid": APP_ID]
      locationManager.delegate = nil
      getWeatherData(url: WEATHER_URL, parameters: params)
    }
  }
  
  // 6
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print(error)
    cityLabel.text = "Location's Unavailable"
  }
  
  @IBAction func goToChangeCityViewControllerButtonPressed(_ sender: UIButton) {
    performSegue(withIdentifier: "changeCityName", sender: self)
  }
  
  //MARK 8 - Change City Delegate Methods
  // userEnteredANewCityName delegate method
  // prepareForSegure method
  func userEnteredANewCityName(city: String) {
    print(city)
  }
  
  //MARK 8 - prepareForSegues
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "changeCityName" {
      let destinationVC = segue.destination as! ChangeCityViewController
      destinationVC.delegate = self
    }
  }
}
