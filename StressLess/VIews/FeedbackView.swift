import SwiftUI

struct FeedbackView: View {
    var exercise: String
    @ObservedObject var userStats: UserStats
    @Binding var isOnHomeScreen: Bool
    
    // New state variables for additional feedback questions
    @State private var stressLevelBefore: Double = 0
    @State private var stressLevelAfter: Double = 0
    @State private var helpfulnessRating: Int = 1
    @State private var overallExperienceRating: Int = 1
    
    var body: some View {
        VStack {
            Spacer()
            
            // Top section: Question text
            Text("How do you feel after this exercise?")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.top, 40)
                .padding(.bottom, 30) // Add extra space below the question
            
            Spacer() // Push buttons to the middle/lower section

            // Section for rating stress levels (before and after)
            VStack(spacing: 20) {
                Text("Stress level before exercise:")
                    .font(.headline)
                    .foregroundColor(.gray)
                
                Slider(value: $stressLevelBefore, in: 0...10, step: 1)
                    .accentColor(.blue)
                    .padding()
                
                Text("Stress level after exercise:")
                    .font(.headline)
                    .foregroundColor(.gray)
                
                Slider(value: $stressLevelAfter, in: 0...10, step: 1)
                    .accentColor(.blue)
                    .padding()
            }
            
            // Section for helpfulness and overall experience ratings
            VStack(spacing: 20) {
                Text("How helpful was this session in reducing stress?")
                    .font(.headline)
                    .foregroundColor(.gray)
                
                Picker("Helpfulness", selection: $helpfulnessRating) {
                    Text("Not Helpful").tag(1)
                    Text("Somewhat Helpful").tag(2)
                    Text("Very Helpful").tag(3)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                Text("Overall experience:")
                    .font(.headline)
                    .foregroundColor(.gray)
                
                Picker("Experience", selection: $overallExperienceRating) {
                    Text("Poor").tag(1)
                    Text("Neutral").tag(2)
                    Text("Good").tag(3)
                    Text("Great").tag(4)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
            }
            
            // Submit button
            Button(action: {
                submitFeedback()
            }) {
                Text("Submit Feedback")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [.blue.opacity(0.8), .purple.opacity(0.8)]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(12)
                    .shadow(color: .purple.opacity(0.3), radius: 8, x: 0, y: 4)
            }
            .padding(.bottom, 50)
        }
        .padding(.bottom, 150)
        .navigationBarBackButtonHidden(true)
    }
    
    private func submitFeedback() {
        // Calculate the stress change percentage based on user input
        userStats.calculateStressChangePercentage(S_before: stressLevelBefore, S_after: stressLevelAfter, helpfulness: helpfulnessRating, overallRating: overallExperienceRating)
        
        // Update statistics
        userStats.updateLastRecharge(with: exercise + " Exercise")
        userStats.incrementWeeklyExerciseCount(for: exercise)
        
        // Set the flag to navigate back to the home screen
        isOnHomeScreen = true
    }
}
