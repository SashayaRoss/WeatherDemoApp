//
//  ImageTextWidget.swift
//  WeatherDemo
//
//  Created by Aleksandra Kustra on 21/01/2023.
//

import SwiftUI

struct ImageTextWidget: View {
    var logo: String
    var value: String
    
    var body: some View {
        HStack {
            Image(systemName: logo)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20)
                .foregroundColor(.white)
            Text(value)
                .bold()
                .font(.subheadline)
                .padding(.leading, -4)
                .foregroundColor(.white)
        }
    }
}

struct MainDetailsRow_Previews: PreviewProvider {
    static var previews: some View {
        ImageTextWidget(logo: "sun.max", value: "13°")
            .background(.black)
    }
}
