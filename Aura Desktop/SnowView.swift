import SwiftUI

struct SnowView: View {
    @State private var snowflakes: [Snowflake] = []
    
    let maxSnowflakes: Int
    let angle: Double
    let backgroundColor: Color
    let backgroundOpacity: Double
    
    let minSize: Double
    let maxSize: Double
    let minSpeed: Double
    let maxSpeed: Double
    let minStartY: Double
    let maxStartY: Double
    let wind: Bool
    
    let minAmplitude: Double = 0.0
    let maxAmplitude: Double = 1.0
    
    let snowColor: Color = Color(.white)
    let direction: Double = -1.0
    
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
        
        snowflakes = (0...maxSnowflakes).map { _ in
            Snowflake(
                id: UUID(),
                x: CGFloat.random(in: 0...screenSize.width * (1 + (angle)/45.0)),
                y: -1*CGFloat.random(in: minStartY...maxStartY),
                size: CGFloat.random(in: minSize...maxSize),
                speed: CGFloat.random(in: minSpeed...maxSpeed),
                amplitude: CGFloat.random(in: minAmplitude...maxAmplitude)
            )
        }
    }

    func moveSnowflakes(screenSize: CGSize) {
        guard screenSize.width > 0, screenSize.height > 0 else { return }
        
        theta += 0.001
        let radians = (angle) * .pi / 180
        
        for i in snowflakes.indices {
            snowflakes[i].y += snowflakes[i].speed
        
            if wind {
                snowflakes[i].x += snowflakes[i].amplitude * sin((theta + snowflakes[i].y) / 100.0)
            }
            
                
            snowflakes[i].x += direction * tan(radians) * snowflakes[i].speed
            
            if snowflakes[i].y > screenSize.height + 10 {
                snowflakes[i].amplitude = CGFloat.random(in: minAmplitude...maxAmplitude)
                snowflakes[i].y = -1*CGFloat.random(in: minStartY...maxStartY)
                snowflakes[i].speed = CGFloat.random(in: minSpeed...maxSpeed)
                snowflakes[i].x = CGFloat.random(in: 0...screenSize.width * (1 + (angle)/45.0))
            }
        }
    }
}
