//
//  CLLocation.swift
//  AccessBSU
//
//  Created by Jaylen Smith on 4/2/24.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D {
    
    static var bowieStateUniversity: CLLocationCoordinate2D {
        return .init(latitude: 39.01730, longitude: -76.76064)
    }
}

extension CLLocation {
    
    static var bowieStateUniversity: CLLocation {
        return .init(latitude: 39.01730, longitude: -76.76064)
    }
}
