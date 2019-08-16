import Foundation

struct Weather {
    var locationName:   String
    var temperature:    Double
    var imageName:      String
}

extension Weather {
    init(weatherResult: WeatherResult) {
        locationName = weatherResult.name
        temperature = weatherResult.main.temp - 273.15
        imageName = weatherResult.weather.first?.main ?? ""
    }
}
