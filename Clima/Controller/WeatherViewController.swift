//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController{
    
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManger = WeatherManger()
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherManger.delegate = self
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        searchTextField.delegate = self
      
        
        
    }
    
    
    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    
    
    
}

//MARK: - UITextFieldDelegate
extension WeatherViewController : UITextFieldDelegate{
    
    @IBAction func searchPressed(_ sender: UIButton) {
        
        
        if let cityName = searchTextField.text{
            print(cityName)
        }else{
            print("Enter City")
        }
        
        searchTextField.endEditing(true)
        
    }
    
    // this function is called when the return key in the keyboard is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(searchTextField.text!)
        searchTextField.endEditing(true)
        return true
    }
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""{
            return true
        }else{
            textField.placeholder = "Type Something Man"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        // Get what the user typed in the text field when done editing
        if let city = searchTextField.text{
            weatherManger.fetchWeather(cityName: city)
        }
        searchTextField.text = ""
    }
}

//MARK: - Weather Manager Delegate

extension WeatherViewController : WeatherManagerDelegate{
    
    func didUpdateWeather(_ weatherManager : WeatherManger, weather : WeatherModel){
        
        
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.cityLabel.text = weather.cityName
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
        }
        
        
        
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
}

//MARK: - CLLocationManagerDelegate

extension WeatherViewController : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManger.fetchWeather(latitude: lat, longitude: lon)
            
        }
        print("Got Location")
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

