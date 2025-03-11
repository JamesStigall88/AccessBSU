//
//  AuthViewModel.swift
//  AccessBSU
//
//  Created by Jaylen Smith on 3/11/25.
//

import Foundation
import FirebaseAuth

@MainActor
final class AuthViewModel: ObservableObject {
	
	enum AuthState {
		case signedIn
		case signedOut
	}
	
	@Published private(set) var authState: AuthState = .signedOut
	
	init() {
		//On the initialization of this object, this causes for smooth transition to the map view as long as the user is not nil
		if Auth.auth().currentUser != nil {
			self.authState = .signedIn
		} else {
			//Else, show the login screen
			self.authState = .signedOut
		}
		
		//Anytime an account is made or a user signs in, this fire automatically.
		_ = Auth.auth().addStateDidChangeListener { [weak self] _, user in
			if user != nil {
				DispatchQueue.main.async {
					self?.authState = .signedIn
				}
			} else {
				DispatchQueue.main.async {
					self?.authState = .signedOut
				}
			}
		}
	}
	
	func signIn(with email: String, password: String) async throws {
		try await Auth.auth().signIn(withEmail: email, password: password)
	}
	
	func createAccount(with email: String, password: String) async throws {
		try await Auth.auth().createUser(withEmail: email, password: password)
	}
	
	func signOut() {
		try? Auth.auth().signOut()
	}
}
