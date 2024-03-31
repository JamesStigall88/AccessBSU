//
//  MapLocationsView.swift
//  AccessBSU
//
//  Created by Jaylen Smith on 3/31/24.
//

import SwiftUI

struct MapLocationsView: View {
    
    @State private var isSearching = false
    
    @State private var searchTerm = ""
    
    @EnvironmentObject var mapVM: MapViewModel
    
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(LocationType.allCases) { type in
                    Section(type.title) {
                        ForEach(Location.locations(for: type)) { location in
                            NavigationLink {
                                
                            } label: {
                                locationCellView(location)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Locations")
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(.grouped)
            .searchable(text: $searchTerm, placement: .navigationBarDrawer(displayMode: .always))
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
        .presentationDragIndicator(.visible)
        .tint(.label)
    }
    
    @ViewBuilder
    private func locationCellView(_ location: Location) -> some View {
        HStack {
            Text(location.name)
                .font(.body)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .multilineTextAlignment(.leading)
    }
}

#Preview {
    MapLocationsView()
        .environmentObject(MapViewModel())
}
