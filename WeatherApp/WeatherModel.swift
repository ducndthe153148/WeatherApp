//
//  Weather.swift
//  WeatherApp
//
//  Created by Nguyễn Đình Trung Đức on 07/12/2021.
//

import Foundation

struct WeatherReponse : Codable {
    let lat: Float
    let lon: Float
    let timezone: String
    let timezone_offset: Float
    let current: CurrentWeather? // using
    let minutely: [MinuteWeather]?
    let hourly: [HourlyWeather]? // using
    let daily: [DailyWeather]? // nil
}

struct CurrentWeather : Codable{
    let dt: Double?
    let sunrise: Double?
    let sunset: Double?
    let temp: Float?
    let feels_like: Float?
    let pressure: Float?
    let humidity: Int?
    let dew_point: Float?
    let uvi: Float?
    let clouds: Int?
    let visibility: Double?
    let wind_speed: Float?
    let wind_deg: Float?
    let wind_gust: Float?
    let weather: [WeatherInfo]?
}

struct WeatherInfo : Codable {
    let id: Int?
    let main: String?
    let description: String?
    let icon: String?
}

struct MinuteWeather : Codable {
    let dt: Double?
    let precipitation: Float?
}

struct RainWeather: Codable {
    let _1h: Float?
    private enum CodingKeys : String, CodingKey {
            case _1h = "1h"
        }
}

struct HourlyWeather: Codable {
    let dt: Double?
    let temp: Float?
    let feels_like: Float?
    let pressure: Float?
    let humidity: Int?
    let dew_point: Float?
    let uiv: Float?
    let clouds: Int?
    let visibility: Int?
    let wind_speed: Float?
    let wind_deg: Float?
    let wind_gust: Float?
    let weather: [WeatherInfo]?
    let pop: Float?
    let rain: RainWeather?
}

struct DailyWeather: Codable{
    let dt: Double?
    let sunrise: Double?
    let sunset: Double?
    let moonrise: Double?
    let moonset: Double?
    let moon_phase: Float?
    let temp: TempWeather?
    let feels_like: FeelWeather?
    let pressure: Float?
    let humidity: Float?
    let dew_point: Float?
    let wind_speed: Float?
    let wind_deg: Float?
    let weather: [WeatherInfo]?
    let clouds: Int?
    let pop: Float?
    let rain: Float?
    let uvi: Float?
}

struct TempWeather: Codable {
    let day: Float?
    let min: Float?
    let max: Float?
    let night: Float?
    let eve: Float?
    let morn: Float?
}

struct FeelWeather: Codable{
    let day: Float?
    let night: Float?
    let eve: Float?
    let morn: Float?
}
struct AlertWeather: Codable {
    let sender_name: String?
    let event: String?
    let start: Double?
    let end: Double?
    let description: String?
    let tags: [String]?
}
