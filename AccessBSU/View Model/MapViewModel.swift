//
//  MapViewModel.swift
//  AccessBSU
//
//  Created by Jaylen Smith on 2/22/24.
//

import Foundation

final class MapViewModel: NSObject, ObservableObject {
    
    @Published var locationType: LocationType? = nil
    
    ///The university's locations from Firebase
    @Published private(set) var locations: [Location] = [] {
        didSet {
            
        }
    }
    
    ///Fetch the university's locations from Firebase
    func fetchLocations() async throws {
        
    }
}
