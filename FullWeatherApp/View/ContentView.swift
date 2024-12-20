//
//  ContentView.swift
//  FullWeatherApp
//
//  Created by Görkem Arpacı on 6.10.2024.
//

import SwiftUI



let foreCastData : [WeatherForeCast] = [
    WeatherForeCast(degree: 19, time: "15.00", condition: "rain"),
    WeatherForeCast(degree: 18, time: "16.00", condition: "clear"),
    WeatherForeCast(degree: 18, time: "17.00", condition: "mist"),
    WeatherForeCast(degree: 18, time: "18.00", condition: "rain"),
]




struct ContentView: View {
    @State private var showDetailView = true
    @State private var cityName : String = ""
    

    var body: some View {
        
        ZStack{
            if showDetailView {
                FinalView(text: $cityName)
                    .onSubmit {
                        withAnimation(.spring()){
                            showDetailView.toggle()
                        }
                    }
            }
            else {
                DetailView(text: $cityName)
            }
        }
    }
}

#Preview {
    ContentView()
}
