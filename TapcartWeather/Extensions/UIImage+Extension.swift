//
//  UIImage+Extension.swift
//  TapcartWeather
//
//  Created by Justin Hall on 1/30/19.
//  Copyright © 2019 jhall. All rights reserved.
//

import UIKit

extension UIImage {
    func image(forWeather weather: String) -> UIImage {
        return UIImage(named: weather) ?? UIImage(named: "Clear")!
    }
}


