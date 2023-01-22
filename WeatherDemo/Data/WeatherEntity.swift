//
//  WeatherEntity.swift
//  WeatherDemo
//
//  Created by Aleksandra Kustra on 21/01/2023.
//

import Foundation

struct WeatherEntity: Decodable {
    var latitude: Double?
    var longitude: Double?
    var generationtimeMs: Double?
    var utcOffsetSeconds: Int?
    var timezone: String?
    var timezoneAbbreviation: String?
    var elevation: Int?
    var currentWeather: CurrentWeather?
    var hourlyUnits: HourlyUnits?
    var hourly: Hourly?
    var dailyUnits: DailyUnits?
    var daily: Daily?
    
    struct CurrentWeather: Codable {
        var temperature: Double?
        var weathercode: Int?
        var windspeed: Double?
        var winddirection: Int?
        var time: String?
    }
    
    struct HourlyUnits: Codable {
        var time: String?
        var temperature2m: Double?
        var weathercode: Int?
    }
    
    struct Hourly: Codable {
        var time: [String]?
        var temperature2m: [Double]?
        var weathercode: [Int]?
    }
    
    struct DailyUnits: Codable {
        var time: String?
        var temperature2mMax: Double?
        var temperature2mMin: Double?
        var weathercode: Int?
    }
    
    struct Daily: Codable {
        var time: [String]?
        var temperature2mMax: [Double]?
        var temperature2mMin: [Double]?
        var weathercode: [Int]?
    }

    enum CodingKeys: String, CodingKey {
        case latitude = "latitude"
        case longitude = "longitude"
        case elevation = "elevation"
        case generationtimeMs = "generationtime_ms"
        case utcOffsetSeconds = "utc_offset_seconds"
        case timezone = "timezone"
        case timezoneAbbreviation = "timezone_abbreviation"
        case currentWeather = "current_weather"
        case hourlyUnits = "hourly_units"
        case hourly = "hourly"
        case dailyUnits = "daily_units"
        case daily = "daily"
        case temperature_2m_min = "temperature_2m_min"
        case temperature_2m_max = "temperature_2m_max"
        case temperature = "temperature"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        latitude = try values.decodeIfPresent(Double.self, forKey: .latitude)
        longitude = try values.decodeIfPresent(Double.self, forKey: .longitude)
        elevation = try values.decodeIfPresent(Int.self, forKey: .elevation)
        generationtimeMs = try values.decodeIfPresent(Double.self, forKey: .generationtimeMs)
        utcOffsetSeconds = try values.decodeIfPresent(Int.self, forKey: .utcOffsetSeconds)
        timezone = try values.decodeIfPresent(String.self, forKey: .timezone)
        timezoneAbbreviation = try values.decodeIfPresent(String.self, forKey: .timezoneAbbreviation)
        currentWeather = try values.decodeIfPresent(CurrentWeather.self, forKey: .currentWeather)
//        hourlyUnits = try values.decodeIfPresent(HourlyUnits.self, forKey: .hourlyUnits)
        hourly = try values.decodeIfPresent(Hourly.self, forKey: .hourly)
//        dailyUnits = try values.decodeIfPresent(DailyUnits.self, forKey: .dailyUnits)
        daily = try values.decodeIfPresent(Daily.self, forKey: .daily)
    }
}
