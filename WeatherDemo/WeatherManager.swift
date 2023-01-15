//
//  WeatherManager.swift
//  WeatherDemo
//
//  Created by Aleksandra Kustra on 15/01/2023.
//

import Foundation
import CoreLocation

final class WeatherManager {
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ResponseBody {
        guard let url = URL(string: "https://api.open-meteo.com/v1/forecast?latitude=\(latitude)&longitude=\(longitude)") else {
            fatalError("Missing url")
        }
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Error fetching weather data")
        }
        
        let decodedData = try JSONDecoder().decode(ResponseBody.self, from: data)
        
        return decodedData
    }
}
struct ResponseBody: Decodable {
    var latitude: Double?
    var longitude: Double?
    var elevation: Double?
    var generationtimeMs: Double?
    var utcOffsetSeconds: Int?
    var timezone: String?
    var timezoneAbbreviation: String?
    var currentWeather: CurrentWeather?
    
    struct CurrentWeather: Codable {
      var time: String?
      var temperature: Double?
      var weathercode: Int?
      var windspeed: Double?
      var winddirection: Int?
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
    }

    init(from decoder: Decoder) throws {
      let values = try decoder.container(keyedBy: CodingKeys.self)

      latitude = try values.decodeIfPresent(Double.self, forKey: .latitude)
      longitude = try values.decodeIfPresent(Double.self, forKey: .longitude)
      elevation = try values.decodeIfPresent(Double.self, forKey: .elevation)
      generationtimeMs = try values.decodeIfPresent(Double.self, forKey: .generationtimeMs)
      utcOffsetSeconds = try values.decodeIfPresent(Int.self, forKey: .utcOffsetSeconds)
      timezone = try values.decodeIfPresent(String.self, forKey: .timezone)
      timezoneAbbreviation = try values.decodeIfPresent(String.self, forKey: .timezoneAbbreviation)
      currentWeather = try values.decodeIfPresent(CurrentWeather.self, forKey: .currentWeather)
    }
}
