//
//  Weather.swift
//  WeatherApp
//
//  Created by Geovanni Fuentes on 2019-12-18.
//  Copyright © 2019 Personal. All rights reserved.
//

import Foundation

class Weather : Codable {
    let latitude: Double
    let longitude: Double
    let timezone: String
    let currently: WeatherInfo
}
