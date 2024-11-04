//
//  AppState.swift
//  StressLess
//
//  Created by Xucheng Zhao on 11/3/24.
//

import SwiftUI

class AppState: ObservableObject {
    @Published var loggedIn: Bool = false              // User login status
}
