//
//  MapViewRepresentable.swift
//  AccessBSU
//
//  Created by Jaylen Smith on 2/22/24.
//

import Foundation
import MapKit
import SwiftUI

struct MapViewRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        return MapViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

fileprivate final class MapViewController: UIViewController, MKMapViewDelegate {
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.region = MKCoordinateRegion(center: .init(latitude: 39.01730, longitude: -76.76064), span: .init(latitudeDelta: 0.015, longitudeDelta: 0.015))
        mapView.showsUserLocation = true
        return mapView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        let annotations = Location.universityLocations().map { location in
            return LocationAnnotation(location: location)
        }
        
        mapView.addAnnotations(annotations)
        
        view.addSubview(mapView)
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
        if let locationAnnotation = annotation as? LocationAnnotation {
            let annotationView = MKPinAnnotationView(annotation: locationAnnotation, reuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
            annotationView.canShowCallout = true
            annotationView.detailCalloutAccessoryView = UIView()
            return annotationView
        }
        
        return nil
    }
    
    func mapView(_ mapView: MKMapView, clusterAnnotationForMemberAnnotations memberAnnotations: [any MKAnnotation]) -> MKClusterAnnotation {
        return MKClusterAnnotation(memberAnnotations: memberAnnotations)
    }
}
