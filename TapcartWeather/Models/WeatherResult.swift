import Foundation

struct WeatherResult: Codable {
    var weather: [WeatherType]
    var name: String
    var main: WeatherMain
}

struct WeatherType: Codable {
    var main: String
}

struct WeatherMain: Codable {
    var temp: Double
    var tempMin: Double
    var tempMax: Double
}
