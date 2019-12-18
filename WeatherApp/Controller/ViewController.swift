//
//  ViewController.swift
//  WeatherApp
//
//  Created by Geovanni Fuentes on 2019-12-17.
//  Copyright © 2019 Personal. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, WeatherManagerDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var precipitationLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var uvIndexLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var visibilityLabel: UILabel!
    @IBOutlet weak var summaryBackgroundImageView: UIImageView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var infoBackgroundView: UIView!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherManager.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = manager.location {
            weatherManager.fetchTodayWeather(location.coordinate.latitude, location.coordinate.longitude)            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func didWeatherUpdated(_ weather: Weather) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = "\(String(format: "%0.0f", weather.currently.temperature))°F"
            self.cityLabel.text = weather.timezone
            self.summaryLabel.text = weather.currently.summary
            self.precipitationLabel.text = "\(weather.currently.precipIntensity)"
            self.humidityLabel.text = "\(weather.currently.humidity)"
            self.pressureLabel.text = "\(weather.currently.pressure)"
            self.uvIndexLabel.text = "\(weather.currently.uvIndex)"
            self.windSpeedLabel.text = "\(weather.currently.windSpeed)"
            self.visibilityLabel.text = "\(weather.currently.visibility)"
        }
    }
    
    @objc func OnResumeApp() {
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.requestLocation()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(OnResumeApp), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
