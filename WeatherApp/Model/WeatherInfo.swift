//
//  WeatherInfo.swift
//  WeatherApp
//
//  Created by Geovanni Fuentes on 2019-12-18.
//  Copyright © 2019 Personal. All rights reserved.
//

import Foundation

class WeatherInfo: Codable {
    let time: Int64
    let summary: String
    let icon: String
    let precipIntensity: Float
    let precipProbability: Float
    let temperature: Float
    let apparentTemperature: Float
    let humidity: Float
    let pressure: Float
    let windSpeed: Float
    let cloudCover: Float
    let uvIndex: Int
    let visibility: Float
}
