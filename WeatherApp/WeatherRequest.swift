//
//  WeatherRequest.swift
//  WeatherApp
//
//  Created by Nguyễn Đình Trung Đức on 07/12/2021.
//

import Foundation
import CoreLocation

var locationManager = CLLocationManager()
var currentLocation: CLLocation?
var current : CurrentWeather?

var models : DailyWeather?

struct WeatherRequest {
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
