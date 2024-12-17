import SwiftUI

struct RainView: View {
    @State private var raindrops: [Raindrop] = []
    var maxRaindrops = 400
    let angle: Double = 30.0
    let direction: Double = -1.0
    let color: Color = Color(.gray)
    let backgroundColor: Color = Color(.black)
    let backgroundOpacity: Double = 0.2

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
            
            RainBottomView()
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
        
        let maxX = angle == 0 ? screenSize.width : (2*screenSize.width)
        
        raindrops = (0...maxRaindrops).map { _ in
            Raindrop(
                id: UUID(),
                x: CGFloat.random(in: 0...maxX),
                y: -1*CGFloat.random(in: 0...800),
                length: CGFloat.random(in: 10...26),
                speed: CGFloat.random(in: 6...12)
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
                raindrops[i].length = CGFloat.random(in: 10...26)
                raindrops[i].speed = CGFloat.random(in: 6...12)
                raindrops[i].x = CGFloat.random(in: 0...maxX)
            }
        }
    }
}
