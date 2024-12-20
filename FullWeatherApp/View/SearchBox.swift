//
//  SearchBox.swift
//  FullWeatherApp
//
//  Created by Görkem Arpacı on 17.10.2024.
//

import SwiftUI

struct SearchBox: View {
    @Binding var text : String
    
    var body: some View {
        TextField("Enter Location", text: $text)
            .font(.custom("OpenSans-Bold", size: 28))
            .frame(width: 304, height: 72)
            .foregroundColor(Color(hex: "362A84"))
            .multilineTextAlignment(.center)
            .background(RoundedRectangle(cornerRadius: 50)
                .fill(Gradient(colors: [.clear, .white]).shadow(.drop(color: .white, radius: 4)).opacity(0.7)))
                

    }
}

#Preview {
    @Previewable @State var text: String = ""
    SearchBox(text: $text)
}
