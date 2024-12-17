import SwiftUI

struct ContentView: View {
    @State private var snowflakes: [Snowflake] = []
    let maxSnowflakes = 300

    var body: some View {
        ZStack {
            Color.blue.opacity(0.15)

            Canvas { context, size in
                for snowflake in snowflakes {
                    let rect = CGRect(
                        x: snowflake.x,
                        y: snowflake.y,
                        width: snowflake.size,
                        height: snowflake.size
                    )
                    context.fill(Path(ellipseIn: rect), with: .color(.white))
                }
            }
            .ignoresSafeArea()
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 0.4, repeats: true) { _ in
                addSnowflake(screenSize: NSScreen.main?.frame.size ?? .zero)
            }

            Timer.scheduledTimer(withTimeInterval: 1.0/60.0, repeats: true) { _ in
                moveSnowflakes(screenSize: NSScreen.main?.frame.size ?? .zero)
            }
        }
    }

    func addSnowflake(screenSize: CGSize) {
        guard screenSize.width > 0, screenSize.height > 0 else { return }
        guard snowflakes.count < maxSnowflakes else { return }

        var snowflake = Snowflake(
            id: UUID(),
            x: CGFloat.random(in: 0...screenSize.width),
            y: -10,
            size: CGFloat.random(in: 5...13),
            speed: CGFloat.random(in: 1...3),
            angle: 30.0
        )
        if snowflake.angle != 0.0 {
            snowflake.x =  CGFloat.random(in: 0...2*screenSize.width + 10)
        }
        snowflakes.append(snowflake)
    }

    func moveSnowflakes(screenSize: CGSize) {
        guard screenSize.width > 0, screenSize.height > 0 else { return }

        for i in snowflakes.indices {
            snowflakes[i].y += snowflakes[i].speed
            snowflakes[i].x -= tan(90 - snowflakes[i].angle)*snowflakes[i].speed

            
            if snowflakes[i].y > screenSize.height + 10 {
                snowflakes[i].y = -10
                snowflakes[i].x = CGFloat.random(in: 0...screenSize.width)
            }
        }
    }
}
