//
//  FinalView.swift
//  FullWeatherApp
//
//  Created by Görkem Arpacı on 7.10.2024.
//

import SwiftUI

struct FinalView: View {
    @Binding var text : String
    @Namespace private var animation

    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Gradient(colors: [Color(hex: "#5090eb"), .blue]))
                .ignoresSafeArea()
            
            VStack{
                    Image("02d")
                        .resizable()
                        .scaledToFit()
                        .clipShape(Rectangle()) // Görseli görünür içeriğe sınırlandırır
                        .frame(width: 450, height: 450)
                        .position(x:UIScreen.main.bounds.width / 2, y:UIScreen.main.bounds.height / 4)
                
                VStack{
                    Text("Weather")
                        .font(.custom(String("Poppins-Bold"), size: 64))
                        .foregroundStyle(.white)
                    Text("ForeCasts")
                        .font(.custom(String("Poppins-Medium"), size: 64))
                        .foregroundColor(Color(hex: "#DDB130"))
                    
                    SearchBox(text: $text)
                        .matchedGeometryEffect(id: "searchbox", in: animation)
                }
                
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 0))

            }
        
    }
}


extension Color {
    init(hex: String){
        var cleanHexCode = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        cleanHexCode = cleanHexCode.replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0
        
        Scanner(string: cleanHexCode).scanHexInt64(&rgb)
        
        let redValue = Double((rgb >> 16) & 0xFF) / 255.0
        let greenValue = Double((rgb >> 8) & 0xFF) / 255.0
        let blueValue = Double(rgb & 0xFF) / 255.0
        
        self.init(red: redValue, green: greenValue, blue: blueValue)
    }
}



#Preview {
    @Previewable @State var text = ""
    FinalView(text: $text)
}
