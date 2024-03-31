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
    
    var color: Color {
        switch self {
        case .residence:
            return .orange
        case .studentCenter:
            return .red
        case .facility:
            return .yellow
        case .recreation:
            return .green
        case .transit:
            return .blue
        case .complex:
            return .teal
        case .library:
            return .yellow
        }
    }
    
    var annotationColor: UIColor {
        return UIColor(self.color)
    }
    
    static func < (lhs: LocationType, rhs: LocationType) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}
