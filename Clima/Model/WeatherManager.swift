//
//  WeatherManager.swift
//  Clima
//
//  Created by Jotno on 7/31/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation


protocol WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager : WeatherManger ,weather: WeatherModel)
    func didFailWithError(error : Error)
}

struct WeatherManger{
    
    // removing q = city name form the string and adding it dynamically, as the order of the parameters does not matter
    
    
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=783b4c69f0216c6517767d5200f12680&units=metric"
    
    var delegate : WeatherManagerDelegate?
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        
        print(urlString)
        performRequest(with: urlString)
    }
    
    
    func performRequest(with urlSring : String){
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
                    delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data{
                    
                    if let weather = self.parseJSON(safeData){
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
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
    
    func parseJSON(_ weatherData:Data) -> WeatherModel?{
        // Create a structure that the weather data will come back in
        
        let decoder = JSONDecoder()
        
        
        
        do{
            // decoder decodes the data to Weather Data structure and puts the value from weatherData parameter
           let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
//            print("The Temperature of \(decodedData.name) is \(decodedData.main.temp) and the weather is \(decodedData.weather[0].description)")
            let id = decodedData.weather[0].id
            let name = decodedData.name
            let temp = decodedData.main.temp
            
            let weather = WeatherModel(cityName: name, temp: temp, conditionId: id)
            
            return weather
            
            
        }catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
    
    
    
    
}
