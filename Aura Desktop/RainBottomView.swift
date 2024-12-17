import SwiftUI

struct RainBottomView: View {
    @State private var raindrops: [Raindrop] = []
    let maxRaindrops = 80
    let raindropSize = 5.0
    let rainColor: Color = Color(.gray)

    var body: some View {
        ZStack {
            Canvas { context, size in
                for raindrop in raindrops {
                    let rect = CGRect(
                        x: raindrop.x,
                        y: raindrop.y,
                        width: raindropSize,
                        height: raindropSize
                    )
                    context.fill(Path(ellipseIn: rect), with: .color(rainColor))
                }
            }
            .ignoresSafeArea()
        }
        .onAppear {
            initializeRaindrops(screenSize: NSScreen.main?.frame.size ?? .zero)
            Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
                Timer.scheduledTimer(withTimeInterval: 1.0/30.0, repeats: true) { _ in
                    let number = Int.random(in: 1...4)
                    for _ in 0..<number {
                        let i = Int.random(in: 0..<maxRaindrops)
                        moveRaindrop(screenSize: NSScreen.main?.frame.size ?? .zero, i: i)
                    }
                }
            }
        }
    }

    func initializeRaindrops(screenSize: CGSize) {
        guard screenSize.width > 0, screenSize.height > 0 else { return }
        
        raindrops = (0...maxRaindrops).map { _ in
            Raindrop(
                id: UUID(),
                x: CGFloat.random(in: 0...screenSize.width),
                y: screenSize.height - raindropSize,
                length: 0,
                speed: 0
            )
        }
    }

    func moveRaindrop(screenSize: CGSize, i: Int) {
        guard screenSize.width > 0, screenSize.height > 0 else { return }
        raindrops[i].x = CGFloat.random(in: 0...1.2*screenSize.width)
    }
}

