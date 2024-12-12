//
//  UserProfile.swift
//  StressLess
//

import Foundation
import CryptoKit
import SwiftUI
import CoreData

class UserProfile: ObservableObject {
    let id = UUID()
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isLoggedIn: Bool = false

    private let container: NSPersistentContainer
    @Published var userStats: UserStats?

    init() {
        container = NSPersistentContainer(name: "StressLessModel")

        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let storeURL = documentsDirectory.appendingPathComponent("StressLessModel.sqlite")

        // For production, comment out the clearDatabase line:
        // clearDatabase(at: storeURL)

        let description = NSPersistentStoreDescription(url: storeURL)
        container.persistentStoreDescriptions = [description]

        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading Core Data: \(error.localizedDescription)")
            } else {
                print("Core Data loaded successfully at: \(description.url?.absoluteString ?? "Unknown URL")")
            }
        }

        restoreUserState()
    }

    private func clearDatabase(at url: URL) {
        let fileManager = FileManager.default
        do {
            if fileManager.fileExists(atPath: url.path) {
                try fileManager.removeItem(at: url)
                print("Database file cleared at: \(url.path)")
            }
        } catch {
            print("Error clearing database: \(error.localizedDescription)")
        }
    }

    private func restoreUserState() {
        let defaults = UserDefaults.standard
        self.username = defaults.string(forKey: "username") ?? ""
        self.isLoggedIn = defaults.bool(forKey: "isLoggedIn")
        print("Restored user state: username = \(username), isLoggedIn = \(isLoggedIn)")

        if isLoggedIn && !username.isEmpty {
            // Attempt to load user and their stats
            if fetchUser(byUsername: username) {
                // userStats is loaded in fetchUser if the user is found
            }
        }
    }

    func saveUserState() {
        let defaults = UserDefaults.standard
        defaults.setValue(self.username, forKey: "username")
        defaults.setValue(self.isLoggedIn, forKey: "isLoggedIn")
        print("Saved user state: username = \(username), isLoggedIn = \(isLoggedIn)")
    }

    static func hashPassword(_ password: String) -> String {
        let data = Data(password.utf8)
        let hash = SHA256.hash(data: data)
        return hash.compactMap { String(format: "%02x", $0) }.joined()
    }

    /// Creates and saves a new user along with a default UserStatsEntity.
    func saveUser() {
        let context = container.viewContext
        let newUser = UserEntity(context: context)
        newUser.username = self.username
        newUser.password = self.password

        // Create a corresponding UserStatsEntity with default values
        let newStats = UserStatsEntity(context: context)
        newStats.user = newUser
        newStats.rechargeStreak = 0
        newStats.stressLevel = 0.0
        newStats.lastActivityDate = nil
        newStats.lastRecharge = "None for this week"
        newStats.weeklyExerciseCounts = nil
        newStats.overallTime = 60
        newStats.exhaleTime = 4
        newStats.inhaleTime = 4

        do {
            try context.save()
            print("User and default stats saved successfully.")

            // Fetch the newly created user to update userStats
            if fetchUser(byUsername: self.username) {
                print("User stats fetched and updated successfully.")
            } else {
                print("Error fetching user stats after creation.")
            }
        } catch {
            print("Error saving user and stats: \(error.localizedDescription)")
        }
    }

    /// Fetches the user by username and initializes userStats if found.
    func fetchUser(byUsername username: String) -> Bool {
        let context = container.viewContext
        let request: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        request.predicate = NSPredicate(format: "username == %@", username)

        do {
            let users = try context.fetch(request)
            if let user = users.first {
                self.username = user.username ?? ""
                self.password = user.password ?? ""

                // Initialize userStats and load the stats for this user
                let stats = UserStats(container: container)
                stats.loadStats(for: user)
                self.userStats = stats

                return true
            }
        } catch {
            print("Error fetching user: \(error.localizedDescription)")
        }
        return false
    }

    func validatePassword(inputPassword: String) -> Bool {
        return UserProfile.hashPassword(inputPassword) == self.password
    }

    func login() {
        isLoggedIn = true
        saveUserState()
    }

    func logout() {
        isLoggedIn = false
        username = ""
        password = ""
        userStats = nil
        saveUserState()
        print("Logged out.")
    }

    func clearUserData() {
       let context = container.viewContext
       let request: NSFetchRequest<NSFetchRequestResult> = UserEntity.fetchRequest()
       let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)

       do {
           try context.execute(deleteRequest)
           try context.save()
           print("All user data cleared.")

           logout()

       } catch {
           print("Error clearing user data: \(error.localizedDescription)")
       }
   }
}
