//
//  LocationType.swift
//  AccessBSU
//
//  Created by Jaylen Smith on 2/22/24.
//

import Foundation
import UIKit
import SwiftUI

enum LocationType: String, Identifiable, Codable, CaseIterable, Comparable {
    
    case residence      = "Residence"
    case library        = "Library"
    case complex        = "Complex"
    case studentCenter  = "Student Center"
    case facility       = "Facility"
    case recreation     = "Recreation"
    case transit        = "Transit"
    
    var id: Self { self }
    
    var title: String {
        return self.rawValue
    }
    
    var symbol: String {
        switch self {
        case .residence:
            return "house.fill"
        case .library:
            return "books.vertical"
        case .complex:
            return "sportscourt"
        case .studentCenter:
            return "fork.knife"
        case .facility:
            return "building.2.crop.circle.fill"
        case .recreation:
            return "gamecontroller.fill"
        case .transit:
            return "bus.doubledecker.fill"
        }
    }
    
    var color: Color {
        switch self {
        case .residence:
            return .orange
        case .studentCenter:
            return .red
        case .facility:
            return .orange
        case .recreation:
            return .purple
        case .transit:
            return .blue
        case .complex:
            return .teal
        case .library:
            return .orange
        }
    }
    
    var annotationColor: UIColor {
        return UIColor(self.color)
    }
    
    static func < (lhs: LocationType, rhs: LocationType) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}
