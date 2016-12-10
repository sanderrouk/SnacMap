//
//  Route.swift
//  SnacMap
//
//  Created by Sander Rõuk on 10/12/2016.
//  Copyright © 2016 Sander Rõuk. All rights reserved.
//

import Foundation

class Route: SafeJsonObject {
    var bounds: RouteBounds?
    var legs: [RouteLeg]?
    var overview_polyline: OverviewPolyline?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if let dictValue = value as? [[String: AnyObject]] {
            if key == "legs" {
                legs = [RouteLeg]()
                for leg in dictValue {
                    let routeLeg = RouteLeg()
                    routeLeg.setValuesForKeys(leg)
                    legs?.append(routeLeg)
                }
            } else {
                super.setValue(value, forKey: key)
            }
        } else if let dictValue = value as? [String: AnyObject] {
            if key == "bounds" {
                bounds = RouteBounds()
                bounds?.setValuesForKeys(dictValue)
            } else if key == "overview_polyline" {
                overview_polyline = OverviewPolyline()
                overview_polyline?.setValuesForKeys(dictValue)
            } else {
                super.setValue(value, forKey: key)
            }
        }
    }
}
