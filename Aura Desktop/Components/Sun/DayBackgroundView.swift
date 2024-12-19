import SwiftUI

struct DayBackgroundView: View {
    let backgroundColor: Color = Color(.blue)
    let backgroundOpacity: Double
    
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [backgroundColor.opacity(backgroundOpacity), Color.white.opacity(backgroundOpacity)]),
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }
}

