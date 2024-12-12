//
//  ContentView.swift
//  StressLess
//
//  Created by Xucheng Zhao on 10/15/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var userProfile = UserProfile()
    @State private var showRechargeOptions = false
    @State private var showProfile = false
    @State private var showSettings = false
    @State private var isOnHomeScreen = true

    var body: some View {
        NavigationView {
            ZStack {
                DynamicBackgroundView()
                SunAndMoonView()

                VStack {
                    Spacer()

                    // Middle section: Show only if logged in and userStats exists
                    if userProfile.isLoggedIn, let stats = userProfile.userStats {
                        VStack(alignment: .leading, spacing: 30) {
                            // Recharge Streak
                            HStack {
                                Image(systemName: "battery.100.bolt")
                                    .foregroundColor(.yellow)
                                    .font(.system(size: 22, weight: .medium))
                                Text("Recharge Streak: \(stats.rechargeStreak) days")
                                    .font(.system(size: 22, weight: .medium, design: .rounded))
                                    .foregroundColor(.white)
                                    .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 1)
                            }

                            // Mood Tracking
                            HStack {
                                Image(systemName: "heart.circle.fill")
                                    .foregroundColor(.red)
                                    .font(.system(size: 22, weight: .medium))
                                Text(stats.moodTrendText)
                                    .font(.system(size: 22, weight: .medium, design: .rounded))
                                    .foregroundColor(.white)
                                    .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 1)
                            }

                            // Last Recharge Activity
                            HStack {
                                Image(systemName: "figure.mind.and.body")
                                    .foregroundColor(.blue)
                                    .font(.system(size: 22, weight: .medium))
                                Text("Last Activity: \(stats.lastRechargeText)")
                                    .font(.system(size: 22, weight: .medium, design: .rounded))
                                    .foregroundColor(.white)
                                    .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 1)
                            }

                            // Weekly Summary
                            HStack {
                                Image(systemName: "calendar.circle.fill")
                                    .foregroundColor(.red)
                                    .font(.system(size: 22, weight: .medium))
                                Text(stats.weeklySummaryText)
                                    .font(.system(size: 22, weight: .medium, design: .rounded))
                                    .foregroundColor(.white)
                                    .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 1)
                            }
                        }
                        .padding(.horizontal, 30)
                        .padding(.top, 40)
                    } else {
                        // User not logged in OR userStats not yet loaded
                        Text("Please login to view your stats.")
                            .font(.title)
                            .foregroundColor(.white)
                            .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 1)
                            .padding(.top, 40)
                    }

                    Spacer()

                    // Bottom Section: Navigation Hub (Profile, Recharge Yourself, Settings)
                    HStack {
                        Spacer()

                        // Profile: Always accessible
                        VStack(spacing: 12) {
                            Button(action: {
                                showProfile.toggle()
                            }) {
                                Image(systemName: "person.fill")
                                    .font(.system(size: 50))
                                    .foregroundColor(.blue)
                                    .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 2)
                            }
                            .sheet(isPresented: $showProfile) {
                                Profile(userProfile: userProfile)
                            }
                            Text("Profile")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                        }

                        Spacer()

                        // Recharge: Only enabled if logged in and userStats is available
                        VStack(spacing: 12) {
                            Button(action: {
                                if userProfile.isLoggedIn, userProfile.userStats != nil {
                                    isOnHomeScreen = false
                                    showRechargeOptions.toggle()
                                }
                            }) {
                                Image(systemName: "bolt.fill")
                                    .font(.system(size: 50))
                                    .foregroundColor(userProfile.isLoggedIn && userProfile.userStats != nil ? .green : .gray)
                            }
                            .disabled(!(userProfile.isLoggedIn && userProfile.userStats != nil))
                            .sheet(isPresented: $showRechargeOptions) {
                                // Safe unwrap again before presenting
                                if let stats = userProfile.userStats {
                                    RechargeOptions(userStats: stats, isOnHomeScreen: $isOnHomeScreen)
                                } else {
                                    Text("No stats available.")
                                }
                            }
                            Text("Recharge")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                            Text("Yourself")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                        }

                        Spacer()

                        // Settings: Only enabled if logged in and userStats is available
                        VStack(spacing: 12) {
                            Button(action: {
                                if userProfile.isLoggedIn && userProfile.userStats != nil {
                                    showSettings.toggle()
                                }
                            }) {
                                Image(systemName: "gearshape.fill")
                                    .font(.system(size: 50))
                                    .foregroundColor(userProfile.isLoggedIn && userProfile.userStats != nil ? .gray : .gray.opacity(0.4))
                                    .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 2)
                            }
                            .disabled(!(userProfile.isLoggedIn && userProfile.userStats != nil))
                            .sheet(isPresented: $showSettings) {
                                // Safe unwrap again before presenting
                                if let stats = userProfile.userStats {
                                    Settings(userStats: stats)
                                } else {
                                    Text("No stats available.")
                                }
                            }
                            Text("Settings")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                        }

                        Spacer()
                    }
                    .padding(.bottom, 25)
                }
            }
        }
        .onChange(of: isOnHomeScreen) {
            if isOnHomeScreen == true {
                showRechargeOptions = false
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
