import SwiftUI

struct FogView: View {
    @State private var fogStreaks: [FogStreak] = []
    let maxFogStreaks = 10
    let fogColor: Color = Color(.white)
    let fogOpacity = 0.4
    let blur = 25.0
    
    var body: some View {
        ZStack {
            Color.clear.ignoresSafeArea()
            
            Canvas { context, size in
                for fog in fogStreaks {
                    let rect = CGRect(
                        x: fog.x,
                        y: fog.y,
                        width: fog.width,
                        height: fog.height
                    )
                    
                    let path: Path
                    
                    switch fog.shapeType {
                    case 1:
                        path = Path(roundedRect: rect, cornerRadius: fog.cornerRadius)
                    case 2:
                        path = Path(ellipseIn: rect)
                    case 3:
                        path = Path(ellipseIn: rect.insetBy(dx: -fog.cornerRadius, dy: -fog.cornerRadius))
                    case 4:
                        path = Path(roundedRect: rect, cornerRadius: 2*fog.cornerRadius)
                    case 5:
                        path = Path(roundedRect: rect, cornerRadius: 2*fog.cornerRadius).union(Path(ellipseIn: rect))
                    case 6:
                        path = Path { p in
                            p.move(to: CGPoint(x: rect.minX, y: rect.minY))
                            p.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
                            p.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
                            p.closeSubpath()
                        }
                    case 7:
                        path = Path { p in
                            p.move(to: CGPoint(x: rect.midX, y: rect.minY))
                            p.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
                            p.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
                            p.closeSubpath()
                        }
                    case 8:
                        path = Path { p in
                            let insetRect = rect.insetBy(dx: fog.cornerRadius * 0.5, dy: fog.cornerRadius * 0.5)
                            p.addEllipse(in: rect)
                            p.addEllipse(in: insetRect)
                        }
                    default:
                        path = Path(roundedRect: rect, cornerRadius: fog.cornerRadius)
                    }
                    
                    context.fill(path, with: .color(fogColor.opacity(fogOpacity)))
                }
            }
            .blur(radius: blur)
            .ignoresSafeArea()
        }
        .onAppear {
            initializeFogStreaks(screenSize: NSScreen.main?.frame.size ?? .zero)
            animateFog()
        }
    }
    
    func initializeFogStreaks(screenSize: CGSize) {
        guard screenSize.width > 0, screenSize.height > 0 else { return }
        
        fogStreaks = (0..<maxFogStreaks).map { _ in
            FogStreak(
                id: UUID(),
                x: CGFloat.random(in: -screenSize.width...screenSize.width),
                y: CGFloat.random(in: 0...screenSize.height),
                width: CGFloat.random(in: screenSize.width * 0.3...screenSize.width * 0.75),
                height: CGFloat.random(in: 30...100),
                speed: CGFloat.random(in: 0.5...2.0),
                cornerRadius: CGFloat.random(in: 10...40),
                shapeType: Int.random(in: 1...8)
            )
        }
    }
    
    func animateFog() {
        Timer.scheduledTimer(withTimeInterval: 1.0/60.0, repeats: true) { _ in
            for i in fogStreaks.indices {
                fogStreaks[i].x += fogStreaks[i].speed
                
                if fogStreaks[i].x > NSScreen.main!.frame.width + 100 {
                    fogStreaks[i].x = -fogStreaks[i].width
                    fogStreaks[i].y = CGFloat.random(in: 0...(NSScreen.main?.frame.size.height ?? 600))
                    fogStreaks[i].speed = CGFloat.random(in: 0.5...2.0)
                }
            }
        }
    }
}
