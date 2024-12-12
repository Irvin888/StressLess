// EditProfile.swift
// StressLess

// Created by Xucheng Zhao on 11/10/24.

import SwiftUI

struct EditProfile: View {
    @ObservedObject var userProfile: UserProfile
    @Environment(\.dismiss) private var dismiss
    @State private var showClearDataConfirmation = false
    @State private var showDeleteAccountConfirmation = false

    var body: some View {
        Form {

            Section(header: Text("Advanced Settings")) {
                Button("Clear User Data") {
                    showClearDataConfirmation = true
                }
                Button("Delete Account") {
                    showDeleteAccountConfirmation = true
                }
                .foregroundColor(.red) // Optional: Red color for emphasis
            }
        }
        .navigationTitle("Edit Profile")
        .alert("Clear User Data", isPresented: $showClearDataConfirmation) {
            Button("Clear", role: .destructive) {
                clearUserData()
            }
            Button("Cancel", role: .cancel) {
            }
        } message: {
            Text("Are you sure you want to clear all your user data? This action cannot be undone.")
        }
        .alert("Delete Account", isPresented: $showDeleteAccountConfirmation) {
            Button("Delete", role: .destructive) {
                deleteAccount()
                dismiss()
            }
            Button("Cancel", role: .cancel) {
            }
        } message: {
            Text("Are you sure you want to delete your account? This action cannot be undone.")
        }
    }

    private func clearUserData() {
        userProfile.userStats?.resetStats()
        if userProfile.fetchUser(byUsername: userProfile.username) {
            print("User stats fetched and updated successfully.")
        } else {
            print("Error fetching user stats after reset.")
        }
        dismiss()
    }

    private func deleteAccount() {
        userProfile.clearUserData()
        dismiss()
    }
}
