//
//  AccessBSUApp.swift
//  AccessBSU
//
//  Created by Jaylen Smith on 2/15/24.
//

import SwiftUI

@main
struct AccessBSUApp: App {
    
    init() {
        UINavigationBar.appearance().backItem?.backButtonDisplayMode = .minimal
        UINavigationBar.appearance().topItem?.backButtonDisplayMode = .minimal
    }
    
    var body: some Scene {
        WindowGroup {
            MapView()
        }
    }
}
