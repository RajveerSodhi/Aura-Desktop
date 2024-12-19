import SwiftUI

struct SnowStormyView: View {
    @State private var raindrops: [Raindrop] = []
    @State private var snowflakes: [Snowflake] = []
    var maxRaindrops = 200
    let maxSnowflakes = 120
    let angle: Double = 0.0
    let direction: Double = -1.0
    let backgroundColor: Color = Color(.black)
    let backgroundOpacity: Double = 0.5
    let rainColor: Color = Color(.gray)
    let snowColor: Color = Color(.white)
    let fog: Bool = true
    let lightning: Bool = true
    let lightningStrikesPerMinute: Int = 7

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
            SnowView(maxSnowflakes: maxSnowflakes, angle: angle, backgroundColor: .clear, backgroundOpacity: 0.0, minSize: 5.0, maxSize: 13.0, minSpeed: 5.0, maxSpeed: 10.0, minStartY: 0.0, maxStartY: 800.0, wind: false)
            
            SnowBottomView(maxSnowflakes: 70, startDelay: 3.0, minSize: 5.0, maxSize: 13.0)
            RainBottomView(maxRaindrops: 80, rainColor: rainColor, startDelay: 2.0)
        }
    }
}

