struct ForecastResult: Codable {
    let list: [ForecastDayResult]

    struct ForecastDayResult: Codable {
        var weather: [WeatherType]
        var main: WeatherMain
        var dtTxt: String
    }
}

extension ForecastResult {
    func groupedByDay() -> [String: [ForecastDayResult]] {
        var dayList = [String: [ForecastDayResult]]()
        list.forEach {
            let dateTime = $0.dtTxt
            let day = String(dateTime[dateTime.startIndex..<dateTime.index(dateTime.startIndex, offsetBy: 10)])
            if dayList[day] == nil {
                dayList[day] = [ForecastDayResult]()
            }
            dayList[day]?.append($0)
        }
        return dayList
    }

    static func rollUpDays(_ days: [ForecastDayResult]) -> ForecastDayResult? {
        guard var firstDay = days.first else {
            return nil
        }
        var tempMin = firstDay.main.tempMin
        var tempMax = firstDay.main.tempMax
        days.forEach {
            tempMin = min(tempMin, $0.main.tempMin)
            tempMax = max(tempMax, $0.main.tempMax)
        }
        firstDay.main.tempMin = tempMin - 273.15
        firstDay.main.tempMax = tempMax - 273.15
        firstDay.dtTxt = String(firstDay.dtTxt.dropLast(firstDay.dtTxt.count - 10))
        return firstDay
    }
}
