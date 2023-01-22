//
//  DailyWeatherMapper.swift
//  WeatherDemo
//
//  Created by Aleksandra Kustra on 22/01/2023.
//

import Foundation

final class DailyWeatherMapper {
    let weatherEntity: WeatherEntity
    
    init(weatherEntity: WeatherEntity) {
        self.weatherEntity = weatherEntity
    }
    
    func getTodaysWeather() -> TodaysWeatherData {
        let weather = TodaysWeatherData(
            status: getWeatherStatus(from: weatherEntity.currentWeather?.weathercode),
            temperature: weatherEntity.currentWeather?.temperature?.roundDouble() ?? "Unknown",
            wind: weatherEntity.currentWeather?.windspeed?.roundDouble() ?? "Unknown",
            minTemperature: "Unknown",
            maxTemperature: "Unknown")
        return weather
    }
    
    func getWeeklyWeather() -> [DailyWeatherData] {
        var dailyWeather: [DailyWeatherData] = []
        guard
            let data = weatherEntity.daily,
            let weatherCode = data.weathercode,
            let minTempArray = data.temperature2mMin,
            let maxTempArray = data.temperature2mMin
        else {
            return []
        }
        guard weatherCode.count == minTempArray.count, weatherCode.count == maxTempArray.count else {
            return []
        }
        var i = 0
        for weather in weatherCode {
            let test = DailyWeatherData(name: getNextDay(value: i), logo: getWeatherStatus(from: weather).logo, value: getAverageTemp(maxTemp: maxTempArray[i], minTemp: minTempArray[i]))
            dailyWeather.append(test)
            
            i += 1
        }
        return dailyWeather
    }
    
    private func getAverageTemp(maxTemp: Double, minTemp: Double) -> String {
        (maxTemp + maxTemp / 2).roundDouble().temp()
    }
    
    private func getWeatherStatus(from code: Int?, fill: Bool = true) -> WeatherStatus {
        let iconSufix = (fill == true) ? ".fill" : ""
        switch code {
        case 0: // "Clear sky"
            return WeatherStatus(logo: "sun.max" + iconSufix, value: "Sunny")
        case 1, 2, 3: // "Mainly clear, partly cloudy, and overcast"
            return WeatherStatus(logo: "cloud.sun" + iconSufix, value: "Partly cloudy")
        case 45, 48: // Fog and depositing rime fog
            return WeatherStatus(logo: "cloud.fog" + iconSufix, value: "Fog")
        case 51, 53, 55: // "Drizzle: Light, moderate, and dense intensity"
            return WeatherStatus(logo: "cloud.drizzle" + iconSufix, value: "Drizzle")
        case 56, 57: // "Freezing Drizzle: Light and dense intensity"
            return WeatherStatus(logo: "cloud.hail" + iconSufix, value: "Freezing Drizzle")
        case 61, 63, 77: // "Rain: Slight, moderate intensity or slight, moderate, and violent"
            return WeatherStatus(logo: "cloud.rain" + iconSufix, value: "Rain")
        case 65: // "Rain: Heavy intensity"
            return WeatherStatus(logo: "cloud.heavyrain" + iconSufix, value: "Heavy rain")
        case 66, 67: // "Freezing Rain: Light and heavy intensity"
            return WeatherStatus(logo: "cloud.hail" + iconSufix, value: "Freezing Rain")
        case 71, 73, 75, 85, 86: // "Snow fall: Slight, moderate, and heavy intensity or slight and heavy"
            return WeatherStatus(logo: "cloud.snow" + iconSufix, value: "Snow")
        case 80, 81, 82: // "Snow grains"
            return WeatherStatus(logo: "cloud.hail" + iconSufix, value: "Snow grains")
        case 95: // "Thunderstorm: Slight or moderate"
            return WeatherStatus(logo: "cloud.bolt" + iconSufix, value: "Thunderstorm")
        case 96, 99: // "Thunderstorm with slight and heavy hail"
            return WeatherStatus(logo: "cloud.bolt.rain" + iconSufix, value: "Heavy thunderstorm")
        default:
            return WeatherStatus(logo: "questionmark.app", value: "Unknown status")
        }
    }
    
    private func getNextDay(value: Int) -> String {
        if value == 0 {
            return "NOW"
        }
        
        let today = Date()
        return Calendar.current.date(
            byAdding: .day,
            value: value,
            to: today)?.formatted(.dateTime.weekday(.short)) ?? ""
    }
}
