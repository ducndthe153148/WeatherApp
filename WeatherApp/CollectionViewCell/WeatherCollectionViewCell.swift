//
//  WeatherCollectionViewCell.swift
//  WeatherApp
//
//  Created by Nguyễn Đình Trung Đức on 08/12/2021.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {

    static let identifier = "WeatherCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "WeatherCollectionViewCell", bundle: nil)
    }
    
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    
    func configure(with model: HourlyWeather){
        self.tempLabel.text = "\(Int((model.temp!) - 272.15))°"
        self.iconImageView.contentMode = .scaleAspectFit
        self.iconImageView.image = UIImage(named: model.weather![0].icon!)
        
        let date = NSDate(timeIntervalSince1970: model.dt!)
        // get hour now (so sanh voi time chinh)
        let dateNow = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: dateNow)
        
        self.timeLabel.text = "\(getHourForDate(date as Date))"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func changeTimeUnix (_ time: Float) -> Int {
        
        return 10
    }
    
    func getHourForDate(_ date : Date?) -> String {
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "hh"
        let dateString = dayTimePeriodFormatter.string(from: date! as Date)
        return dateString
    }

}
