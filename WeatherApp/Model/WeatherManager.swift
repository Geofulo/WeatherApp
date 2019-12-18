//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Geovanni Fuentes on 2019-12-18.
//  Copyright © 2019 Personal. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didWeatherUpdated(_ weather: Weather)
}

struct WeatherManager {
    let apiUrl = "https://api.darksky.net/forecast/2bb07c3bece89caf533ac9a5d23d8417/"
    var delegate: WeatherManagerDelegate?
    
    func fetchTodayWeather(_ lat: Double,_ lon: Double) {
        let urlString = "\(apiUrl)\(lat),\(lon)"
        print(urlString)
        performRequest(urlString)
    }
    
    func performRequest(_ url: String) {
        if let url = URL(string: url) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil {
                    print("Error: \(error!.localizedDescription)")
                    return
                }
                
                if let myData = data {
                    if let weather = self.parseJSON(myData) {
                        print(weather)
                        self.delegate?.didWeatherUpdated(weather)
                    }
                }
            })
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> Weather? {
        do {
            let decoder = JSONDecoder()
            let weather = try decoder.decode(Weather.self, from: data)
            return weather
        } catch {
            print(error)
        }
        return nil
    }
}
