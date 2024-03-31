//
//  AppTabView.swift
//  AccessBSU
//
//  Created by Jaylen Smith on 3/31/24.
//

import SwiftUI

struct AppTabView: View {
    
    
    @State private var tabSelection: TabViewSelection = .issuesMap
    
    private enum TabViewSelection: Hashable {
        case issuesMap, profile
        
        var label: some View {
            switch self {
            case .issuesMap:
                return Label("Map", systemImage: "map")
            case .profile:
                return Label("My Profile", systemImage: "person.crop.circle")
            }
        }
    }
    
    var body: some View {
        TabView {
            MapView()
                .tag(TabViewSelection.issuesMap)
                .tabItem {
                    TabViewSelection.issuesMap.label
                }
            UserProfileView()
                .tag(TabViewSelection.profile)
                .tabItem {
                    TabViewSelection.profile.label
                }
        }
        .tint(.label)
    }
}

#Preview {
    AppTabView()
        .preferredColorScheme(.dark)
}
