//
//  ContentView.swift
//  StressLess
//
//  Created by Xucheng Zhao on 10/15/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            // Upper Section: Go Back Button and Motivational Phrase
            HStack {
                Button(action: {
                    // Action for the back button
                    print("Go back")
                }) {
                    Image(systemName: "chevron.backward")
                        .font(.title)
                        .foregroundColor(.blue)
                }
                Spacer()
                Text("You got this!")
                    .font(.headline)
                    .foregroundColor(.gray)
                Spacer()
            }
            .padding()

            Spacer() // Space between sections

            // Middle Section: Progress Tracking
            VStack {
                Text("Progress Tracker")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .padding(.bottom, 20)
                
                // Example Progress Bar
                ProgressView(value: 0.6)
                    .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                    .scaleEffect(x: 1, y: 4, anchor: .center)
                    .padding(.horizontal, 30)
                
                // Placeholder for additional personalized content
                Text("Your personalized content here")
                    .padding(.top, 40)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal)

            Spacer() // Space between sections

            // Lower Section: Navigation Hub
            HStack {
                Spacer()
                
                // Stress Management Button
                VStack {
                    Button(action: {
                        print("Stress Management Tapped")
                    }) {
                        Image(systemName: "leaf.fill")
                            .font(.largeTitle)
                            .foregroundColor(.green)
                    }
                    Text("Manage Stress")
                        .font(.footnote)
                }
                Spacer()
                
                // Profile Button
                VStack {
                    Button(action: {
                        print("Profile Tapped")
                    }) {
                        Image(systemName: "person.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.blue)
                    }
                    Text("Profile")
                        .font(.footnote)
                }
                Spacer()
                
                // Settings Button
                VStack {
                    Button(action: {
                        print("Settings Tapped")
                    }) {
                        Image(systemName: "gearshape.fill")
                            .font(.largeTitle)
                            .foregroundColor(.gray)
                    }
                    Text("Settings")
                        .font(.footnote)
                }
                
                Spacer()
            }
            .padding(.bottom, 20)
        }
        .background(Color(.systemGray6)) // Optional background color
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
