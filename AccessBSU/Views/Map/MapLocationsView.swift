//
//  MapLocationsView.swift
//  AccessBSU
//
//  Created by Jaylen Smith on 4/2/24.
//

import SwiftUI

struct MapLocationsView: View {
    
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack(spacing: 8) {
                    headerView
                    Divider()
                }
                .padding(.top)
                ScrollView {
                    
                }
            }
        }
        .interactiveDismissDisabled()
        .presentationCornerRadius(25)
        .presentationDragIndicator(.visible)
        .presentationBackground(.ultraThickMaterial)
        .presentationBackgroundInteraction(.enabled(upThrough: .height(100)))
        .presentationDetents([.height(100), .large])
    }
    
    private var headerView: some View {
        HStack {
            Text("BSU")
                .font(.system(size: 27).weight(.heavy))
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    MapLocationsView()
}
