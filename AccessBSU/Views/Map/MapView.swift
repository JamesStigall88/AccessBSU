//
//  ContentView.swift
//  AccessBSU
//
//  Created by Jaylen Smith on 2/15/24.
//

import SwiftUI

struct MapView: View {
    
    @State private var sheetDetent: PresentationDetent = .height(100)
    @State private var isSearching = false
    
    @StateObject private var mapVM = MapViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                MapViewRepresentable()
            }
            .ignoresSafeArea()
        }
        .tint(.label)
        .environmentObject(mapVM)
        .sheet(isPresented: .constant(true)) {
            MapLocationsView()
        }
        .onChange(of: isSearching) { _, isSearching in
            if isSearching {
                sheetDetent = .large
            }
        }
    }
}

#Preview {
    MapView()
}
