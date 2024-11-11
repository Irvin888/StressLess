//
//  Login.swift
//  StressLess
//
//  Created by Xucheng Zhao on 11/10/24.
//

import SwiftUI

struct Login: View {
    @ObservedObject var userProfile: UserProfile
    @State private var inputUsername: String = ""
    @State private var inputPassword: String = ""
    @State private var confirmPassword: String = ""
    @State private var showConfirmPasswordField = false
    @State private var errorMessage: String = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Login / Create Account")
                .font(.largeTitle)
            
            TextField("Username", text: $inputUsername)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            SecureField("Password", text: $inputPassword)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            // Conditionally show confirm password field for new users
            if showConfirmPasswordField {
                SecureField("Confirm Password", text: $confirmPassword)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.footnote)
            }
            
            Button("Enter") {
                // Validate username and password input
                guard isValidInput(inputUsername), isValidInput(inputPassword) else {
                    errorMessage = "Please enter valid username and password."
                    return
                }
                
                // Check if a new user needs to be created
                if userProfile.username.isEmpty {
                    // New user: Confirm password
                    if !showConfirmPasswordField {
                        showConfirmPasswordField = true
                    } else if inputPassword == confirmPassword {
                        // Set username and hashed password for new user
                        userProfile.username = inputUsername
                        userProfile.password = UserProfile.hashPassword(inputPassword)
                        userProfile.login()
                        errorMessage = ""
                        dismiss()
                    } else {
                        errorMessage = "Passwords do not match. Please try again."
                    }
                } else {
                    // Existing user: validate credentials
                    if userProfile.username == inputUsername && userProfile.validatePassword(inputPassword: inputPassword) {
                        userProfile.login()
                        errorMessage = ""
                        dismiss()
                    } else {
                        errorMessage = "Incorrect username or password. Please try again."
                    }
                }
            }
            .padding()
            .background(Color.blue.opacity(0.2))
            .cornerRadius(8)
        }
        .padding()
    }
    
    // Helper function to check if input is non-empty and not only whitespace
    private func isValidInput(_ input: String) -> Bool {
        return !input.trimmingCharacters(in: .whitespaces).isEmpty
    }
}

