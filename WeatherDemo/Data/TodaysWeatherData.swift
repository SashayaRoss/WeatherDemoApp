//
//  TodaysWeatherData.swift
//  WeatherDemo
//
//  Created by Aleksandra Kustra on 22/01/2023.
//

struct TodaysWeatherData {
    let status: WeatherStatus
    let temperature: String
    let wind: String
    let minTemperature: String
    let maxTemperature: String
}

struct WeatherStatus {
    let logo: String
    let value: String
}
