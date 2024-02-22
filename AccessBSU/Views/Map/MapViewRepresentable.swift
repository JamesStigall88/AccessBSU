//
//  MapViewRepresentable.swift
//  AccessBSU
//
//  Created by Jaylen Smith on 2/22/24.
//

import Foundation
import MapKit
import SwiftUI

struct MapViewRepresentable: UIViewRepresentable {
    
    private let campusRegion: MKCoordinateRegion = MKCoordinateRegion(center: .init(latitude: 39.01730, longitude: -76.76064), span: .init(latitudeDelta: 0.015, longitudeDelta: 0.015))
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.region = campusRegion
        mapView.showsUserLocation = true
        return mapView
    }
    
    func makeCoordinator() -> MapViewCoordinator {
        return MapViewCoordinator()
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {}
    
}
