//
//  WeatherService.swift
//  WeatherDemo
//
//  Created by Aleksandra Kustra on 15/01/2023.
//

import Foundation
import CoreLocation

enum Error: Swift.Error {
    case invalidUrl
    case errorFetchingData
}

//https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&current_weather=true&timezone=GMT&daily=temperature_2m_max,temperature_2m_min,weathercode

final class WeatherService {
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ResponseBody {
        guard let url = URL(string: "https://api.open-meteo.com/v1/forecast?latitude=\(latitude)&longitude=\(longitude)&current_weather=true&timezone=GMT&daily=temperature_2m_max,temperature_2m_min,weathercode") else {
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
    
//    func requestWeatherData(latitude: CLLocationDegrees, longitude: CLLocationDegrees, completion: @escaping (Result<Data, Swift.Error>) -> Void) {
//        guard let url = URL(string: "https://api.open-meteo.com/v1/forecast?latitude=\(latitude)&longitude=\(longitude)&current_weather=true") else {
//            completion(.failure(Error.invalidUrl))
//            return
//        }
//        let urlRequest = URLRequest(url: url)
//
//        session.dataTask(with: request) { data, response, error in
//            DispatchQueue.main.async {
//                if let error = error {
//                    completion(.failure(Error.invalidData(error: error)))
//                    return
//                }
//
//                guard
//                    let response = response as? HTTPURLResponse,
//                    (200...299).contains(response.statusCode)
//                else {
//                    completion(.failure(Error.invalidResponse))
//                    return
//                }
//
//                guard let data = data else {
//                    completion(.failure(Error.emptyResponse))
//                    return
//                }
//
//                completion(.success(data))
//            }
//        }.resume()
//    }
}

//enum WeatherCode: String {
//    case 0 = "Clear sky"
//    case 1, 2, 3 = "Mainly clear, partly cloudy, and overcast"
//    case 45, 48 = "Fog and depositing rime fog"
//    case 51, 53, 55 = "Drizzle: Light, moderate, and dense intensity"
//    case 56, 57 = "Freezing Drizzle: Light and dense intensity"
//    case 61, 63, 65 = "Rain: Slight, moderate and heavy intensity"
//    case 66, 67 = "Freezing Rain: Light and heavy intensity"
//    case 71, 73, 75 = "Snow fall: Slight, moderate, and heavy intensity"
//    case 77 = "Snow grains"
//    case 80, 81, 82 = "Rain showers: Slight, moderate, and violent"
//    case 85, 86 = "Snow showers slight and heavy"
//    case 95 = "Thunderstorm: Slight or moderate"
//    case 96, 99 = "Thunderstorm with slight and heavy hail"
//    default = "Unknown"
//}

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
