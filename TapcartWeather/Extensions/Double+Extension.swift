//
//  Double+Extension.swift
//  TapcartWeather
//
//  Created by Justin Hall on 1/31/19.
//  Copyright © 2019 jhall. All rights reserved.
//

import Foundation

extension Double {
    var formatAsDegree: String {
        return String(format: "%.0f°", self)
    }
}

