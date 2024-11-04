//
//  BreathingExercise.swift
//  StressLess
//
//  Created by Xucheng Zhao on 10/27/24.
//

import SwiftUI

struct BreathingExercise: View {
    @ObservedObject var userStats: UserStats
    @Binding var isOnHomeScreen: Bool
    @State private var navigateToFeedback = false
    @State private var isInhaling = true
    @State private var shapeScale: CGFloat = 1.0
    @State private var timerRunning = false
    @State private var timeRemaining = 2  // Set to short time for testing

    // Animation settings
    private let inhaleDuration: Double = 4
    private let exhaleDuration: Double = 5

    var body: some View {
        NavigationStack {
            ZStack {
                // Background color with gradient for soothing breathing effect
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

                    // Expanding/Contracting Shape with Timer
                    ZStack {
                        Circle()
                            .fill(Color.blue.opacity(0.6))
                            .frame(width: 200 * shapeScale, height: 200 * shapeScale)
                            .animation(.easeInOut(duration: isInhaling ? inhaleDuration : exhaleDuration), value: shapeScale)

                        // Timer in the center of the shape
                        Text("\(timeRemaining) s")
                            .font(.title)
                            .foregroundColor(.white)
                            .onAppear {
                                // Initialize the breathing animation but do not start until user clicks "Start"
                                shapeScale = 1.0
                            }
                    }
                    .onTapGesture {
                        if !timerRunning {
                            startBreathingSession()
                        }
                    }

                    // Moving Guide Text
                    Text(isInhaling ? "Breathe in..." : "Breathe out...")
                        .font(.largeTitle)
                        .foregroundColor(Color.gray)
                        .padding(.top, -5)
                        .offset(y: shapeScale * 100 - 100)  // Moves with shape scale

                    Spacer()

                    // Start/Pause Button
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

                    .navigationDestination(isPresented: .constant(timeRemaining <= 0 && !timerRunning)){
                        FeedbackView(userStats: userStats, isOnHomeScreen: $isOnHomeScreen)
                    }
                
                }
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

        // Toggle between inhale and exhale animations
        withAnimation(.easeInOut(duration: isInhaling ? inhaleDuration : exhaleDuration)) {
            shapeScale = isInhaling ? 1.2 : 0.8
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + (isInhaling ? inhaleDuration : exhaleDuration)) {
            isInhaling.toggle() // Switch between inhale and exhale
            if timerRunning { startBreathingAnimation() } // Continue animation if session is running
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
}

struct BreathingExercise_Previews: PreviewProvider {
    static var previews: some View {
        let mockStats = UserStats()
        BreathingExercise(userStats: mockStats, isOnHomeScreen: .constant(false))
    }
}
