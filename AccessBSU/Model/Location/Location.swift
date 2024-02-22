//
//  Location.swift
//  AccessBSU
//
//  Created by Jaylen Smith on 2/22/24.
//

import Foundation
import CoreLocation

struct Location: Identifiable, Codable {
    
    init(name: String, type: LocationType, coordinates: Coordinates) {
        self.name        = name
        self.type        = type
        self.coordinates = coordinates
    }
    
    var id = UUID()
    let name: String
    let type: LocationType
    let coordinates: Coordinates
    
    static var dummyLocation: Location {
        return Location(name: "Student Center", type: .studentCenter, coordinates: .init(latitude: 39.01770, longitude: -76.75819))
    }
}

extension Location {
    
    struct Coordinates: Codable {
        
        //Latitude should be written as a positive double
        //Longitude should be written as a negative double
        
        let latitude: Double
        let longitude: Double
        
        ///The location's center coordinates that will be presented on the map view 
        var center: CLLocationCoordinate2D {
            return .init(latitude: self.latitude, longitude: self.longitude)
        }
    }
}
