//
//  SunAndMoonView.swift
//  StressLess
//
//  Created by Xucheng Zhao on 10/20/24.
//

import SwiftUI

struct SunAndMoonView: View {
    @State private var currentHour = Calendar.current.component(.hour, from: Date())
    
    // Timer to update current time every minute
    let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()

    // Compute x and y positions for sun/moon based on current hour
    var sunMoonXPosition: CGFloat {
        let width: CGFloat = UIScreen.main.bounds.width
        let halfWidth = width / 2

        if currentHour >= 6 && currentHour < 18 {
            let dayProgress = Double(currentHour - 6) / 12.0
            // 0 (6 AM) to 1 (6 PM)
            return (dayProgress * width) - halfWidth
            // Move from left to right
        } else {
            let nightHour = currentHour >= 18 ? currentHour - 18 : currentHour + 6
            // Normalize to 0 to 12
            let nightProgress = Double(nightHour) / 12.0
            // 0 (6 PM) to 1 (6 AM)
            return (nightProgress * width) - halfWidth
            // Move from left to right
        }
    }

    var sunMoonYPosition: CGFloat {
        let progress: Double
        if currentHour >= 6 && currentHour < 18 {
            progress = Double(currentHour - 6) / 12.0
            // Day progress for sun
        } else {
            let nightHour = currentHour >= 18 ? currentHour - 18 : currentHour + 6
            progress = Double(nightHour) / 12.0
            // Night progress for moon
        }
        return -100 * pow(progress - 0.5, 2) + 120
        // Parabolic path
    }

    var body: some View {
        ZStack {
            // Sun (only visible from 6 AM to 6 PM)
            if currentHour >= 6 && currentHour < 18 {
                Image(systemName: "sun.max.fill")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.yellow)
                    .offset(x: sunMoonXPosition, y: sunMoonYPosition)
                    // Move along parabola
                    .animation(.easeInOut(duration: 1.0), value: sunMoonXPosition)
                    // Smooth movement
            }
            
            // Moon (only visible from 6 PM to 6 AM)
            if currentHour >= 18 || currentHour < 6 {
                Image(systemName: "moon.fill")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.white)
                    .offset(x: sunMoonXPosition, y: sunMoonYPosition)
                    // Move along parabola
                    .animation(.easeInOut(duration: 1.0), value: sunMoonXPosition) // Smooth movement
            }
        }
        .onReceive(timer) { _ in
            // Update the current hour every minute
            currentHour = Calendar.current.component(.hour, from: Date())
        }
        .padding(.top, -462)
    }
}

struct SunAndMoonView_Previews: PreviewProvider {
    static var previews: some View {
        SunAndMoonView()
    }
}
