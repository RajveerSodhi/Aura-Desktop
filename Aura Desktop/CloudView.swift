import SwiftUI

struct CloudView: View {
    @State private var clouds: [Cloud] = []
    let maxClouds = 4
    let cloudColor: Color = Color(.white)
    let cloudOpacity = 0.6
    let cornerRadius = 25.0
    let blur = 11.0
    
    var body: some View {
        ZStack {
            Color.clear.ignoresSafeArea()
            
            Canvas { context, size in
                for cloud in clouds {
                    let rect = CGRect(
                        x: cloud.x,
                        y: cloud.y,
                        width: cloud.width,
                        height: cloud.height
                    )
                    
                    let path: Path
                    
                    switch cloud.shapeType {
                    case 1:
                        path = Path(ellipseIn: rect)
                    case 2:
                        path = Path(ellipseIn: rect.insetBy(dx: -1 * cornerRadius, dy: -1 * cornerRadius))
                    case 3:
                        path = Path { p in
                            let cloudWidth = rect.width
                            let cloudHeight = rect.height
                            let baseY = rect.midY
                            
                            p.addEllipse(in: CGRect(x: rect.minX, y: baseY - cloudHeight / 2, width: cloudWidth / 2, height: cloudHeight))
                            p.addEllipse(in: CGRect(x: rect.midX - cloudWidth / 4, y: baseY - cloudHeight * 0.7, width: cloudWidth / 2, height: cloudHeight * 0.8))
                            p.addEllipse(in: CGRect(x: rect.maxX - cloudWidth / 2, y: baseY - cloudHeight / 2, width: cloudWidth / 2, height: cloudHeight))
                        }
                    case 4:
                        path = Path { p in
                            let cloudWidth = rect.width
                            let cloudHeight = rect.height
                            let baseY = rect.midY
                            
                            p.addEllipse(in: CGRect(x: rect.minX, y: baseY - cloudHeight / 2, width: cloudWidth * 0.4, height: cloudHeight * 0.6))
                            p.addEllipse(in: CGRect(x: rect.midX - cloudWidth * 0.3, y: baseY - cloudHeight * 0.7, width: cloudWidth * 0.6, height: cloudHeight * 0.7))
                            p.addEllipse(in: CGRect(x: rect.maxX - cloudWidth * 0.4, y: baseY - cloudHeight / 2, width: cloudWidth * 0.4, height: cloudHeight * 0.6))
                        }
                    case 5:
                        path = Path { p in
                            let cloudWidth = rect.width
                            let cloudHeight = rect.height
                            p.addEllipse(in: CGRect(x: rect.minX + cloudWidth * 0.1, y: rect.midY - cloudHeight * 0.7, width: cloudWidth * 0.5, height: cloudHeight * 0.8))
                            p.addEllipse(in: CGRect(x: rect.midX - cloudWidth * 0.3, y: rect.midY - cloudHeight * 0.4, width: cloudWidth * 0.7, height: cloudHeight * 0.9))
                            p.addEllipse(in: CGRect(x: rect.maxX - cloudWidth * 0.6, y: rect.midY - cloudHeight * 0.5, width: cloudWidth * 0.4, height: cloudHeight * 0.6))
                        }
                    case 6:
                        path = Path { p in
                            let cloudWidth = rect.width
                            let cloudHeight = rect.height * 0.6
                            
                            p.addEllipse(in: CGRect(x: rect.minX, y: rect.midY - cloudHeight / 2, width: cloudWidth * 0.4, height: cloudHeight))
                            p.addEllipse(in: CGRect(x: rect.midX - cloudWidth * 0.25, y: rect.midY - cloudHeight * 0.4, width: cloudWidth * 0.5, height: cloudHeight * 0.6))
                            p.addEllipse(in: CGRect(x: rect.maxX - cloudWidth * 0.5, y: rect.midY - cloudHeight / 2, width: cloudWidth * 0.4, height: cloudHeight))
                        }
                    case 7:
                        path = Path { p in
                            let cloudWidth = rect.width * 0.6
                            let cloudHeight = rect.height * 0.6
                            
                            p.addEllipse(in: CGRect(x: rect.minX + cloudWidth * 0.1, y: rect.midY - cloudHeight * 0.5, width: cloudWidth, height: cloudHeight))
                            p.addEllipse(in: CGRect(x: rect.midX - cloudWidth * 0.4, y: rect.midY - cloudHeight * 0.7, width: cloudWidth * 1.2, height: cloudHeight * 0.8))
                        }
                    case 8:
                        path = Path { p in
                            p.move(to: CGPoint(x: rect.minX, y: rect.midY))
                            p.addCurve(
                                to: CGPoint(x: rect.maxX, y: rect.midY),
                                control1: CGPoint(x: rect.minX + rect.width * 0.3, y: rect.minY),
                                control2: CGPoint(x: rect.maxX - rect.width * 0.3, y: rect.minY)
                            )
                            p.addCurve(
                                to: CGPoint(x: rect.minX, y: rect.midY),
                                control1: CGPoint(x: rect.maxX - rect.width * 0.3, y: rect.maxY),
                                control2: CGPoint(x: rect.minX + rect.width * 0.3, y: rect.maxY)
                            )
                        }
                    default:
                        path = Path(ellipseIn: rect)
                    }
                    
                    context.fill(path, with: .color(cloudColor.opacity(cloudOpacity)))
                }
            }
            .blur(radius: blur)
            .ignoresSafeArea()
        }
        .onAppear {
            initializeClouds(screenSize: NSScreen.main?.frame.size ?? .zero)
            animateClouds()
        }
    }
    
    func initializeClouds(screenSize: CGSize) {
        guard screenSize.width > 0, screenSize.height > 0 else { return }
        
        clouds = (0..<maxClouds).map { _ in
            Cloud(
                id: UUID(),
                x: CGFloat.random(in: -screenSize.width...screenSize.width),
                y: CGFloat.random(in: 0...screenSize.height * (2 / 3)),
                width: CGFloat.random(in: screenSize.width * 0.2...screenSize.width * 0.4),
                height: CGFloat.random(in: 55...100),
                speed: CGFloat.random(in: 0.4...0.9),
                shapeType: Int.random(in: 1...8)
            )
        }
    }
    
    func animateClouds() {
        Timer.scheduledTimer(withTimeInterval: 1.0/60.0, repeats: true) { _ in
            for i in clouds.indices {
                clouds[i].x += clouds[i].speed
                
                if clouds[i].x > NSScreen.main!.frame.width + 100 {
                    clouds[i].x = -clouds[i].width
                    clouds[i].y = CGFloat.random(in: 0...(NSScreen.main?.frame.size.height ?? 600))
                    clouds[i].speed = CGFloat.random(in: 0.5...2.0)
                }
            }
        }
    }
}