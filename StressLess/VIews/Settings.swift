//
//  Settings.swift
//  StressLess
//
//  Created by Xucheng Zhao on 10/27/24.
//

import SwiftUI

struct Settings: View {
    @ObservedObject var userStats: UserStats
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Breathing Exercise Settings")) {
                    Stepper("Overall Time: \(userStats.overallTime) seconds", value: $userStats.overallTime, in: 8...300)
                    Stepper("Inhale Time: \(userStats.inhaleTime) seconds", value: $userStats.inhaleTime, in: 1...userStats.overallTime - userStats.exhaleTime)
                    Stepper("Exhale Time: \(userStats.exhaleTime) seconds", value: $userStats.exhaleTime, in: 1...userStats.overallTime - userStats.inhaleTime)
                }
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        userStats.saveStats()
                        dismiss()
                    }
                }
            }
        }
    }
}
