//
//  EditProfile.swift
//  StressLess
//
//  Created by Xucheng Zhao on 11/10/24.
//
import SwiftUI

struct EditProfile: View {
    @ObservedObject var userProfile: UserProfile
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Text("Nothing for now")
                .font(.largeTitle)
                .padding()

        }
    }
}

