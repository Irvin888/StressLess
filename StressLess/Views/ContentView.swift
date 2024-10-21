//
//  ContentView.swift
//  StressLess
//
//  Created by Xucheng Zhao on 10/15/24.
//

import SwiftUI

struct ContentView: View {
    // Mock data for placeholders
    @State private var rechargeStreak = 3
    @State private var moodTrend = "Stress levels down 20% from last week"
    @State private var lastRecharge = "5-minute breathing exercise on Tuesday"
    @State private var weeklySummary = "This week: 3 recharge sessions, 45 minutes meditating"
    
    var body: some View {
        NavigationView {
            ZStack{
                DynamicBackgroundView()
                SunAndMoonView()
                
                VStack {
                    Spacer()
                    
                    // Middle Section (Progress Tracking)
                    VStack(alignment: .leading, spacing: 30) { // Increase spacing
                        // Recharge Streak with energy icon
                        HStack {
                            Image(systemName: "battery.100.bolt")
                                .foregroundColor(.yellow)
                                .font(.system(size: 22, weight: .medium)) // Slightly larger and medium weight
                            Text("Recharge Streak: \(rechargeStreak) days")
                                .font(.system(size: 22, weight: .medium, design: .rounded)) // Better visibility with increased size
                                .foregroundColor(.white)
                                .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 1)
                        }
                        
                        // Mood Tracking with heart circle icon
                        HStack {
                            Image(systemName: "heart.circle.fill")
                                .foregroundColor(.red)
                                .font(.system(size: 22, weight: .medium)) // Larger icon
                            Text(moodTrend)
                                .font(.system(size: 22, weight: .medium, design: .rounded)) // Larger text for better readability
                                .foregroundColor(.white)
                                .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 1)
                        }
                        
                        // Last Recharge Activity with meditative figure icon
                        HStack {
                            Image(systemName: "figure.mind.and.body")
                                .foregroundColor(.blue)
                                .font(.system(size: 22, weight: .medium))
                            Text("Last Recharge: \(lastRecharge)")
                                .font(.system(size: 22, weight: .medium, design: .rounded))
                                .foregroundColor(.white)
                                .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 1)
                        }
                        
                        // Weekly Summary with red calendar icon
                        HStack {
                            Image(systemName: "calendar.circle.fill")
                                .foregroundColor(.red) // Changed to red
                                .font(.system(size: 22, weight: .medium))
                            Text(weeklySummary)
                                .font(.system(size: 22, weight: .medium, design: .rounded))
                                .foregroundColor(.white)
                                .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 1)
                        }
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 40) // More padding to make the section bigger
                    
                    Spacer()
                    
                    // Bottom Section: Navigation Hub (Profile, Recharge Yourself, Settings)
                    HStack {
                        Spacer()
                        
                        // Profile Icon with color
                        VStack(spacing: 12) { // Increased spacing for separation
                            Button(action: {
                                print("Profile Tapped")
                            }) {
                                Image(systemName: "person.fill")
                                    .font(.system(size: 50)) // Larger, bolder icon
                                    .foregroundColor(.blue)  // Blue color for Profile
                                    .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 2) // Clickable emphasis
                            }
                            Text("Profile")
                                .font(.system(size: 20, weight: .bold)) // Larger text
                                .foregroundColor(.white)
                        }
                        
                        Spacer()
                        
                        // Recharge Yourself Icon with color, stacked text
                        VStack(spacing: 12) { // Increased spacing
                            Button(action: {
                                print("Recharge Yourself Tapped")
                            }) {
                                Image(systemName: "bolt.fill")
                                    .font(.system(size: 50)) // Larger, bolder icon
                                    .foregroundColor(.green)  // Green color for Recharge
                                    .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 2)
                            }
                            Text("Recharge")
                                .font(.system(size: 20, weight: .bold)) // Larger text
                                .foregroundColor(.white)
                            Text("Yourself")
                                .font(.system(size: 20, weight: .bold)) // Larger text for second line
                                .foregroundColor(.white)
                        }
                        
                        Spacer()
                        
                        // Settings Icon with color
                        VStack(spacing: 12) { // Increased spacing
                            Button(action: {
                                print("Settings Tapped")
                            }) {
                                Image(systemName: "gearshape.fill")
                                    .font(.system(size: 50)) // Larger, bolder icon
                                    .foregroundColor(.gray)  // Gray color for Settings
                                    .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 2)
                            }
                            Text("Settings")
                                .font(.system(size: 20, weight: .bold)) // Larger text
                                .foregroundColor(.white)
                        }
                        
                        Spacer()
                    }
                    .padding(.bottom, 25) // Increased padding for better spacing
                    
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
            ContentView() // Wrap the ContentView inside MainView to get the background
    }
}

