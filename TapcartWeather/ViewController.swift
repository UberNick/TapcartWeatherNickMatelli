//
//  ViewController.swift
//  TapcartWeather
//
//  Created by Justin Hall on 1/30/19.
//  Copyright © 2019 jhall. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var forecasts: [Forecast] = Forecast.fiveDayForecast

    @IBOutlet weak var searchInput: UITextField!
    @IBOutlet weak var weatherTypeIcon: UIImageView!
    @IBOutlet weak var weatherTypeLabel: UILabel!
    @IBOutlet weak var locationName: UILabel!
    @IBOutlet weak var currentTemp: UILabel!
    @IBOutlet weak var forecastView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        searchInput.becomeFirstResponder()
        _ = [locationName, weatherTypeLabel, weatherTypeIcon, currentTemp, forecastView].map { $0?.isHidden = true }
    }

    @IBAction func doSearch(sender: Any?) {
        searchInput.resignFirstResponder()
        let searchString = searchInput.text ?? ""
        API.getWeather(self, searchString: searchString)
        API.getForecast(self, searchString: searchString)
    }
}

extension ViewController {
    func presentAlert(_ title: String) {
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
}

extension ViewController: WeatherDelegate {
    func weatherReceived(weather: Weather) {
        locationName.text = weather.locationName
        currentTemp.text = "\(weather.temperature.formatAsDegree)c"
        weatherTypeLabel.text = weather.imageName
        weatherTypeIcon.image = weatherTypeIcon.image?.image(forWeather: weather.imageName)

        _ = [locationName, weatherTypeLabel, weatherTypeIcon, currentTemp].map { $0?.isHidden = false }
    }
}

extension ViewController: ForecastDelegate {
    func forecastReceived(forecasts: [Forecast]) {
        self.forecasts = forecasts
        forecastView.isHidden = false
        forecastView.reloadData()
    }
}

extension ViewController: APIDelegate {
    func errorReceived(_ error: Any?) {
        guard let error = error else {
            presentAlert("Unknown Error")
            return
        }
        let errorString = String(describing: error)
        presentAlert(errorString)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ForecastCell", for: indexPath) as? ForecastCell else {
            return ForecastCell()
        }
        cell.configure(forecast: forecasts[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecasts.count
    }
}
