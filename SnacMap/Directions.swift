//
//  Directions.swift
//  SnacMap
//
//  Created by Sander Rõuk on 07/12/2016.
//  Copyright © 2016 Sander Rõuk. All rights reserved.
//

import Foundation

class Directions: SafeJsonObject {
    
    var routes: [Route]?
    var status: String?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if let dictValue = value as? [[String: AnyObject]] {
            if key == "routes" {
                routes = [Route]()
                for route in dictValue {
                    let tempRoute = Route()
                    tempRoute.setValuesForKeys(route)
                    routes?.append(tempRoute)
                }
            } else {
                super.setValue(value, forKey: key)
            }
        }
    }
}
