//
//  RechargeOptions.swift
//  StressLess
//
//  Created by Xucheng Zhao on 10/27/24.
//

import SwiftUI

struct RechargeOptions: View {
    @ObservedObject var userStats: UserStats
    @Environment(\.presentationMode) var presentationMode
    @Binding var isOnHomeScreen: Bool

    var body: some View {
        NavigationView {
            List {
                // Option for Breathing Exercise
                NavigationLink(destination: BreathingExercise(userStats: userStats, isOnHomeScreen: $isOnHomeScreen)) {
                    HStack {
                        Image(systemName: "lungs.fill")
                            .foregroundColor(.blue)
                            .font(.system(size: 25))
                        VStack(alignment: .leading) {
                            Text("Breathing Exercise")
                                .font(.headline)
                            Text("A guided breathing exercise to help you relax.")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                }
                
                // Additional activities can be added here in the future
            }
            .navigationTitle("Options")
        }
    }
}
