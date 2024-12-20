//
//  InfoView.swift
//  FullWeatherApp
//
//  Created by Görkem Arpacı on 11.10.2024.
//

import SwiftUI

struct InfoView: View {
    
    var center = UIScreen.main.bounds.width / 2
    @Binding var text: String
    @ObservedObject  var weatherVM : WeatherViewModel
    let converter = Converter()

    var body: some View {
        ZStack {
            if let weather = weatherVM.weather {
                
                RoundedRectangle(cornerRadius: 30)
                    .fill(Gradient(colors: [.clear, .white])
                        .shadow(.drop(color: .gray, radius: 4))
                    )
                    .frame(width: 400, height: 246)
                    .position(x: center, y: 623)
                    .shadow(radius: 10)

                Divider()
                    .background(Color.white)
                    .frame(height: 2)
                    .position(x: center, y: 555)

                HStack {
                    Text("Today")
                        .font(.custom("OpenSans-VariableFont_wdth,wght", size: 20))
                        .foregroundColor(Color(hex: "362A84"))

                    Spacer()

                    let words = weather.list[0].dtTxt.components(separatedBy: " ")
                    if let weather = weatherVM.weather{
                        Text(converter.convertToCityTime(fromUtcDate: words[1], timezoneOffset: weather.city.timezone))
                            .font(.custom("OpenSans-VariableFont_wdth,wght", size: 20))
                            .foregroundColor(Color(hex: "362A84"))
                    }
                }
                .padding(.horizontal, 40)
                .position(x: center, y: 530)

                WeatherForecastList(weatherVM: weatherVM, weatherList: Array(weather.list.prefix(5)))
                    .padding(.top, 500)
                    .frame(width: 350, alignment: .center)
            }
        }
        .onAppear {
            Task {
                await weatherVM.fetch(cityName: text)
            }
        }
    }
}

// Alt View: Weather forecast listesi için ayrı bir View oluşturuldu.
struct WeatherForecastList: View {
    
    let timeObject = Converter()
    @ObservedObject var weatherVM : WeatherViewModel
    let weatherList: [WeatherList]

    var body: some View {
        HStack {
            ForEach(weatherList.dropFirst(), id: \.dtTxt) { forecast in
                VStack {
                    Text("\(Int(forecast.main.temp - 273.15))°C")
                        .font(.callout)
                        .foregroundColor(Color(hex: "362A84"))
                        .padding(EdgeInsets(top: 30, leading: 0, bottom: 0, trailing: 0))
                    
                    if let icon = forecast.weather.first?.icon {
                        Image(icon)
                            .resizable()
                            .scaledToFit()
                            .clipShape(Rectangle())
                            .aspectRatio(contentMode: .fit)


                    }
                    let word = forecast.dtTxt.components(separatedBy: " ")
                        if let weather = weatherVM.weather {
                            Text(timeObject.convertToCityTime(fromUtcDate: word[1], timezoneOffset:      weather.city.timezone))
                                .foregroundColor(Color(hex: "362A84"))
                    }
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var text = ""
    let weatherVM = WeatherViewModel()
    InfoView(text: $text, weatherVM:weatherVM)
}

