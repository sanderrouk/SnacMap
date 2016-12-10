//
//  MapController.swift
//  SnacMap
//
//  Created by Sander Rõuk on 07/12/2016.
//  Copyright © 2016 Sander Rõuk. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire

class MapController: UIViewController {
    
    let apiKeyForJsonRequest = ""
    var origin: String
    var destination: String
    let mapView = GMSMapView()
    
    init(origin: String, destination: String) {
        self.origin = origin.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).replacingOccurrences(of: " ", with: "+")
        self.destination = destination.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).replacingOccurrences(of: " ", with: "+")
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup view and map to center on Estonia
        let camera = GMSCameraPosition.camera(withLatitude: 58.8850786, longitude: 25.525193, zoom: 7.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view.addSubview(mapView)
        _ = mapView.anchorTo(centerX: view.centerXAnchor, centerY: view.centerYAnchor, width: view.widthAnchor, height: view.heightAnchor)
        
        //Get route and start logic, need to pass on mapView otherwise it does not get updated
        showRouteAndPitstops(onMap: mapView)
    }
    
    fileprivate func addEndAndStartMarker(forLegs legs: [RouteLeg], onMap map: GMSMapView) {
        for leg in legs {
            guard let startLat = leg.start_location?.latitude, let startLng = leg.start_location?.longitude,
                let endLat = leg.end_location?.latitude, let endLng = leg.end_location?.longitude else {
                    print("Couldnt get leg start and end")
                    return
            }
            
            let legStartLocation = CLLocationCoordinate2D(latitude: startLat, longitude: startLng)
            let legEndLocation = CLLocationCoordinate2D(latitude: endLat, longitude: endLng)
            
            let startMarker = GMSMarker(position: legStartLocation)
            let endMarker = GMSMarker(position: legEndLocation)
            
            startMarker.snippet = "Start"
            endMarker.snippet = "Destination"
            
            if let startAddress = leg.start_address, let endAddress = leg.end_address {
                startMarker.title = startAddress
                endMarker.title = endAddress
            }
            
            startMarker.map = map
            endMarker.map = map
        }

    }
    
    //Get route
    fileprivate func showRouteAndPitstops(onMap map: GMSMapView) {
        let urlString = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&key=\(AppDelegate.apiKeys.directionsServiceApiKey)"
        guard let encodedUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) else {
            return
        }
        Alamofire.request(encodedUrlString).responseJSON { response in
            
            if let JSON = response.result.value, let jsonDictionaries = JSON as? Dictionary<String, AnyObject> {
                
                let directions = Directions()
                directions.setValuesForKeys(jsonDictionaries)
                let routes = directions.routes
                let routeBounds = routes?.first?.bounds
                guard let routeLegs = routes?.first?.legs else {
                    print("no route")
                    return
                }
                
                // Add markers for destination and end
                self.addEndAndStartMarker(forLegs: routeLegs, onMap: map)
                
                //Move camera to new path.
                if let routeBounds = routeBounds {
                    self.moveCameraToPath(withBounds: routeBounds, onMap: map)
                }
                
                // Draw Route Path
                if let route = routes?.first {
                    self.drawRoutePath(usingRoute: route, onMap: map)
                }
                
            }
        }
    }
    
    fileprivate func moveCameraToPath(withBounds bounds: RouteBounds, onMap map: GMSMapView){
        guard let northeastLat = bounds.northeast?.latitude,
            let northeastLng = bounds.northeast?.longitude,
            let southwestLat = bounds.southwest?.latitude,
            let southwestLng = bounds.southwest?.longitude else {
                print("Couldn't establish bounds")
                return
        }
        
        let northeastCorner = CLLocationCoordinate2D(latitude: northeastLat, longitude: northeastLng)
        let southwestCorner = CLLocationCoordinate2D(latitude: southwestLat, longitude: southwestLng)
        
        let cameraBounds = GMSCoordinateBounds(coordinate: northeastCorner, coordinate: southwestCorner)
        let cameraUpdate = GMSCameraUpdate.fit(cameraBounds, withPadding: 50)
        map.animate(with: cameraUpdate)
    }
    
    fileprivate func setTripMiddle(usingPath path: GMSPath, andMap map: GMSMapView) {
        let pointsInPath = path.count()
        let midLocation = path.coordinate(at: pointsInPath / 2)
        findNearbyRestaurants(onMap: map, usingMiddleLocation: midLocation)
        
    }
    
    fileprivate func drawRoutePath(usingRoute route: Route, onMap map: GMSMapView) {
        guard let encodedPolylinePath = route.overview_polyline?.points else {
            print("couldn't get route polyline")
            return
        }
        
        let tripPath = GMSPath(fromEncodedPath: encodedPolylinePath)
        let routePath = GMSPolyline(path: tripPath)
        
        routePath.map = map
        routePath.strokeColor = .yellow
        routePath.strokeWidth = 5.0
        
        if let path = tripPath {
            setTripMiddle(usingPath: path, andMap: map)
        }
    }
    
    fileprivate func findTen(places: [FbApiPlace], closestToLocation location: CLLocationCoordinate2D) -> [FbApiPlace] {
        //Find each place's distance to location
        var placeDistances = [CLLocationDistance]()
        for place in places {
            if let lat = place.location?.latitude, let lng = place.location?.longitude {
                    placeDistances.append(CLLocation(latitude: lat, longitude: lng).distance(from: CLLocation(latitude: location.latitude, longitude: location.longitude)))
            }
        }
        
        //Sort distances from smallest to biggest and remove all suitable ones from this array
        var returnablePlaces = places
        var sortedDistances = placeDistances.sorted(by: <)
        if sortedDistances.count > 10 {
            for _ in 0...9 {
                sortedDistances.remove(at: 0)
            }
            
            // Remove places left in sorted distances because they are unsuitable
            for distance in sortedDistances {
                if let index = placeDistances.index(of: distance)  {
                    placeDistances.remove(at: index)
                    returnablePlaces.remove(at: index)
                }
            }
        }
        return returnablePlaces
    }
    
    //PICK PLACES, max 50km(even this is too long of a distance) away because some places do not have good facebook coverage
    fileprivate func findNearbyRestaurants(onMap map: GMSMapView, usingMiddleLocation targetLocation: CLLocationCoordinate2D) {
        
        let urlString = "https://graph.facebook.com/v2.8/search?fields=name,id,location,fan_count&q=restaurant&type=place&center=\(targetLocation.latitude),\(targetLocation.longitude)&distance=50000&access_token=\(AppDelegate.apiKeys.fbAppId)|\(AppDelegate.apiKeys.fbAppSecret)"
        guard let encodedUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) else {
            print("Failed to get encoded URL String")
            return
        }
        Alamofire.request(encodedUrlString).responseJSON { response in
            if let JSON = response.result.value, let jsonDictionaries = JSON as? Dictionary<String, AnyObject>, let results = jsonDictionaries["data"] as? [[String: AnyObject]] {
                
                var placesApiResults = [FbApiPlace]()
                for result in results {
                    let placesApiResult = FbApiPlace()
                    placesApiResult.setValuesForKeys(result)
                    placesApiResults.append(placesApiResult)
                }
                
                let tenClosestPlaces = self.findTen(places: placesApiResults, closestToLocation: targetLocation)
                
                for place in tenClosestPlaces {
                    if let latitude = place.location?.latitude, let longitude = place.location?.longitude {
                        let placeLocation = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                        let placeMarker = GMSMarker(position: placeLocation)
                        if let name = place.name, let likes = place.fanCount {
                            placeMarker.title = name
                            placeMarker.snippet = "Number of likes: \(likes)"
                        }
                        
                        placeMarker.map = map
                    }
                }
            }
        }

    }
}

