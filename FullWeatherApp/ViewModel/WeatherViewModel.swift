//
//  WeatherViewModel.swift
//  FullWeatherApp
//
//  Created by Görkem Arpacı on 21.10.2024.
//

import Foundation
import SwiftUI


class WeatherViewModel: ObservableObject {
    @Published var weather : WeatherApi?
    @Published var current : CurrentWeather?
    
    var key : String = ""
    let downloaderClient = DownloaderClient()
    
    init(){
        load()
    }
    
    private func load() {
        Dotenv.load()
        
        if let apiKey = ProcessInfo.processInfo.environment["API_KEY"] {
            self.key = apiKey
        } else {
            print("API anahtarı bulunamadı.")
        }
    }
    
    func fetch(cityName : String) async{
        do {
            let data = try await downloaderClient.fetchData(city: cityName, key:key)
            DispatchQueue.main.async{
                self.weather = data
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchCurrent(cityName : String) async{
        do {
            let dataCrt = try await downloaderClient.currentData(city: cityName, key:key)
            DispatchQueue.main.async{
                self.current = dataCrt
            }

        } catch {
            print(error.localizedDescription)
        }
    }
}
