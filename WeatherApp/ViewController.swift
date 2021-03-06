//
//  ViewController.swift
//  WeatherApp
//
//  Created by Nguyễn Đình Trung Đức on 07/12/2021.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    

    @IBOutlet weak var table: UITableView!
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var current : CurrentWeather?
    var loctionText: String?
    
    var models = [HourlyWeather]()
    var hourlyModels = [HourlyWeather]()
    var weatherRequest = WeatherRequest()
    
    let baseURL = "https://api.openweathermap.org/data/2.5/onecall?lat=35.7020691&lon=139.7753269&appid=78ed6b8b11e08ae58625e4a726e6d625"
    let apiKey = "&appid=78ed6b8b11e08ae58625e4a726e6d625"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Register 2 cells after create 2 table view cell
        table.register(HourlyTableViewCell.nib(), forCellReuseIdentifier: HourlyTableViewCell.identifier)
        table.register(WeatherTableViewCell.nib(), forCellReuseIdentifier: WeatherTableViewCell.identifier)
        table.delegate = self
        table.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupLocation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.table.reloadData()
    }
    
    // Location
    func setupLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty, currentLocation == nil  {
            currentLocation = locations.first
            locationManager.stopUpdatingLocation()
            requestWeatherForLocation()
        }
    }
    
    func requestWeatherForLocation(){
        print("Start request weather")
        
        guard let currentLocation = currentLocation else {
            return
        }
        
        let long = currentLocation.coordinate.longitude
        let lat = currentLocation.coordinate.latitude
        
        let stringURL = "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(long)&appid=78ed6b8b11e08ae58625e4a726e6d625"

        weatherRequest.testGeneric(stringURL) { [self] (weatherResponse: WeatherReponse) in
            let entries = weatherResponse.hourly
            models.append(contentsOf: entries!)
            print("Models in request: \(models.count)")
            
            self.hourlyModels = weatherResponse.hourly!
            
            let current = weatherResponse.current
            self.current = current
            // Update user interface
            DispatchQueue.main.async {
                self.table.reloadData()
                self.table.tableHeaderView = self.createTableHeader()
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            // 1 cell that is collectiontableviewcell
            return 1
        }
        // return models count
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: HourlyTableViewCell.identifier, for: indexPath) as! HourlyTableViewCell
            cell.configure(with: hourlyModels)
            cell.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)
            return cell
        }
        
        // Continue
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as! WeatherTableViewCell
        //print(models.isEmpty)
        print(indexPath.row)
            cell.configure(with: models[indexPath.row])
            cell.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)
            return cell
        //print("Di vao day truoc")
    }
    
    func createTableHeader() -> UIView {
        let headerVIew = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width))
        
        headerVIew.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)

        let locationLabel = UILabel(frame: CGRect(x: 10, y: 10, width: view.frame.size.width-20, height: headerVIew.frame.size.height/5))
        let summaryLabel = UILabel(frame: CGRect(x: 10, y: 20+locationLabel.frame.size.height, width: view.frame.size.width-20, height: headerVIew.frame.size.height/5))
        let tempLabel = UILabel(frame: CGRect(x: 10, y: 20+locationLabel.frame.size.height+summaryLabel.frame.size.height, width: view.frame.size.width-20, height: headerVIew.frame.size.height/2))
        headerVIew.addSubview(locationLabel)
        headerVIew.addSubview(tempLabel)
        headerVIew.addSubview(summaryLabel)

        tempLabel.textAlignment = .center
        locationLabel.textAlignment = .center
        summaryLabel.textAlignment = .center

        // get current location in using CLLocation
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(currentLocation!) { (placemarks, error) in
                if (error != nil){
                    print("error in reverseGeocode")
                }
                let placemark = placemarks! as [CLPlacemark]
                if placemark.count>0{
                    let placemark = placemarks![0]
                    print(placemark.locality!)
                    print(placemark.administrativeArea!)
                    print(placemark.country!)
                    self.loctionText =  "\(placemark.administrativeArea!), \(placemark.country!)"
                    locationLabel.text = "\(placemark.locality!), \(placemark.administrativeArea!), \(placemark.country!)"
                    
                }
            }

        
        guard let currentWeather = self.current else {
            return UIView()
        }

        tempLabel.text = "\(Int((currentWeather.temp!) - 272.15))°"
        tempLabel.font = UIFont(name: "Helvetica-Bold", size: 32)
        summaryLabel.text = self.current?.weather?[0].main
        
        return headerVIew
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    

    // navigate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "HourlyDetailViewController", bundle: nil)
        
        // pass by reference
        let controller = storyboard.instantiateViewController(withIdentifier: "SecondVC") as! HourlyViewController
        controller.text = loctionText
        controller.models = models[indexPath.row]
//        print("Index selected cell: \(String(describing: models[indexPath.row].temp))")
        //self.present(controller, animated: true, completion: nil)
        self.navigationController?.pushViewController(controller, animated: true)
    }

}


