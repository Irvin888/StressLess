//
//  DynamicBackgroundView.swift
//  StressLess
//
//  Created by Xucheng Zhao on 10/20/24.
//

import SwiftUI

struct DynamicBackgroundView: View {
    @State private var currentHour = Calendar.current.component(.hour, from: Date())
    // Get the current hour

    // Update every minute
    let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()

    var gradientColors: [Color] {
        switch currentHour {
        case 6..<12:
            return [Color.orange.opacity(0.6), Color.pink.opacity(0.4)] // Morning
        case 12..<18:
            return [Color.blue.opacity(0.6), Color.cyan.opacity(0.4)] // Afternoon
        case 18..<20:
            return [Color.purple.opacity(0.6), Color.pink.opacity(0.4)] // Evening
        default:
            return [Color.indigo.opacity(0.8), Color.black.opacity(0.6)] // Night
        }
    }

    var body: some View {
        LinearGradient(gradient: Gradient(colors: gradientColors),
                       startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            .animation(.easeInOut(duration: 2.0), value: currentHour)
            // Smooth transition
            .onReceive(timer) { _ in
                // Update current hour every minute
                currentHour = Calendar.current.component(.hour, from: Date())
            }
    }
}

struct DynamicBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        DynamicBackgroundView()
    }
}
