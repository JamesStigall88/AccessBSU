//
//  Location.swift
//  AccessBSU
//
//  Created by Jaylen Smith on 2/22/24.
//

import Foundation
import CoreLocation

struct Location: Identifiable, Codable, Comparable {
    
    init(name: String, type: LocationType, coordinates: Coordinates) {
        self.name        = name
        self.type        = type
        self.coordinates = coordinates
    }
    
    var id = UUID()
    let name: String
    let type: LocationType
    let coordinates: Coordinates
    
    static var dummyLocation: Location {
        return Location(name: "Student Center", type: .studentCenter, coordinates: .init(latitude: 39.01770, longitude: -76.75819))
    }
    
    static func universityLocations() -> [Location] {
        return [
            Location(name: "Christa McAuliffe Residential Community", type: .residence, coordinates: .init(latitude: 39.01886, longitude: -76.75756)),
            Location(name: "Alex Haley Residential Hall", type: .residence, coordinates: .init(latitude: 39.01981, longitude: -76.75691)),
            Location(name: "Towers Residential Hall", type: .residence, coordinates: .init(latitude: 39.02019, longitude: -76.75737)),
            Location(name: "Dwight Holmes Residence Hall", type: .residence, coordinates: .init(latitude: 39.01968, longitude: -76.75797)),
            Location(name: "Lucretia Kennard", type: .residence, coordinates: .init(latitude: 39.01965, longitude: -76.75875)),
            Location(name: "Leonidas S James Physical Education Complex", type: .complex, coordinates: .init(latitude: 39.02089, longitude: -76.75831)),
            Location(name: "Theodore McKeldin Gymnasium", type: .recreation, coordinates: .init(latitude: 39.02056, longitude: -76.75926)),
            Location(name: "Harriet Tubman Residence Hall", type: .residence, coordinates: .init(latitude: 39.01996, longitude: -76.75985)),
            Location(name: "James E. Proctor Jr. Building", type: .facility, coordinates: .init(latitude: 39.01930, longitude: -76.76045)),
            Location(name: "Student Center", type: .studentCenter, coordinates: .init(latitude: 39.01888, longitude: -76.75880)),
            Location(name: "Henry Administration Building", type: .facility, coordinates: .init(latitude: 39.01840, longitude: -76.76072)),
            Location(name: "Thurgood Marshall Library", type: .library, coordinates: .init(latitude: 39.01803, longitude: -76.75979)),
            Location(name: "Martin Luther King Jr. Building", type: .facility, coordinates: .init(latitude: 39.01771, longitude: -76.76218)),
            Location(name: "College of Business and Graduate Studies", type: .facility, coordinates: .init(latitude: 39.01689, longitude: -76.76166)),
            Location(name: "Entrepreneurship Living and Learning Community", type: .residence, coordinates: .init(latitude: 39.01563, longitude: -76.76137)),
            Location(name: "Bulldog Stadium", type: .recreation, coordinates: .init(latitude: 39.02179, longitude: -76.75491)),
            Location(name: "Bowie State University Softball Field", type: .recreation, coordinates: .init(latitude: 39.02200, longitude: -76.75623)),
            Location(name: "Bowie State University Track", type: .recreation, coordinates: .init(latitude: 39.02140, longitude: -76.75736)),
            Location(name: "Facilities Management", type: .facility, coordinates: .init(latitude: 39.01792, longitude: -76.75706)),
            Location(name: "Charlotte Robinson Hall", type: .facility, coordinates: .init(latitude: 39.01640, longitude: -76.75991)),
            Location(name: "Fine and Performing Arts Center", type: .facility, coordinates: .init(latitude: 39.01595, longitude: -76.75890)),
            Location(name: "Bowie State Metro Station", type: .transit, coordinates: .init(latitude: 39.01748, longitude: -76.76430))
        ]
    }
    
    static func locations(for locationType: LocationType) -> [Location] {
        return Self.universityLocations().filter({$0.type == locationType}).sorted(by: <)
    }
    
    static func < (lhs: Location, rhs: Location) -> Bool {
        return lhs.name < rhs.name
    }
    
    static func == (lhs: Location, rhs: Location) -> Bool {
        return true
    }
}

extension Location {
    
    struct Coordinates: Codable {
        
        //Latitude should be written as a positive double
        //Longitude should be written as a negative double
        
        let latitude: Double
        let longitude: Double
        
        ///The location's center coordinates that will be presented on the map view 
        var center: CLLocationCoordinate2D {
            return .init(latitude: self.latitude, longitude: self.longitude)
        }
    }
}
