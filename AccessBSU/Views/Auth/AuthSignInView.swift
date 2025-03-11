//
//  AuthSignInView.swift
//  AccessBSU
//
//  Created by Jaylen Smith on 3/11/25.
//

import SwiftUI

struct AuthSignInView: View {
	
	@State private var presentSignInFailedAlert: Bool = false
	@State private var isSigningIn: Bool = false
	
	@State private var email: String = ""
	@State private var password: String = ""
	
	@EnvironmentObject var authVM: AuthViewModel
	
    var body: some View {
		NavigationStack {
			VStack(spacing: 30) {
				Text("Sign In")
					.font(.system(size: 20).bold())
				VStack(spacing: 5) {
					emailTextField
					passwordTextField
				}
				.textFieldStyle(.roundedBorder)
				signInButton
				NavigationLink {
					AuthSignUpView()
						.environmentObject(authVM)
				} label: {
					Text("Create an account")
				}
			}
			.padding()
			.alert("Unable to sign in", isPresented: $presentSignInFailedAlert) {
				Button("OK") {}
			} message: {
				Text("Please try again.")
			}
			.task(id: isSigningIn) {
				if isSigningIn {
					await signIn()
				}
			}
		}
    }
	
	private var emailTextField: some View {
		TextField("Email", text: $email)
			.padding()
			.autocapitalization(.none)
	}
	
	private var passwordTextField: some View {
		TextField("Password", text: $password)
			.padding()
			.autocapitalization(.none)
	}
	
	@ViewBuilder
	private var signInButton: some View {
		switch isSigningIn {
		case true:
			ProgressView()
		case false:
			Button("Sign In") {
				self.isSigningIn.toggle()
			}
			.buttonStyle(.borderedProminent)
		}
	}
	
	private func signIn() async {
		defer {
			self.isSigningIn = false
		}
		
		do {
			try await authVM.signIn(with: email, password: password)
		} catch {
			self.presentSignInFailedAlert.toggle()
		}
	}
}

#Preview {
    AuthSignInView()
		.environmentObject(AuthViewModel())
}
