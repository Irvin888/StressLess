//
//  ContentView.swift
//  StressLess
//
//  Created by Xucheng Zhao on 10/15/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var userStats = UserStats()
    @StateObject private var userProfile = UserProfile()
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
                    
                    if userProfile.isLoggedIn == true {
                        // Middle Section (Progress Tracking)
                        VStack(alignment: .leading, spacing: 30) {
                            // Recharge Streak with energy icon
                            HStack {
                                Image(systemName: "battery.100.bolt")
                                    .foregroundColor(.yellow)
                                    .font(.system(size: 22, weight: .medium))
                                Text("Recharge Streak: \(userStats.rechargeStreak) days")
                                    .font(.system(size: 22, weight: .medium, design: .rounded))
                                    .foregroundColor(.white)
                                    .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 1)
                            }
                            
                            // Mood Tracking with heart circle icon
                            HStack {
                                Image(systemName: "heart.circle.fill")
                                    .foregroundColor(.red)
                                    .font(.system(size: 22, weight: .medium))
                                Text(userStats.moodTrendText)
                                    .font(.system(size: 22, weight: .medium, design: .rounded))
                                    .foregroundColor(.white)
                                    .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 1)
                            }
                            
                            // Last Recharge Activity with meditative figure icon
                            HStack {
                                Image(systemName: "figure.mind.and.body")
                                    .foregroundColor(.blue)
                                    .font(.system(size: 22, weight: .medium))
                                Text("Last Time: \(userStats.lastRechargeText)")
                                    .font(.system(size: 22, weight: .medium, design: .rounded))
                                    .foregroundColor(.white)
                                    .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 1)
                            }
                            
                            // Weekly Summary with red calendar icon
                            HStack {
                                Image(systemName: "calendar.circle.fill")
                                    .foregroundColor(.red)
                                    .font(.system(size: 22, weight: .medium))
                                Text(userStats.weeklySummaryText)
                                    .font(.system(size: 22, weight: .medium, design: .rounded))
                                    .foregroundColor(.white)
                                    .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 1)
                            }
                        }
                        .padding(.horizontal, 30)
                        .padding(.top, 40)
                    } else {
                        Text("Plase login to view your stats.").font(.title)
                    }
                    
                    Spacer()
                    
                    // Bottom Section: Navigation Hub (Profile, Recharge Yourself, Settings)
                    HStack {
                        Spacer()
                        
                        // Profile Icon with color
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
                        
                        // Recharge Yourself Icon with color, stacked text
                        VStack(spacing: 12) {
                            Button(action: {
                                if userProfile.isLoggedIn == true{
                                    isOnHomeScreen = false
                                    showRechargeOptions.toggle()
                                }
                            }) {
                                Image(systemName: "bolt.fill")
                                    .font(.system(size: 50))
                                    .foregroundColor(.green)
                            }
                            .sheet(isPresented: $showRechargeOptions) {
                                RechargeOptions(userStats: userStats, isOnHomeScreen: $isOnHomeScreen)
                            }
                            Text("Recharge")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                            Text("Yourself")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                        }
                        
                        Spacer()
                        
                        // Settings Icon with color
                        VStack(spacing: 12) {
                            Button(action: {
                                if userProfile.isLoggedIn == true{
                                    showSettings.toggle()
                                }
                            }) {
                                Image(systemName: "gearshape.fill")
                                    .font(.system(size: 50))
                                    .foregroundColor(.gray)
                                    .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 2)
                            }
                            .sheet(isPresented: $showSettings) {
                                Settings()
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
            if  isOnHomeScreen == true {
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
