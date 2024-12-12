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
                handleLoginOrRegistration()
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
    
    private func handleLoginOrRegistration() {
        // Validate username and password input
        guard isValidInput(inputUsername), isValidInput(inputPassword) else {
            errorMessage = "Please enter valid username and password."
            return
        }
        
        if showConfirmPasswordField {
            // New user: Register
            if inputPassword == confirmPassword {
                userProfile.username = inputUsername
                userProfile.password = UserProfile.hashPassword(inputPassword)
                
                // Save user to Core Data
                userProfile.saveUser()
                userProfile.login()
                print("login successful")
                errorMessage = ""
                dismiss()
            } else {
                errorMessage = "Passwords do not match. Please try again."
            }
        } else {
            // Attempt to fetch user from Core Data
            if userProfile.fetchUser(byUsername: inputUsername) {
                // Existing user: Validate password
                if userProfile.validatePassword(inputPassword: inputPassword) {
                    userProfile.login()
                    print("login successful")
                    errorMessage = ""
                    dismiss()
                } else {
                    errorMessage = "Incorrect username or password. Please try again."
                }
            } else {
                // New user: Prompt for confirmation
                showConfirmPasswordField = true
                errorMessage = "New user detected. Please confirm your password."
            }
        }
    }
}
