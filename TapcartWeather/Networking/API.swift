//
//  API.swift
//  TapcartWeather
//
//  Created by Justin Hall on 1/30/19.
//  Copyright © 2019 jhall. All rights reserved.
//

import Foundation

protocol APIDelegate {
    func errorReceived(_ error: Any?)
}

protocol WeatherDelegate: APIDelegate {
    func weatherReceived(weather: WeatherResult)
}

protocol ForecastDelegate: APIDelegate {
    func forecastReceived(forecasts: [Forecast])
}

struct API {
    static let base = "https://api.openweathermap.org/data/2.5/"
    static let key  = "bce770eb36db43822638d40e9733ffe3"
    static let imperical = "&units=Imperial"

    static func getWeather(_ delegate: WeatherDelegate, searchString: String) {
        let url = getUrl(delegate, path: "weather", query: searchString)
        executeCall(delegate, url: url) { data in
            guard let weatherResult = try? JSONDecoder().decode(WeatherResult.self, from: data) else { return }
            delegate.weatherReceived(weather: weatherResult)
        }
    }

    static func getForecast(_ delegate: ForecastDelegate, searchString: String) {
        let url = getUrl(delegate, path: "forecast", query: searchString)
        executeCall(delegate, url: url) { data in
            guard let forecasts = try? JSONDecoder().decode([Forecast].self, from: data) else {
                delegate.forecastReceived(forecasts: []) //TODO remove once Forecast encoding is working
                return
            }
            delegate.forecastReceived(forecasts: forecasts)
        }
    }

    //MARK: - Helpers
    private static func getUrl(_ delegate: APIDelegate, path: String, query: String) -> URL? {
        let baseURL = URL(string: base)
        guard let pathURL = baseURL?.appendingPathComponent(path),
            var urlComponents = URLComponents(url: pathURL, resolvingAgainstBaseURL: true) else {
                delegate.errorReceived("Bad Base URL")
                return nil
        }
        urlComponents.queryItems = [
            URLQueryItem(name: "APPID", value: key),
            URLQueryItem(name: "q", value: query)]
        return urlComponents.url
    }

    private static func executeCall(_ delegate: APIDelegate, url: URL?, callBack: @escaping (_ data: Data) -> Void) {
        guard let url = url else {
            delegate.errorReceived("Bad Endpoint URL")
            return
        }
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data else {
                    delegate.errorReceived(error)
                    return
                }
                callBack(data)
            }
        }
        task.resume()
    }
}
