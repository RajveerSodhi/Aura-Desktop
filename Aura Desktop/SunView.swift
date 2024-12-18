import SwiftUI

struct SunView: View {
    @State private var isAnimating = false
    
    let sunX: CGFloat = 200
    let sunY: CGFloat = 180

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.25), Color.white.opacity(0.3)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            ForEach(0..<6) { i in
                Ellipse()
                    .fill(Color.white.opacity(0.38))
                    .frame(width: 13, height: 620)
                    .rotationEffect(Angle(degrees: Double(i) * (360/6)))
                    .position(x: sunX, y: sunY)
                    .blur(radius: 16)
            }
            .blendMode(.screen)
            
            Circle()
                .fill(
                    RadialGradient(
                        gradient: Gradient(colors: [
                            Color.yellow.opacity(0.8),
                            Color.orange.opacity(0.8),
                            Color.clear
                        ]),
                        center: .center,
                        startRadius: 0,
                        endRadius: 370
                    )
                )
                .frame(width: 430, height: 430)
                .position(x: sunX, y: sunY)
                .blur(radius: 65)
            
            ForEach(0..<30) { i in
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.yellow.opacity(0.18))
                    .frame(width: 15, height: 620)
                    .rotationEffect(Angle(degrees: Double(i) * 12))
                    .position(x: sunX, y: sunY)
                    .blur(radius: 28)
            }
            .blendMode(.screen)

            ForEach(1..<8) { i in
                Circle()
                    .fill(
                        RadialGradient(
                            gradient: Gradient(colors: [
                                Color.yellow.opacity(0.2),
                                Color.white.opacity(0.1),
                                Color.orange.opacity(0.2),
                                Color.clear
                            ]),
                            center: .center,
                            startRadius: 0,
                            endRadius: CGFloat(i * 50)
                        )
                    )
                    .frame(width: CGFloat(i * 50), height: CGFloat(i * 50))
                    .position(x: sunX + CGFloat((i * i * 25) - i), y: sunY + CGFloat(i * i * 9))
                    .blur(radius: 22)
            }
        }
    }
}
