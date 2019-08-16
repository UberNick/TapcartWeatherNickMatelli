import UIKit

class ForecastCell: UICollectionViewCell {
    @IBOutlet weak var forecastDayLabel: UILabel!
    @IBOutlet weak var forecastIcon: UIImageView!
    @IBOutlet weak var forecastMinTemp: UILabel!
    @IBOutlet weak var forecastMaxTemp: UILabel!

    func configure(forecast: Forecast) {
        forecastDayLabel.text = forecast.dayOfTheWeek
        forecastIcon.image = UIImage(named: forecast.imageName)
        forecastMinTemp.text = "\(forecast.minTemperature.formatAsDegree)c"
        forecastMaxTemp.text = "\(forecast.maxTemperature.formatAsDegree)c"
    }
}
