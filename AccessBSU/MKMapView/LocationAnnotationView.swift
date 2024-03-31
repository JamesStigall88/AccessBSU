//
//  LocationAnnotationView.swift
//  AccessBSU
//
//  Created by Jaylen Smith on 3/31/24.
//

import UIKit
import MapKit
import SwiftUI

final class LocationAnnotationView: MKAnnotationView {
    
    var location: Location!
    
    override init(annotation: (any MKAnnotation)?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)

        self.location = (annotation as! LocationAnnotation).location
        self.clusteringIdentifier = LocationAnnotation.ClusterIdentifier
        self.createAnnotationView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createAnnotationView() {
        self.backgroundColor = location.type.annotationColor
        self.frame.size = .init(width: 25, height: 25)
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
        
        
    }
}

@available(iOS, introduced: 17.0)
#Preview {
    LocationAnnotationView(annotation: LocationAnnotation.testAnnotation, reuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
}
