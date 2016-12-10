//
//  FbLocation.swift
//  SnacMap
//
//  Created by Sander Rõuk on 10/12/2016.
//  Copyright © 2016 Sander Rõuk. All rights reserved.
//

import Foundation

class FbLocation: SafeJsonObject {
    var longitude: Double?
    var latitude: Double?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if let numberValue = value as? NSNumber {
            if key == "longitude" {
                longitude = numberValue.doubleValue
            } else if key == "latitude" {
                latitude = numberValue.doubleValue
            }
        }
    }
}
