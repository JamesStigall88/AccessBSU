//
//  ContentView.swift
//  AccessBSU
//
//  Created by Jaylen Smith on 2/15/24.
//

import SwiftUI
import CoreLocation

struct MapView: View {
    
    @State private var sheetDetent: PresentationDetent = .height(100)
    @State private var isSearching = false
    
    @StateObject private var mapVM = MapViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                MapViewRepresentable(mapVM: mapVM)
                    .ignoresSafeArea()
                MapHeaderView()
            }
        }
        .tint(.label)
        .environmentObject(mapVM)
        .sheet(isPresented: .constant(true)) {
            MapLocationsView(locationButtonSelected: mapVM.goToUsersLocation, locationSelected: mapVM.showLocationsOnMap(_:))
        }
        .onChange(of: isSearching) { _, isSearching in
            if isSearching {
                sheetDetent = .large
            }
        }
        .onAppear {
            CLLocationManager().requestAlwaysAuthorization()
        }
    }
}

#Preview {
    MapView()
}
