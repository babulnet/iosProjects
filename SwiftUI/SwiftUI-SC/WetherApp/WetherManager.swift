//
//  WetherManager.swift
//  SwiftUI-SC
//
//  Created by Babul Raj on 03/04/22.
//

import Foundation
import CoreLocation

class WetherManager {
    func getWeather(lat: CLLocationDegrees, long: CLLocationDegrees) async throws -> ResponseBody {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(long)&appid=ddfeeb3c161badf20986cbd8475b9404") else {fatalError("URL is not correct")}
        let request = URLRequest(url: url)
        let session = URLSession.shared
        let (data,response) = try await session.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {fatalError("error fetching wether data")}
        
        
        let result =  try JSONDecoder().decode(ResponseBody.self, from: data)
        return result
    }
}

struct ResponseBody: Decodable {
    var coord: CoordinatesResponse
    var weather: [WeatherResponse]
    var main: MainResponse
    var name: String
    var wind: WindResponse

    struct CoordinatesResponse: Decodable {
        var lon: Double
        var lat: Double
    }

    struct WeatherResponse: Decodable {
        var id: Double
        var main: String
        var description: String
        var icon: String
    }

    struct MainResponse: Decodable {
        var temp: Double
        var feels_like: Double
        var temp_min: Double
        var temp_max: Double
        var pressure: Double
        var humidity: Double
    }
    
    struct WindResponse: Decodable {
        var speed: Double
        var deg: Double
    }
}
