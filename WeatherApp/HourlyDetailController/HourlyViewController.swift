//
//  HourlyViewController.swift
//  WeatherApp
//
//  Created by Nguyễn Đình Trung Đức on 09/12/2021.
//

import UIKit

class HourlyViewController: UIViewController {

    @IBOutlet weak var labelTest: UILabel!
    @IBOutlet weak var weatherDescrip: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var tempFeel: UILabel!
    
    @IBOutlet weak var pressure: UILabel!
    @IBOutlet weak var clouds: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var uvi: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var visibility: UILabel!
    @IBOutlet weak var pop: UILabel!
    @IBOutlet weak var rainRate: UILabel!
    
    var text: String? = nil
    var models : HourlyWeather?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        changeTextLabel()
    }
    
    typealias completionHandler = (String) -> Void
    var completion: completionHandler?
    
    func changeTextLabel() {
        //labelTest.text = "ABC XYZ"
        if text != nil {
            labelTest.text = text
        }
        // Đã pass duoc data sang
        weatherDescrip.text = models?.weather![0].description
        tempLabel.text = "\(Int(((models?.temp)!) - 272.15))°"
        tempFeel.text = "F: \(Int(((models?.feels_like)!) - 272.15))°"
        pressure.text = "Pressure: \((models?.pressure)!)"
        clouds.text = "Cloudiness: \((models?.clouds)!)%"
        humidity.text = "Humidity: \((models?.humidity)!)%"
        
        uvi.text = "Current UV: 0"
        var def: String = "Cur"
        windSpeed.text = "Wind speed: \((models?.wind_speed)!)"
        visibility.text = "Visibility: \((models?.visibility)!) m"
        pop.text = "Precipitation: \((models?.pop)!)"
//        rainRate.text = "Precipitation volume: \(models?.rain) mm"
        rainRate.text = "Rain rate: 20%"
    }

}
