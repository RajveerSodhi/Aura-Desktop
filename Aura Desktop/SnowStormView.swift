import SwiftUI

struct SnowStormView: View {
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

    var body: some View {
        ZStack {
            backgroundColor.opacity(0.2)
            Canvas { context, size in
                for raindrop in raindrops {
                    context.drawLayer { layerContext in
                        let rect = CGRect(
                            x: raindrop.x,
                            y: raindrop.y,
                            width: 4,
                            height: raindrop.length
                        )
                        
                        let center = CGPoint(x: rect.midX, y: rect.midY)
                        layerContext.translateBy(x: center.x, y: center.y)
                        layerContext.rotate(by: Angle(degrees: angle))
                        layerContext.translateBy(x: -center.x, y: -center.y)
                        
                        layerContext.fill(Path(roundedRect: rect, cornerRadius: 1.5), with: .color(rainColor))
                        }
                    }
                }
            .ignoresSafeArea()
            
            Canvas { context, size in
                for snowflake in snowflakes {
                    let rect = CGRect(
                        x: snowflake.x,
                        y: snowflake.y,
                        width: snowflake.size,
                        height: snowflake.size
                    )
                    context.fill(Path(ellipseIn: rect), with: .color(snowColor))
                }
            }
            .ignoresSafeArea()
        }
        .onAppear {
            initializeRaindrops(screenSize: NSScreen.main?.frame.size ?? .zero)
            initializeSnowflakes(screenSize: NSScreen.main?.frame.size ?? .zero)

            Timer.scheduledTimer(withTimeInterval: 1.0/60.0, repeats: true) { _ in
                moveRaindrop(screenSize: NSScreen.main?.frame.size ?? .zero)
                moveSnowflakes(screenSize: NSScreen.main?.frame.size ?? .zero)
            }
        }
    }
    
    func initializeRaindrops(screenSize: CGSize) {
        guard screenSize.width > 0, screenSize.height > 0 else { return }
        guard raindrops.count < maxRaindrops else { return }
        
        let maxX = angle == 0 ? screenSize.width : (2*screenSize.width)
        
        raindrops = (0...maxRaindrops).map { _ in
            Raindrop(
                id: UUID(),
                x: CGFloat.random(in: 0...maxX),
                y: -1*CGFloat.random(in: 0...800),
                length: CGFloat.random(in: 12...26),
                speed: CGFloat.random(in: 8...16)
            )
        }
    }

    func moveRaindrop(screenSize: CGSize) {
        guard screenSize.width > 0, screenSize.height > 0 else { return }
        
        let maxX = angle == 0 ? screenSize.width : (2*screenSize.width)
        
        for i in raindrops.indices {
            raindrops[i].y += raindrops[i].speed
            if angle != 0.0 {
                raindrops[i].x += direction * tan(90 - angle) * raindrops[i].speed
            }
            
            if raindrops[i].y > screenSize.height + 10 {
                raindrops[i].y = 0
                raindrops[i].length = CGFloat.random(in: 12...26)
                raindrops[i].speed = CGFloat.random(in: 8...16)
                raindrops[i].x = CGFloat.random(in: 0...maxX)
            }
        }
    }
    
    func initializeSnowflakes(screenSize: CGSize) {
        guard screenSize.width > 0, screenSize.height > 0 else { return }
        
        let maxX = angle == 0 ? screenSize.width : (2*screenSize.width)
        
        snowflakes = (0...maxSnowflakes).map { _ in
            Snowflake(
                id: UUID(),
                x: CGFloat.random(in: 0...maxX),
                y: -1*CGFloat.random(in: 0...800),
                size: CGFloat.random(in: 5...13),
                speed: CGFloat.random(in: 5...10),
                amplitude: CGFloat.random(in: 0...1)
            )
        }
    }

    func moveSnowflakes(screenSize: CGSize) {
        guard screenSize.width > 0, screenSize.height > 0 else { return }

        let maxX = angle == 0 ? screenSize.width : (2*screenSize.width)
        
        for i in snowflakes.indices {
            snowflakes[i].y += snowflakes[i].speed

            if angle != 0.0 {
                snowflakes[i].x += direction * tan(90 - angle) * snowflakes[i].speed
            }
            
            if snowflakes[i].y > screenSize.height + 10 {
                snowflakes[i].amplitude = CGFloat.random(in: 0...1)
                snowflakes[i].y = -1*CGFloat.random(in: 0...800)
                snowflakes[i].speed = CGFloat.random(in: 5...10)
                snowflakes[i].x = CGFloat.random(in: 0...maxX)
            }
        }
    }
}

