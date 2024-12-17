import SwiftUI

struct SunnyView: View {
    @State private var isAnimating = false

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.2), Color.white.opacity(0.2)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            Circle()
                .fill(
                    RadialGradient(
                        gradient: Gradient(colors: [
                            Color.yellow.opacity(0.8),
                            Color.orange.opacity(0.7),
                            Color.clear
                        ]),
                        center: .center,
                        startRadius: 0,
                        endRadius: 300
                    )
                )
                .frame(width: 420, height: 420) // Bigger sun
                .position(x: 200, y: 170)
                .blur(radius: 80) // Increased blur for softness

            // Sun Rays - Much Softer and More Spread Out
            ForEach(0..<40) { i in
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.yellow.opacity(0.15)) // Softer opacity
                    .frame(width: 15, height: 600) // Longer rays
                    .rotationEffect(Angle(degrees: Double(i) * 9)) // Spread more rays
                    .position(x: 200, y: 150)
                    .blur(radius: 30) // Heavy blur for diffused edges
            }
            .blendMode(.screen)

            // Lens Flare Circles - More Layers
            ForEach(1..<10) { i in
                Circle()
                    .fill(
                        RadialGradient(
                            gradient: Gradient(colors: [
                                Color.yellow.opacity(0.15),
                                Color.white.opacity(0.1),
                                Color.clear
                            ]),
                            center: .center,
                            startRadius: 0,
                            endRadius: CGFloat(i * 60)
                        )
                    )
                    .frame(width: CGFloat(i * 60), height: CGFloat(i * 60))
                    .position(x: 200 + CGFloat(i * 50), y: 150 + CGFloat(i * 40))
                    .blur(radius: 25)
            }

            // Subtle Sun Glow Pulse
            Circle()
                .fill(Color.white.opacity(0.5))
                .frame(width: 150, height: 150)
                .position(x: 200, y: 150)
                .blur(radius: 80)
                .scaleEffect(isAnimating ? 1.1 : 1.0)
                .animation(
                    Animation.easeInOut(duration: 2.5)
                        .repeatForever(autoreverses: true),
                    value: isAnimating
                )
            
            CloudView()
        }
        .onAppear {
            isAnimating = true
        }
    }
}
