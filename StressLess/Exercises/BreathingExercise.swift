//
//  BreathingExercise.swift
//  StressLess
//
//  Created by Xucheng Zhao on 10/27/24.
//

import SwiftUI
import UIKit

struct BreathingExercise: View {
    @ObservedObject var userStats: UserStats
    @Binding var isOnHomeScreen: Bool

    // Removed @State properties for breathing times
    // Instead, use values from userStats

    @State private var navigateToFeedback = false
    @State private var isInhaling = true
    @State private var shapeScale: CGFloat = 1.0
    @State private var timerRunning = false
    @State private var timeRemaining: Int = 60 // Will be set based on userStats

    @Environment(\.scenePhase) private var scenePhase

    // Animation settings based on userStats
    private var inhaleDuration: Double { Double(userStats.inhaleTime) }
    private var exhaleDuration: Double { Double(userStats.exhaleTime) }
    private var overallDuration: Int { userStats.overallTime }

    var body: some View {
        NavigationStack {
            ZStack {
                // Background gradient changes based on breathing phase (inhale/exhale)
                LinearGradient(
                    gradient: Gradient(colors: [isInhaling ? .teal : .purple, Color.white]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .opacity(0.3)
                .animation(.easeInOut(duration: isInhaling ? inhaleDuration : exhaleDuration), value: isInhaling)
                .ignoresSafeArea()

                VStack {
                    Spacer()

                    ZStack {
                        Circle()
                            .fill(Color.blue.opacity(0.6))
                            .frame(width: 200 * shapeScale, height: 200 * shapeScale)
                            .animation(.easeInOut(duration: isInhaling ? inhaleDuration : exhaleDuration), value: shapeScale)

                        Text("\(timeRemaining) s")
                            .font(.title)
                            .foregroundColor(.white)
                            .onAppear {
                                timeRemaining = overallDuration
                                shapeScale = 1.0
                            }
                    }
                    .onTapGesture {
                        if !timerRunning {
                            startBreathingSession()
                        }
                    }

                    Text(isInhaling ? "Breathe in..." : "Breathe out...")
                        .font(.largeTitle)
                        .foregroundColor(Color.gray)
                        .padding(.top, -5)
                        .offset(y: shapeScale * 100 - 100)

                    Spacer()

                    Button(action: {
                        if timerRunning {
                            pauseBreathingSession()
                        } else {
                            startBreathingSession()
                        }
                    }) {
                        Text(timerRunning ? "Pause" : "Start")
                            .font(.title2)
                            .padding()
                            .background(timerRunning ? Color.yellow : Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(15)
                            .shadow(radius: 5)
                    }
                    .padding(.bottom, 150)
                    .navigationDestination(isPresented: .constant(timeRemaining <= 0 && !timerRunning)) {
                        FeedbackView(exercise: "Breathing", userStats: userStats, isOnHomeScreen: $isOnHomeScreen)
                    }
                    
                }
            }
        }
        .onAppear {
            // Initialize timeRemaining based on userStats
            timeRemaining = userStats.overallTime
        }
        .onChange(of: scenePhase) {
            if scenePhase == .background {
                pauseBreathingSession()
            }
        }
    }

    // MARK: - Breathing and Timer Logic
    func startBreathingSession() {
        timerRunning = true
        startBreathingAnimation()
        startTimer()
    }

    func pauseBreathingSession() {
        timerRunning = false
    }

    func startBreathingAnimation() {
        guard timerRunning else { return }
        withAnimation(.easeInOut(duration: isInhaling ? inhaleDuration : exhaleDuration)) {
            shapeScale = isInhaling ? 1.2 : 0.8
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + (isInhaling ? inhaleDuration : exhaleDuration)) {
            isInhaling.toggle()
            triggerHapticFeedback(forInhale: isInhaling)
            if timerRunning { startBreathingAnimation() }
        }
    }

    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if timeRemaining > 0 && timerRunning {
                timeRemaining -= 1
            } else {
                timer.invalidate()
                timerRunning = false
            }
        }
    }

    func triggerHapticFeedback(forInhale: Bool) {
        let generator = UIImpactFeedbackGenerator(style: forInhale ? .heavy : .light)
        generator.impactOccurred()
    }
}
