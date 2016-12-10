//
//  RouteLegDistance.swift
//  SnacMap
//
//  Created by Sander Rõuk on 10/12/2016.
//  Copyright © 2016 Sander Rõuk. All rights reserved.
//

import Foundation

class RouteLegDistance: SafeJsonObject {
    var text: String?
    var value: NSNumber? {
        didSet {
            meters = value?.intValue
        }
    }
    var meters: Int?
}
