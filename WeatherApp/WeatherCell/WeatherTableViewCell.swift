//
//  WeatherTableViewCell.swift
//  WeatherApp
//
//  Created by MacOS on 07/12/2021.
//

import UIKit

protocol WeatherTableViewCellDelegate: AnyObject {
    func didSelectRow (data: HourlyWeather)
}

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet var hourLabel: UILabel!
    @IBOutlet var realTempLabel: UILabel!
    @IBOutlet var feelTempLabel: UILabel!
    @IBOutlet var iconImageView: UIImageView!
    
    weak var delegate: WeatherTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static let identifier = "WeatherTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "WeatherTableViewCell", bundle: nil)
    }
    
    // configure the cel
    func configure (with model: HourlyWeather){
        self.realTempLabel.textAlignment = .center
        self.feelTempLabel.textAlignment = .center
        
        // Force unwrap, khi toi uu phai sua
        self.realTempLabel.text = "\(Int(Double(model.temp!) - 272.15))°"
        self.feelTempLabel.text = "\(Int(Double(model.feels_like!) - 272.15))°"
        let date = NSDate(timeIntervalSince1970: model.dt!)
        // get day and hour from unix time (dt)
        self.hourLabel.text = getDayForDate(date as Date)
        
        self.iconImageView.contentMode = .scaleAspectFit
        let icon = model.weather?[0].icon
        self.iconImageView.image = UIImage(named: icon!)
    }
    
    func getDayForDate(_ date : Date?) -> String {
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "EEEE hh:mm"
        let dateString = dayTimePeriodFormatter.string(from: date! as Date)
        return dateString
    }
    
}
