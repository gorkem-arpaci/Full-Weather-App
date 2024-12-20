import SwiftUI


struct DetailView: View {
    @Namespace private var animation
    @Binding var text: String
    @StateObject private var weatherVM = WeatherViewModel()
    let converter = Converter()
    
    
    var body: some View {

        
        ZStack {
            Rectangle()
                .fill(Gradient(colors: [Color(hex: "#5090eb"), .blue]))
                .ignoresSafeArea()
            
            if let weather = weatherVM.weather, let current = weatherVM.current {
                let iconCase = IconCase()
                let iconName = iconCase.getIcon(icon: current.weather[0].icon)
                SearchBox(text: $text)
                    .position(x: UIScreen.main.bounds.width / 2, y: 75)
                    .matchedGeometryEffect(id: "searchbox", in: animation)
                    .onSubmit {
                        Task {
                            await weatherVM.fetch(cityName: text)
                            await weatherVM.fetchCurrent(cityName: text)
                        }
                    }
                    .zIndex(1)
                
                    Image(iconName)
                        .resizable()
                        .scaledToFit()
                        .clipShape(Rectangle())
                        .aspectRatio(contentMode: .fit)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 300, trailing: 10))
                
                    Text("\(Int(current.main.temp - 273.15))°C")
                        .font(.custom("Poppins-Medium", size: 64))
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 25, trailing: 0))
                        .foregroundColor(.white)
                    
                    VStack {
                        Text("\(current.weather[0].description)")
                            .font(.custom("Poppins-Regular", size: 24))
                            .foregroundColor(.white)
                            .position(x: UIScreen.main.bounds.width / 2, y: 450)
                        
                        HStack {
                            Text("Max: \(Int(current.main.tempMax - 273.15))°C")
                                .foregroundColor(.white)
                                .font(.custom("Poppins-Regular", size: 24))
                                .position(x: 100, y: 480)
                            
                            Text("Min: \(Int(current.main.tempMin - 273.15))°C")
                                .foregroundColor(.white)
                                .font(.custom("Poppins-Regular", size: 24))
                                .position(x: 100, y: 480) // Değiştirildi
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 800, trailing: 0))
                    }
                    
                    InfoView(text: $text, weatherVM: weatherVM)
                        .padding(EdgeInsets(top: 23, leading: 0, bottom: 0, trailing: 0))
                }
        }
        .onAppear {
            Task {
                await weatherVM.fetch(cityName: text)
                await weatherVM.fetchCurrent(cityName: text)
            }
        }
    }
}

#Preview {
    @Previewable @State var text = ""
    DetailView(text: $text)
}

