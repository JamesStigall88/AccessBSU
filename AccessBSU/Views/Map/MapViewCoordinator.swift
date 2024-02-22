//
//  MapViewCoordinator.swift
//  AccessBSU
//
//  Created by Jaylen Smith on 2/22/24.
//

import Foundation
import MapKit

protocol MapViewLocationDelegate: AnyObject {
    func mapViewDidReceiveLocations(_ locations: [Location])
}

final class MapViewCoordinator: NSObject {
    
    weak var mapView: MKMapView?
}

//MARK: - MKMapViewDelegate
extension MapViewCoordinator: MKMapViewDelegate {
    
}

//MARK: - MapViewLocationDelegate
extension MapViewCoordinator: MapViewLocationDelegate {
    func mapViewDidReceiveLocations(_ locations: [Location]) {
        
    }
}
 
