//
//  WeatherDetailsView.swift
//  WeatherDemo
//
//  Created by Aleksandra Kustra on 21/01/2023.
//

import SwiftUI

struct WeatherDetailsView: View {
    var body: some View {
        ZStack {
            getBackgroundFor(.purple)
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: -15) {
                        ImageTextWidget(
                            logo: "sun.max",
                            value: "Sunny")
                        BigHeaderWidget(header: "17°")
                    }

                    VStack(alignment: .leading) {
                        ImageTextWidget(
                            logo: "location",
                            value: "Bydgoszcz")
                        ImageTextWidget(
                            logo: "wind",
                            value: "13 mph")
                        ImageTextWidget(
                            logo: "thermometer.snowflake", 
                            value: "10°")
                        ImageTextWidget(
                            logo: "thermometer.sun",
                            value: "16°")
                    }
                }.padding()

                Spacer()
                
                // MARK: Bottom
                VStack {
                    VStack(spacing: 20) {
                        HStack {
                            ButtonWidget(text: "Today",
                                         handler: { print("today")})
                            Spacer()
                            ButtonWidget(text: "7 days",
                                         handler: { print("7 days")})
                        }
                        HStack(spacing: 20) {
                            DailyWeatherWidget(name: "TUE",
                                               logo: "sun.max.fill",
                                               value: "35")
                            DailyWeatherWidget(name: "WED",
                                               logo: "cloud.sun.fill",
                                               value: "17")
                            DailyWeatherWidget(name: "SAT",
                                               logo: "wind.snow",
                                               value: "24")
                            DailyWeatherWidget(name: "SUn",
                                               logo: "wind.snow",
                                               value: "24")
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

enum Style {
    case purple
}

func getBackgroundFor(_ style: Style) -> some View {
    return LinearGradient(gradient: Gradient(colors: [.purple, Color("darkPurple")]),
                          startPoint: .top,
                          endPoint: .bottomTrailing)
        .edgesIgnoringSafeArea(.all)
}

struct WeatherDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDetailsView()
    }
}
