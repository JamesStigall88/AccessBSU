//
//  LocationType.swift
//  AccessBSU
//
//  Created by Jaylen Smith on 2/22/24.
//

import Foundation
import UIKit
import SwiftUI

enum LocationType: String, Identifiable, Codable, CaseIterable {
    case residence      = "Residence"
    case studentCenter  = "Student Center"
    case facility       = "Facility"
    case parkingLot     = "Parking Lot"
    case recreation     = "Recreation"
    case transit        = "Transit"
    
    var id: Self { self }
    
    var title: String {
        return self.rawValue
    }
    
    var color: Color {
        switch self {
        case .residence:
            return .orange
        case .studentCenter:
            return .red
        case .facility:
            return .yellow
        case .parkingLot:
            return .blue
        case .recreation:
            return .green
        case .transit:
            return .blue
        }
    }
    
    var annotationColor: UIColor {
        return UIColor(self.color)
    }
}
