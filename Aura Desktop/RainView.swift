import SwiftUI

struct RainView: View {
    @State private var raindrops: [Raindrop] = []
    
    var maxRaindrops: Int
    let angle: Double
    let color: Color
    let backgroundColor: Color
    let backgroundOpacity: Double
    
    let minLength: Double
    let maxLength: Double
    let minSpeed: Double
    let maxSpeed: Double
    let minStartY: Double
    let maxStartY: Double
    
    let direction: Double = -1.0

    var body: some View {
        ZStack {
            backgroundColor.opacity(backgroundOpacity)

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
                        
                        layerContext.fill(Path(roundedRect: rect, cornerRadius: 1.5), with: .color(color))
                        }
                    }
                }
            .ignoresSafeArea()
        }
        .onAppear {
            initializeRaindrops(screenSize: NSScreen.main?.frame.size ?? .zero)

            Timer.scheduledTimer(withTimeInterval: 1.0/60.0, repeats: true) { _ in
                moveRaindrop(screenSize: NSScreen.main?.frame.size ?? .zero)
            }
        }
    }

    func initializeRaindrops(screenSize: CGSize) {
        guard screenSize.width > 0, screenSize.height > 0 else { return }
        guard raindrops.count < maxRaindrops else { return }
        
        raindrops = (0...maxRaindrops).map { _ in
            Raindrop(
                id: UUID(),
                x: CGFloat.random(in: 0...screenSize.width * (1 + (angle)/45.0)),
                y: -1*CGFloat.random(in: minStartY...maxStartY),
                length: CGFloat.random(in: minLength...maxLength),
                speed: CGFloat.random(in: minSpeed...maxSpeed)
            )
        }
    }

    func moveRaindrop(screenSize: CGSize) {
        guard screenSize.width > 0, screenSize.height > 0 else { return }
        
        let radians = (angle) * .pi / 180
        
        for i in raindrops.indices {
            raindrops[i].y += raindrops[i].speed
            
            raindrops[i].x += direction * tan(radians) * raindrops[i].speed
            
            if raindrops[i].y > screenSize.height + 10 {
                raindrops[i].y = 0
                raindrops[i].length = CGFloat.random(in: minLength...maxLength)
                raindrops[i].speed = CGFloat.random(in: minSpeed...maxSpeed)
                raindrops[i].x = CGFloat.random(in: 0...screenSize.width * (1 + (angle)/45.0))
            }
        }
    }
}
