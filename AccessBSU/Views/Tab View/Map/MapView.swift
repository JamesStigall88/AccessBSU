//
//  ContentView.swift
//  AccessBSU
//
//  Created by Jaylen Smith on 2/15/24.
//

import SwiftUI

struct MapView: View {
    
    @StateObject private var mapVM = MapViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                MapViewRepresentable()
            }
            .navigationTitle("Issues Map")
            .navigationBarTitleDisplayMode(.inline)
        }
        .tint(.label)
        .ignoresSafeArea()
        .environmentObject(mapVM)
        .sheet(isPresented: $mapVM.isShowingLocationsView) {
            MapLocationsView()
        }
    }
}

#Preview {
    MapView()
}
