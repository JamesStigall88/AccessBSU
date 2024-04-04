//
//  MapLocationsView.swift
//  AccessBSU
//
//  Created by Jaylen Smith on 4/2/24.
//

import SwiftUI

struct MapLocationsView: View {
    
    @State private var isShowingReportComposeView = false
    
    @State private var detent: PresentationDetent = .height(100)
    @State private var searchTerm = ""
    
    @Environment (\.font) var font
    
    private var locations: [Location] {
        return Location.universityLocations().filter { location in
            return location.name.contains(searchTerm)
        }
    }
    
    var locationButtonSelected: () -> ()
    var locationSelected: ([Location]) -> ()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                VStack(spacing: 10) {
                    headerView
                }
                .padding(.top)
                switch searchTerm.isEmpty {
                case true:
                    locationTypesView
                case false:
                    locationSearchView
                }
            }
        }
        .interactiveDismissDisabled()
        .presentationCornerRadius(10)
        .presentationDragIndicator(.visible)
        .presentationBackgroundInteraction(.enabled(upThrough: .height(100)))
        .presentationDetents([.height(100), .large], selection: $detent)
        .sheet(isPresented: $isShowingReportComposeView) {
            MapIssuesView()
        }
    }
    
    private var locationTypesView: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(spacing: 0), GridItem(spacing: 0)], spacing: 10) {
                ForEach(LocationType.allCases.sorted(by: <)) { type in
                    Button {
                        self.detent = .height(100)
                        self.locationSelected(Location.locations(for: type))
                    } label: {
                        VStack(spacing: 15) {
                            Image(systemName: type.symbol)
                                .font(.title)
                                .foregroundColor(type.color)
                            Text(type.title)
                                .font(.body.weight(.bold))
                                .padding(.horizontal)
                        }
                        .foregroundColor(.label)
                        .frame(width: (UIScreen.main.bounds.width / 2) - 60)
                        .frame(minHeight: 100)
                        .frame(maxHeight: 300)
                        .padding(15)
                        .background(Material.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .multilineTextAlignment(.center)
                    }
                }
                Button {
                    self.isShowingReportComposeView.toggle()
                } label: {
                    VStack(spacing: 15) {
                        Image(systemName: "bubble.left.and.exclamationmark.bubble.right")
                            .font(.title)
                        Text("Report An Issue")
                            .font(.body.weight(.bold))
                    }
                    .foregroundColor(.white)
                    .frame(width: (UIScreen.main.bounds.width / 2) - 60)
                    .frame(minHeight: 100)
                    .frame(maxHeight: 200)
                    .padding(15)
                    .background(Color.purple)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .multilineTextAlignment(.center)
                }
            }
            .padding(.horizontal)
        }
        .multilineTextAlignment(.center)
    }
    
    private var locationSearchView: some View {
        ScrollView {
            ForEach(locations) { location in
                Button {
                    self.detent = .height(100)
                    self.locationSelected([location])
                } label: {
                    Text(location.name)
                        .font(.system(size: 17))
                        .foregroundColor(.label)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(10)
                        .background(Color(uiColor: .systemBackground))
                }
                Divider()
            }
        }
    }
    
    private var headerView: some View {
        HStack {
            Button {
                self.detent = .height(100)
                self.locationButtonSelected()
            } label: {
                Image(systemName: "location.fill")
                    .font(.title)
            }
            TextField("Search", text: $searchTerm)
                .font(.subheadline)
                .padding(7)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .padding(.top, 3)
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    MapLocationsView {
        
    } locationSelected: { locations in
        
    }
}
