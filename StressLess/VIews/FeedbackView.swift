//
//  FeedbackView.swift
//  StressLess
//
//  Created by Xucheng Zhao on 10/28/24.
//

import SwiftUI

struct FeedbackView: View {
    @ObservedObject var userStats: UserStats
    @Binding var isOnHomeScreen: Bool
    
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
            
            // Feedback buttons
            VStack(spacing: 30) { // Increase space between buttons
                ForEach(FeedbackOption.allCases, id: \.self) { option in
                    Button(action: {
                        submitFeedback(option)
                    }) {
                        HStack {
                            Text(option.emoji)
                                .font(.title2)
                                .frame(width: 30, alignment: .leading)

                            Text(option.rawValue)
                                .font(.title3)
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .frame(width: 250, height: 50) // Fixed width and height for uniform button size
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
                }
            }
            Spacer()
        }
        .padding(.bottom, 150)
        .navigationBarBackButtonHidden(true)
    }
    
    private func submitFeedback(_ option: FeedbackOption) {
        userStats.updateLastRecharge(with: "Breathing Exercise")
        userStats.incrementWeeklyExerciseCount(for: "Breathing")
        userStats.adjustStressLevel(feedback: option.rawValue)
        userStats.resetWeeklyCountsIfNewWeek()
        
        // Set the flag to navigate back to the home screen
        isOnHomeScreen = true
    }
}

struct FeedbackView_Previews: PreviewProvider {
    static var previews: some View {
        let mockStats = UserStats()
        FeedbackView(userStats: mockStats, isOnHomeScreen: .constant(false))
    }
}

// Enum to handle feedback options with emoji icons
enum FeedbackOption: String, CaseIterable {
    case muchBetter = "     Much Better"
    case better = "           Better"
    case same = "           Same"
    case worse = "           Worse"
    case muchWorse = "     Much Worse"
    
    // Emoji for each feedback option
    var emoji: String {
        switch self {
        case .muchBetter:
            return "😊"
        case .better:
            return "🙂"
        case .same:
            return "😐"
        case .worse:
            return "😕"
        case .muchWorse:
            return "😞"
        }
    }
}

