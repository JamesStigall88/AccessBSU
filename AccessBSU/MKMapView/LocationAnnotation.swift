//
//  LocationAnnotation.swift
//  AccessBSU
//
//  Created by Jaylen Smith on 3/30/24.
//

import Foundation
import MapKit

final class LocationAnnotation: NSObject, MKAnnotation {
    
    static let ClusterIdentifier = "Location"
        
    init(location: Location) {
        self.location = location
    }
    
    var location: Location
    
    var coordinate: CLLocationCoordinate2D {
        return location.coordinates.center
    }
    
    var symbol: UIImage? {
        return UIImage(systemName: location.type.symbol)
    }
    
    var annotationColor: UIColor {
        return location.type.annotationColor
    }
    
    var subtitle: String? {
        return "\(location.name) \n\n (\(location.type.title))"
    }
    
    static var testAnnotation: LocationAnnotation {
        return .init(location: .dummyLocation)
    }
}
