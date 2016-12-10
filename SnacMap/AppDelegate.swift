//
//  AppDelegate.swift
//  SnacMap
//
//  Created by Sander Rõuk on 05/12/2016.
//  Copyright © 2016 Sander Rõuk. All rights reserved.
//

import UIKit
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    struct apiKeys {
        static let mapsServiceApiKey = "AIzaSyDGIJkdk-PU_GQdEXtLLLL_YYkTGgCK4dU"
        static let fbAppId = "221849761591600"
        static let fbAppSecret = "5a832e64d7b9a48e92474267e8f6da06"
        static let directionsServiceApiKey = "AIzaSyB06P8tgoOpGCX714XLvX9T5H0qecZ0miA"
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        //Set Google Maps API Key
        GMSServices.provideAPIKey(apiKeys.mapsServiceApiKey)
        
        //Create app window, make it visible and set contents
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(rootViewController: StartScreenController())
        
        return true
    }
}

