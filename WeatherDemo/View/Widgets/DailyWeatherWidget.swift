//
//  DailyWeatherWidget.swift
//  WeatherDemo
//
//  Created by Aleksandra Kustra on 21/01/2023.
//

import SwiftUI

struct DailyWeatherWidget: View {
    var name: String
    var logo: String
    var value: String
    var style: Style
    
    var body: some View {
        VStack(spacing: 2) {
            Text(name)
                .textCase(.uppercase)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.white)
            Image(systemName: logo)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            Text(value)
                .font(.system(size: 24, weight: .medium))
                .foregroundColor(.white)
        }
        .padding()
        .background(getBgColor(style: style))
        .cornerRadius(20)
    }
    
    func getBgColor(style: Style) -> Color {
        switch style {
        case .purple:
            return Color("transparentPurple")
        case .blue:
            return .blue
            
        }
    }
}

struct DailyWeatherWidget_Previews: PreviewProvider {
    static var previews: some View {
        DailyWeatherWidget(name: "Now",
                           logo: "cloud.sun.fill",
                           value: "8",
                           style: .purple)
        .background(.black)
    }
}
