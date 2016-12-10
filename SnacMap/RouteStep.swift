//
//  RouteStep.swift
//  SnacMap
//
//  Created by Sander Rõuk on 10/12/2016.
//  Copyright © 2016 Sander Rõuk. All rights reserved.
//

import Foundation

class RouteStep: SafeJsonObject {
    var distance: RouteLegDistance?
    var end_location: Location?
    var start_location: Location?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if let dictValue = value as? [String: AnyObject] {
            if key == "distance" {
                distance = RouteLegDistance()
                distance?.setValuesForKeys(dictValue)
            } else if key == "end_location" {
                end_location = Location()
                end_location?.setValuesForKeys(dictValue)
            } else if key == "start_location" {
                start_location = Location()
                start_location?.setValuesForKeys(dictValue)
            } else {
                super.setValue(value, forKey: key)
            }
        }
    }
}
