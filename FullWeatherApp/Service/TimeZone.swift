//
//  TimeZone.swift
//  FullWeatherApp
//
//  Created by Görkem Arpacı on 17.12.2024.
//

import Foundation

class Converter: ObservableObject{
    
    func convertToCityTime(fromUtcDate utcDate: String, timezoneOffset: Int) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        
        if let date = formatter.date(from: utcDate){
            let cityTime = date.addingTimeInterval(TimeInterval(timezoneOffset))
            
            formatter.timeZone = TimeZone(secondsFromGMT: timezoneOffset)
            return formatter.string(from: cityTime)
        }
        else {
            return "Invalid Date"
        }
    }
}

