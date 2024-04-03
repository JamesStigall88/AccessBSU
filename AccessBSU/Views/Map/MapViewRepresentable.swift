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
        mapView.region = MKCoordinateRegion(center: .bowieStateUniversity, span: .init(latitudeDelta: 0.015, longitudeDelta: 0.015))
        mapView.showsUserLocation = true
        mapView.layoutMargins = .init(top: 0, left: 0, bottom: 100, right: 0)
        return mapView
    }()
    
    private lazy var locationButton: UIButton = {
        let button = UIButton()
        button.frame.size = .init(width: 55, height: 55)
        button.backgroundColor = .systemBlue
        button.setImage(UIImage(systemName: "location")?.resized(toWidth: 30), for: .normal)
        button.contentMode = .scaleAspectFit
        button.tintColor = .white
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        let annotations = Location.universityLocations().map { location in
            return LocationAnnotation(location: location)
        }
        
        mapView.addAnnotations(annotations)
        
        view.addSubview(mapView)
        view.addSubview(locationButton)
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        locationButton.translatesAutoresizingMaskIntoConstraints = false
        
        locationButton.layer.cornerRadius = locationButton.frame.width / 2
        
        NSLayoutConstraint.activate([
            //Map View Constraints
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            //Location Button Constraints
            locationButton.widthAnchor.constraint(equalToConstant: 55),
            locationButton.heightAnchor.constraint(equalToConstant: 55),
            locationButton.bottomAnchor.constraint(equalTo: mapView.layoutMarginsGuide.bottomAnchor, constant: -10),
            locationButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: 8),
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

extension UIImage {
    func resized(toWidth width: CGFloat) -> UIImage? {
        let canvas = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        return UIGraphicsImageRenderer(size: canvas).image { _ in
            draw(in: CGRect(origin: .zero, size: canvas))
        }.withTintColor(.white)
    }
}

@available(iOS, introduced: 17.0)
#Preview {
    MapViewController()
}
