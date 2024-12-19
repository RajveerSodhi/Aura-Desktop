import SwiftUI

struct StormyView: View {
    @State private var raindrops: [Raindrop] = []

    var maxRaindrops = 200
    let angle: Double = 0.0
    let direction: Double = -1.0
    let backgroundColor: Color = Color(.black)
    let backgroundOpacity: Double = 0.5
    let rainColor: Color = Color(.gray)
    let fog: Bool = true
    let lightning: Bool = true
    let lightningStrikesPerMinute: Int = 6

    var body: some View {
        ZStack {

            backgroundColor.opacity(backgroundOpacity)
            
            if lightning {
                LightningView(lightningStrikesPerMinute: lightningStrikesPerMinute)
            }
            
            if fog {
                StormyFogView()
            }
            
            RainView(maxRaindrops: maxRaindrops, angle: angle, color: rainColor, backgroundColor: .clear, backgroundOpacity: 0.0, minLength: 12.0, maxLength: 26.0, minSpeed: 8.0, maxSpeed: 16.0, minStartY: 0.0, maxStartY: 800.0)
            
            RainBottomView(maxRaindrops: 80, rainColor: rainColor, startDelay: 2.0)
        }
    }
}
