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
            ZStack {
                Color.uniYellow.ignoresSafeArea()
                VStack(spacing: 0) {
                    MapViewLocationTypeCarouselView(locationType: $mapVM.locationType)
                    MapViewRepresentable()
                }
                .navigationTitle("Map View")
                .navigationBarTitleDisplayMode(.inline)
                .ignoresSafeArea(edges: .bottom)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink {
                        
                    } label: {
                        Image(systemName: "bell")
                    }
                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "exclamationmark.bubble")
                    }
                    Menu {
                        
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }
                }
            }
        }
        .tint(.label)
        .ignoresSafeArea()
    }
}

#Preview {
    MapView()
}
