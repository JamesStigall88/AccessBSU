//
//  AuthSignUpView.swift
//  AccessBSU
//
//  Created by Jaylen Smith on 3/11/25.
//

import SwiftUI

struct AuthSignUpView: View {
	
	@State private var presentSignUpFailedAlert: Bool = false
	@State private var isSigningUp: Bool = false
	
	@State private var email: String = ""
	@State private var password: String = ""
	
	@EnvironmentObject var authVM: AuthViewModel
	
	var body: some View {
		NavigationStack {
			VStack(spacing: 30) {
				Text("Create An Account")
					.font(.system(size: 20).bold())
				VStack(spacing: 5) {
					emailTextField
					passwordTextField
				}
				.textFieldStyle(.roundedBorder)
				createAccountButton
			}
			.navigationBarBackButtonHidden(isSigningUp)
			.padding()
			.alert("Unable to create account", isPresented: $presentSignUpFailedAlert) {
				Button("OK") {}
			} message: {
				Text("Please try again.")
			}
			.task(id: isSigningUp) {
				if isSigningUp {
					await signUp()
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
	private var createAccountButton: some View {
		switch isSigningUp {
		case true:
			ProgressView()
		case false:
			Button("Create Account") {
				self.isSigningUp.toggle()
			}
			.buttonStyle(.borderedProminent)
		}
	}
	
	private func signUp() async {
		defer {
			self.isSigningUp = false
		}
		
		do {
			try await authVM.createAccount(with: email, password: password)
		} catch {
			self.presentSignUpFailedAlert.toggle()
		}
	}
}

#Preview {
    AuthSignUpView()
}
