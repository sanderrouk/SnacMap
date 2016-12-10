//
//  File.swift
//  SnacMap
//
//  Created by Sander Rõuk on 08/12/2016.
//  Copyright © 2016 Sander Rõuk. All rights reserved.
//

import Foundation

class FbApiPlace: SafeJsonObject {
    var name: String?
    var id: String?
    var location: FbLocation?
    var fan_count: NSNumber? {
        didSet{
            fanCount = fan_count?.intValue
        }
    }
    var fanCount: Int?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if let dictValue = value as? [String: AnyObject] {
            if key == "location" {
                location = FbLocation()
                location?.setValuesForKeys(dictValue)
            } else {
                super.setValue(value, forKey: key)
            }
        }  else {
            super.setValue(value, forKey: key)
        }
    }
}
