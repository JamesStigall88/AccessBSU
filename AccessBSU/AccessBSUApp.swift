//
//  AccessBSUApp.swift
//  AccessBSU
//
//  Created by Jaylen Smith on 2/15/24.
//

import SwiftUI
import UIKit
import Firebase

@main
struct AccessBSUApp: App {
    
    init() {
        UINavigationBar.appearance().backItem?.backButtonDisplayMode = .minimal
        UINavigationBar.appearance().topItem?.backButtonDisplayMode = .minimal
    }
	
	@UIApplicationDelegateAdaptor(AppDelete.self) var appDelegate
	
	@StateObject private var authVM = AuthViewModel()
    
    var body: some Scene {
        WindowGroup {
			switch authVM.authState {
			case .signedIn:
				MapView()
			case .signedOut:
				AuthSignInView()
					.environmentObject(authVM)
			}
        }
    }
}


final class AppDelete: UIResponder, UIApplicationDelegate {
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
		FirebaseApp.configure()
		return true
	}
}
