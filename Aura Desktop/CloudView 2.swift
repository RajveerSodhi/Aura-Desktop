import SwiftUI

struct CloudView2: View {
    @State private var clouds: [Cloud] = []
    
    let maxClouds: Int
    let cloudColor: Color
    let cloudOpacity: Double
    let blur: Double
    let minSpeed: Double
    let maxSpeed: Double
    let minWidthPercent: Double
    let maxWidthPercent: Double
    let minHeight: Double
    let maxHeight: Double
    
    let cloudShapes = ["cloud.fill", "icloud.fill"]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(clouds) { cloud in
                    Image(systemName: cloudShapes[cloud.shapeType])
                        .resizable()
                        .frame(width: cloud.width, height: cloud.height)
                        .opacity(cloudOpacity)
                        .foregroundColor(cloudColor)
                        .position(x: cloud.x, y: cloud.y)
                }
                .blur(radius: blur)
            }
            .ignoresSafeArea()
            .onAppear {
                initializeClouds(screenSize: NSScreen.main?.frame.size ?? .zero)
                animateClouds(screenSize: NSScreen.main?.frame.size ?? .zero)
            }
        }
    }
    
    func initializeClouds(screenSize: CGSize) {
        guard screenSize.width > 0, screenSize.height > 0 else { return }

        clouds = (0..<maxClouds).map { _ in
            Cloud(
                id: UUID(),
                x: CGFloat.random(in: -screenSize.width...screenSize.width),
                y: CGFloat.random(in: 0...screenSize.height * 0.7),
                width: CGFloat.random(in: CGFloat(screenSize.width * (minWidthPercent / 100.0))...CGFloat(screenSize.width * (maxWidthPercent / 100.0))),
                height: CGFloat.random(in: minHeight...maxHeight),
                speed: CGFloat.random(in: minSpeed...maxSpeed),
                shapeType: Int.random(in: 0...1)
            )
        }
    }
    
    func animateClouds(screenSize: CGSize) {
        Timer.scheduledTimer(withTimeInterval: 1.0/60.0, repeats: true) { _ in
            for i in clouds.indices {
                clouds[i].x += clouds[i].speed
                
                if clouds[i].x > screenSize.width + 100 {
                    clouds[i].x = -clouds[i].width
                    clouds[i].y = CGFloat.random(in: 0...screenSize.height * 0.7)
                    clouds[i].speed = CGFloat.random(in: minSpeed...maxSpeed)
                }
            }
        }
    }
}
