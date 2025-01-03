import SwiftUI

struct SunView: View {
    @State private var rotationAngle: Double = 0.0
    
    let sunX: CGFloat = 200
    let sunY: CGFloat = 180
    let sunSize: CGFloat = 300
    let lensFlare: Bool = true
    let whiteRays: Int = 6
    let yellowRays: Int = 30
    let flareX: CGFloat = 25
    let flareY: CGFloat = 9
    let flareIntensity: CGFloat = 1.0
    let backgroundOpacity: CGFloat = 0.15
    let animationDuration: Double = 150.0
    let sunBrightness: CGFloat = 1.0

    var body: some View {
        ZStack {
            DayBackgroundView(backgroundOpacity: backgroundOpacity)

            ForEach(0..<whiteRays) { i in
                Ellipse()
                    .fill(Color.white.opacity(0.38))
                    .frame(width: 13, height: 1.5*sunSize)
                    .rotationEffect(Angle(degrees: rotationAngle + Double(i) * (360.0 / Double(whiteRays))))
                    .position(x: sunX, y: sunY)
                    .blur(radius: 16)
            }
            .blendMode(.screen)
            
            Circle()
                .fill(
                    RadialGradient(
                        gradient: Gradient(colors: [
                            Color.white.opacity(0.5 * sunBrightness),
                            Color.yellow.opacity(0.8 * sunBrightness),
                            Color.orange.opacity(1.0 * sunBrightness),
                            Color.clear
                        ]),
                        center: .center,
                        startRadius: 0,
                        endRadius: sunSize
                    )
                )
                .frame(width: sunSize, height: sunSize)
                .position(x: sunX, y: sunY)
                .blur(radius: 60)
            
            ForEach(0..<yellowRays) { i in
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.yellow.opacity(0.18))
                    .frame(width: 15, height: 1.25 * sunSize)
                    .rotationEffect(Angle(degrees: Double(i) * (360/Double(yellowRays))))
                    .position(x: sunX, y: sunY)
                    .blur(radius: 28)
            }
            .blendMode(.screen)
            
            if lensFlare {
                ForEach(1..<8) { i in
                    Circle()
                        .fill(
                            RadialGradient(
                                gradient: Gradient(colors: [
                                    Color.yellow.opacity(0.2 * flareIntensity),
                                    Color.white.opacity(0.1 * flareIntensity),
                                    Color.orange.opacity(0.2 * flareIntensity),
                                    Color.clear
                                ]),
                                center: .center,
                                startRadius: 0,
                                endRadius: CGFloat(i * 50)
                            )
                        )
                        .frame(width: CGFloat(i * 50), height: CGFloat(i * 50))
                        .position(x: sunX + CGFloat((i * i * 25) - i), y: sunY + CGFloat(i * i * 9))
                        .blur(radius: 20)
                }
            }
        }
        .onAppear {
                startAnimation()
            }
    }
    
    func startAnimation() {
            withAnimation(
                Animation.linear(duration: animationDuration)
                    .repeatForever(autoreverses: false)
            ) {
                rotationAngle = 360
            }
        }
    }
