//
//  Controller.swift
//  StressLess
//
//  Created by Xucheng Zhao on 10/20/24.
//

import SwiftUI

struct Controller: View {
    @State private var isDarkMode = false
    let mediaStorage = MediaStorage()
    let settingsStorage = SettingsStorage()

    var body: some View {
        VStack {
            // Load the image from local storage and display it
            if let savedImage = mediaStorage.loadImageLocally() {
                Image(uiImage: savedImage)
                    .resizable()
                    .frame(width: 300, height: 175)
            } else {
                Text("No Image Found")
            }
            
            // Toggle to simulate saving/loading settings
            Toggle("Dark Mode", isOn: $isDarkMode)
                .padding()
                .onChange(of: isDarkMode) {
                    settingsStorage.saveUserSettings(isDarkModeEnabled: isDarkMode)
                }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)  // Apply dark/light mode
        .onAppear {
            if let image = UIImage(named: "MISC_Odyssey_Promo_Piece-02-V015_Updated") {
                mediaStorage.saveImageLocally(image: image)
            }
            // Load the saved user settings when the view appears
            isDarkMode = settingsStorage.loadUserSettings()
        }
    }
}

struct Controller_Previews: PreviewProvider {
    static var previews: some View {
        Controller()
    }
}
