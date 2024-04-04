//
//  LocationClusterAnnotationView.swift
//  AccessBSU
//
//  Created by Jaylen Smith on 4/4/24.
//

import UIKit
import MapKit

class LocationClusterAnnotationView: MKAnnotationView {

    var clusterAnnotation: MKClusterAnnotation!
    
    override func prepareForDisplay() {
        self.configureView()
    }
    
    override func prepareForReuse() {
        self.configureView()
    }
    
    private func configureView() {
        self.backgroundColor = .systemBlue
        
        let label = UILabel()
        label.text = "\(clusterAnnotation?.memberAnnotations.count ?? 0)"
        label.textColor = .white
        label.font = .systemFont(ofSize: 22, weight: .heavy)
        
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
        
        layer.cornerRadius = 40 / 2
        clipsToBounds = true
        
        frame.size = .init(width: 40, height: 40)
    }
}

#Preview {
    LocationClusterAnnotationView()
}
