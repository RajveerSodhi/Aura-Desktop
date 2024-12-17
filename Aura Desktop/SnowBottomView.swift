import SwiftUI

struct SnowBottomView: View {
    @State private var snowflakes: [Snowflake] = []
    let maxSnowflakes = 80
    let snowColor: Color = Color(.white)

    var body: some View {
        ZStack {
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
            Timer.scheduledTimer(withTimeInterval: 6.0, repeats: false) { _ in
                initializeSnowflakes(screenSize: NSScreen.main?.frame.size ?? .zero)
                scheduleRandomTimer()
            }
        }
    }

    func initializeSnowflakes(screenSize: CGSize) {
        guard screenSize.width > 0, screenSize.height > 0 else { return }
        
        snowflakes = (0...maxSnowflakes).map { _ in
            Snowflake(
                id: UUID(),
                x: CGFloat.random(in: 0...screenSize.width),
                y: screenSize.height,
                size: CGFloat.random(in: 5...13),
                speed: 0,
                amplitude: 0
            )
        }
        
        for i in snowflakes.indices {
            snowflakes[i].y -= snowflakes[i].size
        }
    }

    func moveSnowflake(screenSize: CGSize, i: Int) {
        guard screenSize.width > 0, screenSize.height > 0 else { return }
        snowflakes[i].x = CGFloat.random(in: 0...1.5*screenSize.width)
        snowflakes[i].size = CGFloat.random(in: 5...13)
        snowflakes[i].y = screenSize.height - snowflakes[i].size
    }
    
    func scheduleRandomTimer() {
        let randomInterval = Double.random(in: 0.0...2.0) // Random time interval

        Timer.scheduledTimer(withTimeInterval: randomInterval, repeats: false) { _ in
            let number = Int.random(in: 1...8)
            for _ in 0..<number {
                let i = Int.random(in: 0..<maxSnowflakes)
                moveSnowflake(screenSize: NSScreen.main?.frame.size ?? .zero, i: i)
            }

            scheduleRandomTimer()
        }
    }
}
