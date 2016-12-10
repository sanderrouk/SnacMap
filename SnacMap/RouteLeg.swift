//
//  RouteLeg.swift
//  SnacMap
//
//  Created by Sander Rõuk on 10/12/2016.
//  Copyright © 2016 Sander Rõuk. All rights reserved.
//

import Foundation

class RouteLeg: RouteStep {
    var end_address: String?
    var start_address: String?
    var steps: [RouteStep]?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if let dictValue = value as? [[String: AnyObject]] {
            if key == "steps" {
                steps = [RouteStep]()
                for step in dictValue {
                    let routeStep = RouteStep()
                    routeStep.setValuesForKeys(step)
                    steps?.append(routeStep)
                }
            }
        } else if let dictValue = value as? String {
            if key == "end_address" {
                end_address = dictValue
            } else if key == "start_address" {
                start_address = dictValue
            }
        } else {
            super.setValue(value, forKey: key)
        }
    }
}
