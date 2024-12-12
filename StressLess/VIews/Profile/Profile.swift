//
//  Profile.swift
//  StressLess
//
//  Created by Xucheng Zhao on 10/27/24.
//

import SwiftUI

struct Profile: View {
    @ObservedObject var userProfile: UserProfile
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                if userProfile.isLoggedIn {
                    Text("Welcome, \(userProfile.username)!")
                        .font(.title)
                        .fontWeight(.semibold)
                        .padding(.top, 175)
                    
                    NavigationLink("Edit Profile", destination: EditProfile(userProfile: userProfile))
                        .font(.headline)
                        .padding()
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(8)
                    
                    Button(action: {
                        handleLogout()
                    }) {
                        Text("Log Out")
                            .font(.headline)
                            .foregroundColor(.red)
                            .padding()
                            .background(Color.red.opacity(0.1))
                            .cornerRadius(8)
                    }
                } else {
                    Text("Please log in to enable personalized content.")
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .padding(.top, 175)
                    
                    NavigationLink("Log In / Create Account", destination: Login(userProfile: userProfile))
                        .padding()
                        .font(.headline)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(8)
                }
                Spacer()
            }
            .padding()
        }
    }
    
    // MARK: - Logout Handling
    private func handleLogout() {
        userProfile.logout()
        userProfile.username = ""  // Clear username
        userProfile.password = ""  // Clear password
        dismiss()
    }
    
}
