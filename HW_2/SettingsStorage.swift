//
//  SettingsStorage.swift
//  StressLess
//
//  Created by Xucheng Zhao on 10/20/24.
//

import Foundation

class SettingsStorage {
    // Save user settings (e.g., Dark Mode preference)
    func saveUserSettings(isDarkModeEnabled: Bool) {
        UserDefaults.standard.set(isDarkModeEnabled, forKey: "DARK_MODE")
    }

    // Load user settings
    func loadUserSettings() -> Bool {
        return UserDefaults.standard.bool(forKey: "DARK_MODE")
    }
}
