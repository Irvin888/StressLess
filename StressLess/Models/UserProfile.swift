//
//  UserProfile.swift
//  StressLess
//
//  Created by Xucheng Zhao on 11/10/24.
//

import Foundation
import CryptoKit
import SwiftUI

class UserProfile: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = "" // Stores the hashed password
    @Published var isLoggedIn: Bool = false // Tracks login status
    
    // Hashing function for passwords
    static func hashPassword(_ password: String) -> String {
        let data = Data(password.utf8)
        let hash = SHA256.hash(data: data)
        return hash.compactMap { String(format: "%02x", $0) }.joined()
    }
    
    // Validates input password by comparing the hash
    func validatePassword(inputPassword: String) -> Bool {
        return UserProfile.hashPassword(inputPassword) == self.password
    }
    
    // Updates the login state
    func login() {
        isLoggedIn = true
    }

    func logout() {
        isLoggedIn = false
    }
}

