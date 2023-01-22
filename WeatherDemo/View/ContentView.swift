//
//  ContentView.swift
//  WeatherDemo
//
//  Created by Aleksandra Kustra on 15/01/2023.
//

import SwiftUI
import CoreLocation //remove

struct ContentView: View {
    @StateObject var locationManager = LocatonManager()
    var weatherManager = WeatherService()
    @State var weather: WeatherEntity?
    
    var body: some View {
        VStack {
            if let weather = weather {
                WeatherDetailsView(weather: weather)
            } else {
            let location = CLLocationCoordinate2D(latitude: CLLocationDegrees(44.6), longitude: CLLocationDegrees(12.3))
                
            LoaderWidget()
                .task {
                    do {
                        weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                    } catch {
                        print("Error getting weather: \(error)")
                    }
                }
            }
        }
        .background(.blue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
