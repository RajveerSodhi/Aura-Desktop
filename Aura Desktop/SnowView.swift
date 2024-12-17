import SwiftUI

struct SnowView: View {
    @State private var snowflakes: [Snowflake] = []
    let maxSnowflakes = 200
    let angle: Double = 0.0
    let direction: Double = -1.0
    let backgroundColor: Color = Color(.blue)
    let backgroundOpacity: Double = 0.2
    let snowColor: Color = Color(.white)
    
    @State private var theta: Double = 0.0

    var body: some View {
        ZStack {
            backgroundColor.opacity(backgroundOpacity)

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
            
            SnowBottomView()
        }
        .onAppear {
            initializeSnowflakes(screenSize: NSScreen.main?.frame.size ?? .zero)

            Timer.scheduledTimer(withTimeInterval: 1.0/60.0, repeats: true) { _ in
                moveSnowflakes(screenSize: NSScreen.main?.frame.size ?? .zero)
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
                y: -1*CGFloat.random(in: 0...1000),
                size: CGFloat.random(in: 5...13),
                speed: CGFloat.random(in: 1...3),
                amplitude: CGFloat.random(in: 0...1)
            )
        }
    }

    func moveSnowflakes(screenSize: CGSize) {
        guard screenSize.width > 0, screenSize.height > 0 else { return }

        let maxX = angle == 0 ? screenSize.width : (2*screenSize.width)
        theta += 0.001
        
        for i in snowflakes.indices {
            snowflakes[i].y += snowflakes[i].speed
        
            
            snowflakes[i].x += snowflakes[i].amplitude * sin((theta + snowflakes[i].y) / 100.0)

            
            if angle != 0.0 {
                snowflakes[i].x += direction * tan(90 - angle) * snowflakes[i].speed
            }
            
            if snowflakes[i].y > screenSize.height + 10 {
                snowflakes[i].amplitude = CGFloat.random(in: 0...1)
                snowflakes[i].y = -1*CGFloat.random(in: 0...1000)
                snowflakes[i].speed = CGFloat.random(in: 1...3)
                snowflakes[i].x = CGFloat.random(in: 0...maxX)
            }
        }
    }
}
