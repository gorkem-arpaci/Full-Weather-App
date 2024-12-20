//
//  WeatherApi.swift
//  FullWeatherApp
//
//  Created by Görkem Arpacı on 11.10.2024.
//

import Foundation


struct WeatherApi : Codable{
    let list : [WeatherList]
    let city : City
}

struct WeatherList : Codable {
    let dt : Int
    let main : WeatherMain
    let weather : [Weather]
    let dtTxt : String
    
    private enum CodingKeys : String, CodingKey {
        case dt = "dt"
        case main = "main"
        case weather = "weather"
        case dtTxt = "dt_txt"
    }
}

struct WeatherMain : Codable {
    let temp : Double
    let tempMin : Double
    let tempMax : Double
    
    private enum CodingKeys : String, CodingKey {
        case temp = "temp"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

struct Weather : Codable {
    let icon : String
    let description : String
}

struct City : Codable {
    let timezone : Int
}

struct WeatherForeCast  {
    let degree : Double
    let time : String
    let condition : String
}


struct CurrentWeather : Codable {
    let main : CurrentMain
    let weather : [CurrentInfo]
}

struct CurrentMain : Codable{
    let temp : Double
    let tempMin : Double
    let tempMax : Double
    
    private enum CodingKeys : String, CodingKey {
        case temp = "temp"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

struct CurrentInfo : Codable {
    let icon : String
    let description : String
}
