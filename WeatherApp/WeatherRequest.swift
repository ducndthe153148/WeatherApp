//
//  WeatherRequest.swift
//  WeatherApp
//
//  Created by Nguyễn Đình Trung Đức on 07/12/2021.
//

import Foundation
import CoreLocation
import Alamofire

var locationManager = CLLocationManager()
var currentLocation: CLLocation?
var current : CurrentWeather?

var models = [HourlyWeather]()

// ứng dụng generic, tách url và WeatherResponse ra khỏi hàm, khi cần gọi chỉ cần truyền vào là có thể chạy được

struct WeatherRequest {
    private var baseURL = ""
    // Goi dau tien
    
    enum CustomError: Error{
        case invalidURL
        case invalidData
    }
    
    
    func testFirst(_ urlAPI: String) -> [HourlyWeather]{
        AF.request(self.baseURL + urlAPI, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { (responseData) in
            print("We got the response")
            guard let data = responseData.data else {return}
            do{
                // Change weather response
                let weather = try JSONDecoder().decode(WeatherReponse.self, from: data)
                let entries = weather.hourly
                models.append(contentsOf: entries!)
                print("Weather: \(models.count)")
            } catch {
                print("Error = \(error)")
            }
        }
        return models
    }
    
    // MARK: - fetch generic data
    func testGeneric <T: Decodable> (_ urlAPI: String, completion: @escaping (T) -> ()){
        AF.request(self.baseURL + urlAPI, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response{ (responseData) in
            print("We got the generic response")
            guard let data = responseData.data else {return}
            do {
                let obj = try JSONDecoder().decode(T.self, from: data)
                completion(obj)
            } catch {
                print("Failed to decode json \(error)")
            }
            print("Run here")
        }
    }
    
    func requestWeatherForLocation(){
        guard let currentLocation = currentLocation else {
            return
        }
        let long = currentLocation.coordinate.longitude
        let lat = currentLocation.coordinate.latitude
        //print("Long: \(long) and lat: \(lat)")

        var url = "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(long)&exclude=daily&appid=78ed6b8b11e08ae58625e4a726e6d625"
        print("\(url)")
        let url1 = URL(string: url)!
        
        
        URLSession.shared.dataTask(with: url1, completionHandler: {
            data,response,error in
            // Validation
            guard let data = data, error == nil else {
                print("something went wrong")
                return
            }

            // Convert data to models/some object
            
            var json: WeatherReponse?
            do {
                
                json = try JSONDecoder().decode(WeatherReponse.self, from: data)
            }
            catch {
                print("error: \(error)")
            }

            guard let result = json else {
                return
            }
            print(result)
            //print(result.timezone)
    //            let entries = result.current?.hourly
            print("\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\")
    //            print(entries)
            // Update user interface
        }).resume()
    }
    

}
