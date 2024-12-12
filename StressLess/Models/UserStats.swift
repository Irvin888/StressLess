//
//  UserStats.swift
//  StressLess
//

import Foundation
import SwiftUI
import CoreData

class UserStats: ObservableObject {
    // Existing Properties for tracking
    @Published var rechargeStreak = 0
    @Published var stressLevel: Double = 0
    @Published var lastActivityDate: Date? = nil
    @Published var lastRecharge: String = "None for this week"
    @Published var weeklyExerciseCounts: [String: Int] = [:]
    
    // New Properties for Breathing Exercise
    @Published var overallTime: Int = 60 // Default: 60 seconds
    @Published var inhaleTime: Int = 4    // Default: 4 seconds
    @Published var exhaleTime: Int = 4    // Default: 4 seconds
    
    // Reference to Core Data container and the associated entity
    private let container: NSPersistentContainer
    private var userStatsEntity: UserStatsEntity?
    
    init(container: NSPersistentContainer) {
        self.container = container
    }
    
    // Computed properties for UI
    var moodTrendText: String {
        if stressLevel >= 0 {
            return "Stresslevel down \(Int(stressLevel))% last time"
        } else {
            return "Stresslevel up \(Int(-stressLevel))% last time"
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

    // MARK: - Load Stats for a Given User
    func loadStats(for user: UserEntity) {
        // Attempt to fetch existing UserStatsEntity for this user
        if let stats = user.stats {
            self.userStatsEntity = stats
            self.rechargeStreak = Int(stats.rechargeStreak)
            self.stressLevel = stats.stressLevel
            self.lastActivityDate = stats.lastActivityDate
            self.lastRecharge = stats.lastRecharge ?? "None for this week"
            
            // Decode weeklyExerciseCounts if stored as Data
            if let data = stats.weeklyExerciseCounts,
               let decoded = try? JSONDecoder().decode([String: Int].self, from: data) {
                self.weeklyExerciseCounts = decoded
            } else {
                self.weeklyExerciseCounts = [:]
            }
            
            // Load Breathing Exercise times, with default values if not set
            self.overallTime = Int(stats.overallTime)
            self.inhaleTime = Int(stats.inhaleTime)
            self.exhaleTime = Int(stats.exhaleTime)
        } else {
            // If no stats exist, create a new one
            let context = container.viewContext
            let newStats = UserStatsEntity(context: context)
            newStats.user = user
            self.userStatsEntity = newStats
            // Set default values
            self.overallTime = 60
            self.inhaleTime = 4
            self.exhaleTime = 4
            saveStats() // Save the newly created stats
        }
    }
    
    // MARK: - Save Stats
    func saveStats() {
        guard let stats = self.userStatsEntity else { return }
        
        stats.rechargeStreak = Int64(self.rechargeStreak)
        stats.stressLevel = self.stressLevel
        stats.lastActivityDate = self.lastActivityDate
        stats.lastRecharge = self.lastRecharge
        
        // Encode weeklyExerciseCounts into Data for storage
        if let data = try? JSONEncoder().encode(self.weeklyExerciseCounts) {
            stats.weeklyExerciseCounts = data
        }

        // Save Breathing Exercise times
        stats.overallTime = Int64(self.overallTime)
        stats.inhaleTime = Int64(self.inhaleTime)
        stats.exhaleTime = Int64(self.exhaleTime)

        do {
            try container.viewContext.save()
            print("User stats saved successfully.")
        } catch {
            print("Error saving user stats: \(error.localizedDescription)")
        }
    }

    // MARK: - Tracking Methods
    func incrementStreakIfNewDay() {
        let today = Calendar.current.startOfDay(for: Date())
        
        if lastActivityDate == today {
            return
        }
        
        // If lastActivityDate is before today, increment streak
        if let lastDate = lastActivityDate, lastDate < today {
            rechargeStreak += 1
        } else if lastActivityDate == nil ||
                    lastActivityDate! < Calendar.current.date(byAdding: .day, value: -1, to: today)! {
            // If it's been more than a day since last activity, reset streak
            rechargeStreak = 0
        }
        
        lastActivityDate = Date()
        saveStats()
    }
    
    func calculateStressChangePercentage(S_before: Double, S_after: Double, helpfulness: Int, overallRating: Int) {
        let stressReductionPercentage = ((S_before - S_after) * 0.5) * 10
        let W_helpful = 0.3
        let W_overall = 0.5
        let finalStressReduction = stressReductionPercentage + (W_helpful * Double(helpfulness)) + (W_overall * Double(overallRating))
        
        stressLevel = finalStressReduction
        saveStats()
    }
    
    func updateLastRecharge(with type: String) {
        lastRecharge = "\(type) on \(formattedDate(Date()))"
        incrementStreakIfNewDay()
        saveStats()
    }
    
    func incrementWeeklyExerciseCount(for type: String) {
        resetWeeklyCountsIfNewWeek()
        weeklyExerciseCounts[type, default: 0] += 1
        saveStats()
    }
    
    func resetWeeklyCountsIfNewWeek() {
        let startOfWeek = Calendar.current.date(from: Calendar.current.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
        if let lastDate = lastActivityDate, lastDate < startOfWeek {
            weeklyExerciseCounts = [:]
            saveStats()
        }
    }
    
    // Utility to format dates
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: date)
    }
    
    func resetStats() {
        self.rechargeStreak = 0
        self.stressLevel = 0.0
        self.lastActivityDate = nil
        self.lastRecharge = "None for this week"
        self.weeklyExerciseCounts = [:]
        self.overallTime = 60
        self.inhaleTime = 4
        self.exhaleTime = 4
        saveStats()
    }
}
