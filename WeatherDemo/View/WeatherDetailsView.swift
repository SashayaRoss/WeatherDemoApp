//
//  WeatherDetailsView.swift
//  WeatherDemo
//
//  Created by Aleksandra Kustra on 21/01/2023.
//

import SwiftUI

struct WeatherDetailsView: View {
    var weather: WeatherEntity
    let style: Style = .purple
    
    var body: some View {
        let weatherData = DailyWeatherMapper(weatherEntity: weather)
        let todaysData = weatherData.getTodaysWeather()
        
        ZStack {
            getBackgroundFor(style)
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: -15) {
                        ImageTextWidget(
                            logo: todaysData.status.logo,
                            value: todaysData.status.value)
                        BigHeaderWidget(header: todaysData.temperature)
                    }

                    VStack(alignment: .leading) {
                        ImageTextWidget(
                            logo: "location",
                            value: "Bydgoszcz")
                        ImageTextWidget(
                            logo: "wind",
                            value: todaysData.wind)
                        ImageTextWidget(
                            logo: "thermometer.snowflake", 
                            value: todaysData.minTemperature)
                        ImageTextWidget(
                            logo: "thermometer.sun",
                            value: todaysData.maxTemperature)
                    }
                }.padding()

                Spacer()
                
                // MARK: Bottom
                VStack {
                    VStack(spacing: 20) {
                        HStack {
                            // TODO: 
//                            ButtonWidget(text: "Today",
//                                         handler: { print("today")})
                            Spacer()
                            ButtonWidget(text: "7 days",
                                         handler: { print("7 days")})
                        }
                        .padding(.bottom, -14)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                let weekData = weatherData.getWeeklyWeather()
                                ForEach(0 ..< weekData.count) { value in
                                    DailyWeatherWidget(name: weekData[value].name,
                                                       logo: weekData[value].logo,
                                                       value: weekData[value].value,
                                                       style: style)
                                }
                            }
                        }
                    }
                    .padding()
                    .padding(.bottom, 20)
                    .background(.black.opacity(0.5))
                    .cornerRadius(20, corners: [.topLeft, .topRight])
                }
            }.ignoresSafeArea(edges: .bottom)
        }
    }
}

func getBackgroundFor(_ style: Style) -> some View {
    switch style {
    case .purple:
        return LinearGradient(gradient: Gradient(colors: [.purple, Color("darkPurple")]),
                              startPoint: .top,
                              endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
    case .blue:
        return LinearGradient(gradient: Gradient(colors: [.blue, .white]),
                              startPoint: .top,
                              endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
    }
}

struct WeatherDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDetailsView(weather: previewWeather)
    }
}
