import SwiftUI

struct RainView: View {
    @State private var raindrops: [Raindrop] = []
    var maxRaindrops = 400

    var body: some View {
        ZStack {
            Color.black.opacity(0.2)

            Canvas { context, size in
                for raindrop in raindrops {
                    context.drawLayer { layerContext in
                        let rect = CGRect(
                            x: raindrop.x,
                            y: raindrop.y,
                            width: 3,
                            height: raindrop.length
                        )
                        
                        let center = CGPoint(x: rect.midX, y: rect.midY)
                        layerContext.translateBy(x: center.x, y: center.y)
                        layerContext.rotate(by: Angle(degrees: raindrop.angle))
                        layerContext.translateBy(x: -center.x, y: -center.y)
                        
                        layerContext.fill(Path(roundedRect: rect, cornerRadius: 1.5), with: .color(.gray.opacity(0.8)))
                        }
                    }
                }
            .ignoresSafeArea()
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                addRaindrop(screenSize: NSScreen.main?.frame.size ?? .zero)
            }

            Timer.scheduledTimer(withTimeInterval: 1.0/60.0, repeats: true) { _ in
                moveRaindrop(screenSize: NSScreen.main?.frame.size ?? .zero)
            }
        }
    }

    func addRaindrop(screenSize: CGSize) {
        guard screenSize.width > 0, screenSize.height > 0 else { return }
        guard raindrops.count < maxRaindrops else { return }

        var raindrop = Raindrop(
            id: UUID(),
            x: CGFloat.random(in: 0...screenSize.width),
            y: -10,
            length: CGFloat.random(in: 10...22),
            speed: CGFloat.random(in: 6...12),
            angle: 45.0
        )
        if raindrop.angle != 0.0 {
            raindrop.x =  CGFloat.random(in: 0...2*screenSize.width + 10)
        }
        
        raindrops.append(raindrop)
    }

    func moveRaindrop(screenSize: CGSize) {
        guard screenSize.width > 0, screenSize.height > 0 else { return }

        for i in raindrops.indices {
            raindrops[i].y += raindrops[i].speed
            if raindrops[i].angle != 0.0 {
                raindrops[i].x -= tan(90 - raindrops[i].angle)*raindrops[i].speed
            }
            
            if raindrops[i].y > screenSize.height + 10 {
                raindrops[i].y = -10
                raindrops[i].speed = CGFloat.random(in: 6...12)
                raindrops[i].x = CGFloat.random(in: 0...screenSize.width)
                if  raindrops[i].angle != 0.0 {
                    raindrops[i].x =  CGFloat.random(in: 0...2*screenSize.width + 10)
                }
            }
        }
    }
}
