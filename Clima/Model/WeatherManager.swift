//
//  WeatherManager.swift
//  Clima
//
//  Created by Jotno on 7/31/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManger{
    
    // removing q = city name form the string and adding it dynamically, as the order of the parameters does not matter
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=783b4c69f0216c6517767d5200f12680&units=metric"
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        
        print(urlString)
        performRequest(urlSring: urlString)
    }
    
    
    func performRequest(urlSring : String){
        //Create URL
        
        if let url = URL(string: urlSring){
            
            //Create URL Session
            
            let session = URLSession(configuration: .default)
            
            //Give URL a Task
            // Without using closures, had to create a external function handler
            /*
             let task =  session.dataTask(with: url, completionHandler: handler(data:resposnse:error:))
             */
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil{
                    print(error!)
                    return
                }
                
                if let safeData = data{
                    self.parseJSON(weatherData: safeData)
                }
            }
            
            //Run Task
            task.resume()
        }
        
        
    }
    
    
//    func handler(data: Data?, resposnse : URLResponse?, error:Error?){
//        if error != nil{
//            print(error!)
//            return
//        }
//
//        if let safeData = data{
//            let dataString = String(data: safeData, encoding: .utf8)
//            print(dataString!)
//        }
//    }
    
    func parseJSON(weatherData:Data){
        // Create a structure that the weather data will come back in
        
        let decoder = JSONDecoder()
        
        
        
        do{
            // decoder decodes the data to Weather Data structure and puts the value from weatherData parameter
           let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print("The Temperature of \(decodedData.name) is \(decodedData.main.temp) and the weather is \(decodedData.weather[0].description)")
        }catch{
            print(error)
        }
        
    }
    
    
    
    
}
