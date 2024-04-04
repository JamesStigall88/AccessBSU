//
//  IssuesLocationView.swift
//  AccessBSU
//
//  Created by Jaylen Smith on 4/5/24.
//

import SwiftUI
import MapKit

struct IssuesLocationView: View {
    
    @Binding var location: Location?
    
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                IssuesLocationMapView(location: $location)
                VStack(alignment: .leading, spacing: 20) {
                    Label("Select A Location On The Map", systemImage: "info.circle")
                        .font(.system(size: 16))
                        .frame(maxWidth: .infinity, alignment: .center)
                    if let location {
                        HStack {
                            Image(systemName: "mappin.and.ellipse")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                            VStack(alignment: .leading) {
                                Text("You Selected")
                                Text(location.name)
                                    .bold()
                            }
                        }
                    }
                }
                .font(.system(size: 19))
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.center)
                .padding()
            }
            .navigationTitle("Location")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct IssuesLocationMapView: UIViewRepresentable {
    
    @Binding var location: Location?
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        mapView.showsBuildings = false
        mapView.showsPointsOfInterest = false
        mapView.setRegion(.init(center: location?.coordinates.center ?? .bowieStateUniversity, span: .init(latitudeDelta: 0.005, longitudeDelta: 0.005)), animated: false)
        mapView.delegate = context.coordinator
        let annotation = IssueAnnotation(coordinate: location?.coordinates.center ?? .bowieStateUniversity)
        let locationsAnnotations = Location.universityLocations().map({LocationAnnotation(location: $0)})
        mapView.addAnnotations(locationsAnnotations)
        let overlay = BoundaryCircleOverlay()
        //mapView.addAnnotation(annotation)
        mapView.addOverlay(overlay)
        mapView.register(LocationIssueAnnotationView.self, forAnnotationViewWithReuseIdentifier: "Location")
        return mapView
    }
    
    func makeCoordinator() -> MapViewCoordinator {
        return MapViewCoordinator(parent: self)
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {}
    
    
    typealias UIViewType = MKMapView
    
    final class MapViewCoordinator: NSObject, MKMapViewDelegate {
        
        weak var previousAnnotationView: LocationIssueAnnotationView?
        
        private var parentView: IssuesLocationMapView
        
        init(parent: IssuesLocationMapView) {
            self.parentView = parent
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
            if let issuesAnnotation = annotation as? IssueAnnotation {
                let annotationView = MKMarkerAnnotationView(annotation: issuesAnnotation, reuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
                annotationView.isDraggable = true
                annotationView.subtitleVisibility = .adaptive
                annotationView.clusteringIdentifier = "ISSUE"
                annotationView.displayPriority = .defaultHigh
                annotationView.glyphImage = UIImage(systemName: "exclamationmark.triangle")
                return annotationView
            }
            
            if let locationAnnotation = annotation as? LocationAnnotation {
                let annotationView = LocationIssueAnnotationView(annotation: locationAnnotation, reuseIdentifier: "Location")
                
                return annotationView
            }
            
            return nil
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: any MKOverlay) -> MKOverlayRenderer {
            if let boundaryOverlay = overlay as? BoundaryCircleOverlay {
                let renderer = ComposeLocationMapInvertRenderer(overlay: boundaryOverlay)
                return renderer
            }
            return MKOverlayRenderer(overlay: overlay)
        }
        
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationView.DragState, fromOldState oldState: MKAnnotationView.DragState) {
            
        }
        
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            guard let annotationView = view as? LocationIssueAnnotationView else {
                self.previousAnnotationView?.displayAsUnSelected()
                return
            }
            
            if let locationAnnotation = view.annotation as? LocationAnnotation {
                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                mapView.setCenter(locationAnnotation.coordinate, animated: true)
                self.parentView.location = locationAnnotation.location
                self.previousAnnotationView?.displayAsUnSelected()
                annotationView.displayAsSelected()
            }
            
            self.previousAnnotationView = annotationView
        }
    }
    
    private final class IssueAnnotation: NSObject, MKAnnotation {
        var coordinate: CLLocationCoordinate2D
        
        var title: String? {
            "Location of Issue\nSelect and Hold to Drag"
        }
        
        init(coordinate: CLLocationCoordinate2D) {
            self.coordinate = coordinate
        }
    }
    
    final class BoundaryCircleOverlay: NSObject, MKOverlay {
        var radius: Double {
            return 700
        }
        
        var boundingMapRect: MKMapRect {
            return .world
        }
        
        var coordinate: CLLocationCoordinate2D {
            return .bowieStateUniversity
        }
    }
    
    final class LocationIssueAnnotationView: MKAnnotationView {
        
        override init(annotation: (any MKAnnotation)?, reuseIdentifier: String?) {
            super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
            self.backgroundColor = (annotation as! LocationAnnotation).location.type.annotationColor
            self.frame.size = .init(width: 15, height: 15)
            self.layer.cornerRadius = self.frame.width / 2
            self.layer.borderColor = UIColor.white.cgColor
            self.layer.borderWidth = 3
            self.layer.shadowColor = UIColor.black.withAlphaComponent(1).cgColor
            self.layer.shadowRadius = 10
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func displayAsSelected() {
            self.frame.size = .init(width: 35, height: 35)
            self.layer.cornerRadius = self.frame.width / 2
        }
        
        func displayAsUnSelected() {
            self.frame.size = .init(width: 15, height: 15)
            self.layer.cornerRadius = self.frame.width / 2
        }
    }
}

final class ComposeLocationMapInvertRenderer: MKOverlayRenderer {
    
    //We still don't know wtf this code does!!!
    override func draw(_ mapRect: MKMapRect, zoomScale: MKZoomScale, in context: CGContext) {
        let overlay = overlay as! IssuesLocationMapView.BoundaryCircleOverlay
        let path = UIBezierPath(rect: CGRect(x: mapRect.origin.x,
                                             y: mapRect.origin.y,
                                             width: mapRect.size.width,
                                             height: mapRect.size.height))
        let radius = (overlay.radius * 2) * MKMapPointsPerMeterAtLatitude(overlay.coordinate.latitude)
        let mapSize: MKMapSize = MKMapSize(width: radius, height: radius)
        let regionOrigin = MKMapPoint.init(overlay.coordinate)
        var regionRect: MKMapRect = MKMapRect(origin: regionOrigin, size: mapSize)
        regionRect = regionRect.offsetBy(dx: -radius/2, dy: -radius/2);
        regionRect = regionRect.intersection(overlay.boundingMapRect);
        
        let excludePath: UIBezierPath = UIBezierPath(roundedRect: CGRect(x: regionRect.origin.x, y: regionRect.origin.y, width: regionRect.size.width, height: regionRect.size.height), cornerRadius: CGFloat(regionRect.size.width) / 2)
        path.append(excludePath)
        
        context.setFillColor(UIColor.purple.withAlphaComponent(0.2).cgColor);
        context.addPath(path.cgPath);
        context.fillPath(using: .evenOdd)
    }
}

#Preview {
    NavigationStack {
        IssuesLocationView(location: .constant(.dummyLocation))
    }
}
