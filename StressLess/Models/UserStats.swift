//
//  UserStats.swift
//  StressLess
//
//  Created by Xucheng Zhao on 10/27/24.
//

import Foundation

class UserStats: ObservableObject {
    // Properties for tracking
    @Published var rechargeStreak = 0
    @Published var stressLevel: Double = 1.0
    @Published var lastActivityDate: Date? = nil
    @Published var lastRecharge: String = "None for this week"
    @Published var weeklyExerciseCounts: [String: Int] = [:]
    
    // Computed properties for UI
    var moodTrendText: String {
        let percentageChange = ((stressLevel - 1.0) / 1.0) * 100
        if percentageChange <= 0 {
            return "Stress level down \(Int(percentageChange * -1))% today"
        } else {
            return "Stress level up \(Int(percentageChange))% today"
        }
    }
    
    var lastRechargeText: String {
        return lastRecharge
    }
    
    var weeklySummaryText: String {
        let sessions = weeklyExerciseCounts.values.reduce(0, +)
        let details = weeklyExerciseCounts.map { "\($0.key): \($0.value)" }.joined(separator: ", ")
        return "This week: \(sessions) sessions (\(details))"
    }
    
    // Methods for tracking
    
    // Increment recharge streak if activity is done on a new day
    func incrementStreakIfNewDay() {
        let today = Calendar.current.startOfDay(for: Date())
        
        if lastActivityDate == today {
            return
        }
        
        // Reset if it’s been more than a day since the last activity
        if let lastDate = lastActivityDate, lastDate < today {
            rechargeStreak += 1
        } else if lastActivityDate == nil || lastActivityDate! < Calendar.current.date(byAdding: .day, value: -1, to: today)! {
            rechargeStreak = 0 // reset streak if no activity yesterday
        }
        
        lastActivityDate = Date()
    }
    
    // Adjust stress level based on user feedback
    func adjustStressLevel(feedback: String) {
        switch feedback {
        case "     Much Better":
            stressLevel -= 0.2
        case "           Better":
            stressLevel -= 0.1
        case "           Same":
            stressLevel = stressLevel
        case "           Worse":
            stressLevel += 0.1
        case "     Much Worse":
            stressLevel += 0.2
        default:
            break
        }
        
        // Keep stress level within a reasonable range
        stressLevel = max(0.5, min(stressLevel, 1.5))
    }
    
    // Update the last recharge activity text
    func updateLastRecharge(with type: String) {
        lastRecharge = "\(type) on \(formattedDate(Date()))"
        incrementStreakIfNewDay()
    }
    
    // Increment the count of an exercise type for weekly summary
    func incrementWeeklyExerciseCount(for type: String) {
        weeklyExerciseCounts[type, default: 0] += 1
    }
    
    // Reset weekly counts if it's a new week
    func resetWeeklyCountsIfNewWeek() {
        let startOfWeek = Calendar.current.date(from: Calendar.current.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
        if let lastDate = lastActivityDate, lastDate < startOfWeek {
            weeklyExerciseCounts = [:]
        }
    }
    
    // Utility to format dates
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE" // Example: "Tuesday"
        return formatter.string(from: date)
    }
}

