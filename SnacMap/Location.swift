//
//  Location.swift
//  SnacMap
//
//  Created by Sander Rõuk on 10/12/2016.
//  Copyright © 2016 Sander Rõuk. All rights reserved.
//

import Foundation

class Location: SafeJsonObject {
    var lat: NSNumber? {
        didSet {
            latitude = lat?.doubleValue
        }
    }
    var lng: NSNumber? {
        didSet {
            longitude = lng?.doubleValue
        }
    }
    var latitude: Double?
    var longitude: Double?
}
