//
//  MapViewLocationTypeCarouselView.swift
//  AccessBSU
//
//  Created by Jaylen Smith on 2/22/24.
//

import SwiftUI

struct MapViewLocationTypeCarouselView: View {
    
    @Binding var locationType: LocationType?
    
    var body: some View {
        HStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    Spacer()
                    ForEach(LocationType.allCases) { type in
                        locationTypeCellView(type)
                            .onTapGesture {
                                self.locationType = type
                            }
                    }
                    Spacer()
                }
            }
        }
        .frame(height: 60)
        .background(Color.uniYellow)
        .onChange(of: locationType) {  newValue in
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        }
    }
    
    @ViewBuilder
    private func locationTypeCellView(_ type: LocationType) -> some View {
        Text(type.title)
            .font(.system(size: 15).weight(.bold))
            .foregroundColor(self.locationType == type ? Color.black : Color.white)
            .padding(10)
            .frame(minWidth: 100)
            .background(self.locationType == type ? Color.white : Color.black)
            .clipShape(RoundedRectangle(cornerRadius: 5))
    }
}

#Preview {
    MapViewLocationTypeCarouselView(locationType: .constant(.parkingLot))
}
