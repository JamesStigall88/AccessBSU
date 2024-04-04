//
//  MapViewModel.swift
//  AccessBSU
//
//  Created by Jaylen Smith on 2/22/24.
//

import Foundation
import MapKit

final class MapViewModel: NSObject, ObservableObject {
    
    @Published var mapType: MapType = .standard {
        didSet {
            self.setMapType(to: mapType.type)
        }
    }
    
    @Published var isShowingLocationsView = false
    
    weak var mapView: MKMapView?
    
    private func setMapType(to mapType: MKMapType) {
        mapView?.mapType = mapType
    }
    
    func goToUsersLocation() {
        if let userLocation = CLLocationManager().location {
            mapView?.setCenter(userLocation.coordinate, animated: true)
        }
    }
    
    func showLocationsOnMap(_ locations: [Location]) {
        if let mapView {
            mapView.removeAnnotations(mapView.annotations)
            let annotations = locations.map { location in
                return LocationAnnotation(location: location)
            }
            mapView.addAnnotations(annotations)
        }
    }
}
