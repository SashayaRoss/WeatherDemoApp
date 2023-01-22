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
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> WeatherEntity {
        guard let url = URL(string: "https://api.open-meteo.com/v1/forecast?latitude=\(latitude)&longitude=\(longitude)&current_weather=true&timezone=GMT&daily=temperature_2m_max,temperature_2m_min,weathercode&hourly=temperature_2m,weathercode") else {
            fatalError("Missing url")
        }
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Error fetching weather data")
        }
        
        let decodedData = try JSONDecoder().decode(WeatherEntity.self, from: data)
        
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
