//
//  FetchData.swift
//  FullWeatherApp
//
//  Created by Görkem Arpacı on 19.10.2024.
//

import Foundation


class DownloaderClient {
    
    func fetchData(city : String, key: String) async throws -> WeatherApi {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&appid=\(key)")
        let request = URLRequest(url: url!)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let fetchedData = try JSONDecoder().decode(WeatherApi.self, from: data)
        return fetchedData
    }
    
    func currentData(city: String, key: String) async throws -> CurrentWeather {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(key)") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))
        do {
            let fetchedCurrent = try JSONDecoder().decode(CurrentWeather.self, from: data)
            return fetchedCurrent
        } catch let decodingError {
            print("Decode Hatası: \(decodingError.localizedDescription)")
            throw decodingError
        }
    }
}
