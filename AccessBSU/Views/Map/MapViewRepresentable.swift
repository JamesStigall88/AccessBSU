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
    
    @ObservedObject var mapVM: MapViewModel
    
    func makeUIViewController(context: Context) -> UIViewController {
        return MapViewController(mapVM: mapVM)
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

fileprivate final class MapViewController: UIViewController, MKMapViewDelegate {
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
		mapView.tintColor = .systemBlue
        mapView.region = MKCoordinateRegion(center: .bowieStateUniversity, span: .init(latitudeDelta: 0.015, longitudeDelta: 0.015))
        mapView.showsUserLocation = true
        mapView.showsCompass = false
        mapView.layoutMargins = .init(top: 0, left: 0, bottom: 100, right: 0)
        return mapView
    }()
    
    weak var mapVM: MapViewModel?
    
    init(mapVM: MapViewModel) {
        self.mapVM = mapVM
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapVM?.mapView = self.mapView
        
		mapView.register(ClusterAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
        mapView.delegate = self
        
        let annotations = Location.universityLocations().map { location in
            return LocationAnnotation(location: location)
        }
        
        mapView.addAnnotations(annotations)
        
        CLLocationManager().requestWhenInUseAuthorization()
        
        let compass = MKCompassButton(mapView: mapView)
        view.addSubview(mapView)
        view.addSubview(compass)
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        compass.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            //Map View Constraints
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            compass.bottomAnchor.constraint(equalTo: mapView.layoutMarginsGuide.bottomAnchor, constant: -7),
            compass.trailingAnchor.constraint(equalTo: mapView.safeAreaLayoutGuide.trailingAnchor, constant: -5)
        ])
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
        if let locationAnnotation = annotation as? LocationAnnotation {
            let annotationView = MKMarkerAnnotationView(annotation: locationAnnotation, reuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
            annotationView.titleVisibility = .hidden
            annotationView.subtitleVisibility = .adaptive
            annotationView.clusteringIdentifier = LocationAnnotation.ClusterIdentifier
            annotationView.glyphImage = locationAnnotation.symbol
            annotationView.markerTintColor = locationAnnotation.annotationColor
            return annotationView
        }
        
        if let clusterAnnotation = annotation as? MKClusterAnnotation {
			let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
			annotationView.markerTintColor = (clusterAnnotation.memberAnnotations as? [LocationAnnotation])?.allSatisfyEventType() ?? .systemRed
            return annotationView
        }
        
        return nil
    }
    
    func mapView(_ mapView: MKMapView, clusterAnnotationForMemberAnnotations memberAnnotations: [any MKAnnotation]) -> MKClusterAnnotation {
        return MKClusterAnnotation(memberAnnotations: memberAnnotations)
    }
	
	func mapView(_ mapView: MKMapView, didSelect annotation: any MKAnnotation) {
		if let clusterAnnotation = annotation as? MKClusterAnnotation {
			mapView.setVisibleMapRect(clusterAnnotation.annotationMapRect(mapView: mapView), animated: true)
		}
	}
    
    @objc
    func moveToUserLocation() {
        if let userLocation = CLLocationManager().location {
            mapView.setCenter(userLocation.coordinate, animated: true)
        }
    }
}

final class ClusterAnnotationView: MKMarkerAnnotationView {
	
	
}

extension MKClusterAnnotation {
	
	func annotationMapRect(mapView: MKMapView) -> MKMapRect {
		var clusterRect = MKMapRect.null

		for annotation in self.memberAnnotations {
			let point = MKMapPoint(annotation.coordinate)
			let pointRect = MKMapRect(x: point.x, y: point.y, width: 0, height: 0)
			clusterRect = clusterRect.union(pointRect)
		}
		
		let edgePadding = UIEdgeInsets(top: 100, left: 125, bottom: 100, right: 125)
		clusterRect = mapView.mapRectThatFits(clusterRect, edgePadding: edgePadding)
		return clusterRect
	}
}

extension [Location] {
	
	func annotationMapRect(mapView: MKMapView) -> MKMapRect {
		var clusterRect = MKMapRect.null

		for annotation in self {
			let point = MKMapPoint(annotation.coordinates.center)
			let pointRect = MKMapRect(x: point.x, y: point.y, width: 0, height: 0)
			clusterRect = clusterRect.union(pointRect)
		}
		
		let edgePadding = UIEdgeInsets(top: 100, left: 125, bottom: 100, right: 125)
		clusterRect = mapView.mapRectThatFits(clusterRect, edgePadding: edgePadding)
		return clusterRect
	}
}

extension [LocationAnnotation] {
	func allSatisfyEventType() -> UIColor {
		let eventTypes: Set<LocationType> = Set(self.map({$0.location.type}))
		
		guard (eventTypes.count == 1), let eventType = eventTypes.first else {
			return .systemRed
		}
		
		return eventType.annotationColor
	}
}

//@available(iOS, introduced: 17.0)
//#Preview {
//    MapViewController()
//}
