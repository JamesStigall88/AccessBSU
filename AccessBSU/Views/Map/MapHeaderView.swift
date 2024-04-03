//
//  MapHeaderView.swift
//  AccessBSU
//
//  Created by Jaylen Smith on 4/2/24.
//

import SwiftUI

struct MapHeaderView: View {
    
    @EnvironmentObject var mapVM: MapViewModel
    
    var body: some View {
        HStack {
            
        }
    }
}

#Preview {
    MapHeaderView()
        .environmentObject(MapViewModel())
}
