//
//  WeatherData.swift
//  Clima
//
//  Created by Jotno on 7/31/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

// Making the struct Decodable so that it can decode itself form external representation
struct WeatherData : Decodable{
    
    let name : String
    let visibility : Int
    let id : Int
    let timezone : Int
    let main : Main
    let weather : [Weather]
    
    
    
}

struct Main : Decodable{
    let temp : Double
    let feels_like : Double
    let humidity : Int
}

struct Weather : Decodable{
    
    let id : Int
    let main : String
    let description : String
    let icon : String
}
