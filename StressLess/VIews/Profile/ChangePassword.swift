//
//  ChangePassword.swift
//  StressLess
//
//  Created by Xucheng Zhao on 11/10/24.
//

import SwiftUI

import SwiftUI

struct ChangePassword: View {
    @Binding var userProfile: UserProfile
    @State private var oldPassword: String = ""
    @State private var newPassword: String = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Text("Change Password")
                .font(.largeTitle)
                .padding()
            
            SecureField("Old Password", text: $oldPassword)
                .padding()
            
            SecureField("New Password", text: $newPassword)
                .padding()
            
            Button("Change Password") {
                if userProfile.validatePassword(inputPassword: oldPassword) {
                    userProfile.password = UserProfile.hashPassword(newPassword)
                    print("Password changed successfully")
                    dismiss()
                } else {
                    print("Incorrect old password")
                }
            }
            .padding()
        }
    }
}

