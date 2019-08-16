//
//  Forcecast.swift
//  TapcartWeather
//
//  Created by Justin Hall on 1/31/19.
//  Copyright © 2019 jhall. All rights reserved.
//

import Foundation

struct Forecast: Codable {
    var dayOfTheWeek:   String
    var minTemperature: Double
    var maxTemperature: Double
    var imageName:      String
}

extension Forecast {
    static let fiveDayForecast: [Forecast] = [
        Forecast(dayOfTheWeek: "Friday", minTemperature: 55.0, maxTemperature: 63.0, imageName: "Clouds"),
        Forecast(dayOfTheWeek: "Saturday", minTemperature: 53.0, maxTemperature: 67.0, imageName: "Drizzle"),
        Forecast(dayOfTheWeek: "Sunday", minTemperature: 55.0, maxTemperature: 63.0, imageName: "Drizzle"),
        Forecast(dayOfTheWeek: "Monday", minTemperature: 64.0, maxTemperature: 70.0, imageName: "Sunny"),
        Forecast(dayOfTheWeek: "Tuesday", minTemperature: 59.0, maxTemperature: 68.0, imageName: "Rain")
    ]
}
