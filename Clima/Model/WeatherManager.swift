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
            
           let task =  session.dataTask(with: url, completionHandler: <#T##(Data?, URLResponse?, Error?) -> Void#>)
            
            
            //Run Task
            task.resume()
        }
        
       
    }
    
    
    
    
    
}
