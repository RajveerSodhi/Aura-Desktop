//import SwiftUI
//
//struct CloudView1: View {
//    @State private var clouds: [Cloud] = []
//    let maxClouds: Int
//    let cloudColor: Color
//    let cloudOpacity: Double
//    let blur: Double
//    let minSpeed: Double
//    let maxSpeed: Double
//    let minWidthPercent: Double
//    let maxWidthPercent: Double
//    let minHeight: Double
//    let maxHeight: Double
//    let cover: Double
//    
//    
//    let cornerRadius = 25.0
//    
//    var body: some View {
//        ZStack {
//            Canvas { context, size in
//                for cloud in clouds {
//                    let rect = CGRect(
//                        x: cloud.x,
//                        y: cloud.y,
//                        width: cloud.width,
//                        height: cloud.height
//                    )
//                    
//                    let path: Path
//                    
//                    switch cloud.shapeType {
//                    case 1:
//                        path = Path(ellipseIn: rect)
//                    case 2:
//                        path = Path(ellipseIn: rect.insetBy(dx: -1 * cornerRadius, dy: -1 * cornerRadius))
//                    case 3:
//                        path = Path { p in
//                            let cloudWidth = rect.width
//                            let cloudHeight = rect.height
//                            let baseY = rect.midY
//                            
//                            p.addEllipse(in: CGRect(x: rect.minX, y: baseY - cloudHeight / 2, width: cloudWidth / 2, height: cloudHeight))
//                            p.addEllipse(in: CGRect(x: rect.midX - cloudWidth / 4, y: baseY - cloudHeight * 0.7, width: cloudWidth / 2, height: cloudHeight * 0.8))
//                            p.addEllipse(in: CGRect(x: rect.maxX - cloudWidth / 2, y: baseY - cloudHeight / 2, width: cloudWidth / 2, height: cloudHeight))
//                        }
//                    case 4:
//                        path = Path { p in
//                            let cloudWidth = rect.width
//                            let cloudHeight = rect.height
//                            let baseY = rect.midY
//                            
//                            p.addEllipse(in: CGRect(x: rect.minX, y: baseY - cloudHeight / 2, width: cloudWidth * 0.4, height: cloudHeight * 0.6))
//                            p.addEllipse(in: CGRect(x: rect.midX - cloudWidth * 0.3, y: baseY - cloudHeight * 0.7, width: cloudWidth * 0.6, height: cloudHeight * 0.7))
//                            p.addEllipse(in: CGRect(x: rect.maxX - cloudWidth * 0.4, y: baseY - cloudHeight / 2, width: cloudWidth * 0.4, height: cloudHeight * 0.6))
//                        }
//                    case 5:
//                        path = Path { p in
//                            let cloudWidth = rect.width
//                            let cloudHeight = rect.height
//                            p.addEllipse(in: CGRect(x: rect.minX + cloudWidth * 0.1, y: rect.midY - cloudHeight * 0.7, width: cloudWidth * 0.5, height: cloudHeight * 0.8))
//                            p.addEllipse(in: CGRect(x: rect.midX - cloudWidth * 0.3, y: rect.midY - cloudHeight * 0.4, width: cloudWidth * 0.7, height: cloudHeight * 0.9))
//                            p.addEllipse(in: CGRect(x: rect.maxX - cloudWidth * 0.6, y: rect.midY - cloudHeight * 0.5, width: cloudWidth * 0.4, height: cloudHeight * 0.6))
//                        }
//                    case 6:
//                        path = Path { p in
//                            let cloudWidth = rect.width
//                            let cloudHeight = rect.height * 0.6
//                            
//                            p.addEllipse(in: CGRect(x: rect.minX, y: rect.midY - cloudHeight / 2, width: cloudWidth * 0.4, height: cloudHeight))
//                            p.addEllipse(in: CGRect(x: rect.midX - cloudWidth * 0.25, y: rect.midY - cloudHeight * 0.4, width: cloudWidth * 0.5, height: cloudHeight * 0.6))
//                            p.addEllipse(in: CGRect(x: rect.maxX - cloudWidth * 0.5, y: rect.midY - cloudHeight / 2, width: cloudWidth * 0.4, height: cloudHeight))
//                        }
//                    case 7:
//                        path = Path { p in
//                            let cloudWidth = rect.width * 0.6
//                            let cloudHeight = rect.height * 0.6
//                            
//                            p.addEllipse(in: CGRect(x: rect.minX + cloudWidth * 0.1, y: rect.midY - cloudHeight * 0.5, width: cloudWidth, height: cloudHeight))
//                            p.addEllipse(in: CGRect(x: rect.midX - cloudWidth * 0.4, y: rect.midY - cloudHeight * 0.7, width: cloudWidth * 1.2, height: cloudHeight * 0.8))
//                        }
//                    case 8:
//                        path = Path { p in
//                            p.move(to: CGPoint(x: rect.minX, y: rect.midY))
//                            p.addCurve(
//                                to: CGPoint(x: rect.maxX, y: rect.midY),
//                                control1: CGPoint(x: rect.minX + rect.width * 0.3, y: rect.minY),
//                                control2: CGPoint(x: rect.maxX - rect.width * 0.3, y: rect.minY)
//                            )
//                            p.addCurve(
//                                to: CGPoint(x: rect.minX, y: rect.midY),
//                                control1: CGPoint(x: rect.maxX - rect.width * 0.3, y: rect.maxY),
//                                control2: CGPoint(x: rect.minX + rect.width * 0.3, y: rect.maxY)
//                            )
//                        }
//                    default:
//                        path = Path(ellipseIn: rect)
//                    }
//                    
//                    context.fill(path, with: .color(cloudColor.opacity(cloudOpacity)))
//                }
//            }
//            .blur(radius: blur)
//            .ignoresSafeArea()
//        }
//        .onAppear {
//            initializeClouds(screenSize: NSScreen.main?.frame.size ?? .zero)
//            animateClouds(screenSize: NSScreen.main?.frame.size ?? .zero)
//        }
//    }
//    
//    func initializeClouds(screenSize: CGSize) {
//        guard screenSize.width > 0, screenSize.height > 0 else { return }
//        
//        clouds = (0..<maxClouds).map { _ in
//            Cloud(
//                id: UUID(),
//                x: CGFloat.random(in: -screenSize.width...screenSize.width),
//                y: CGFloat.random(in: maxHeight...screenSize.height * cover),
//                width: CGFloat.random(in: screenSize.width * minWidthPercent / 100.0...screenSize.width * maxWidthPercent / 100.0),
//                height: CGFloat.random(in: minHeight...maxHeight),
//                speed: CGFloat.random(in: minSpeed...maxSpeed),
//                shapeType: Int.random(in: 1...8)
//            )
//        }
//    }
//    
//    func animateClouds(screenSize: CGSize) {
//        Timer.scheduledTimer(withTimeInterval: 1.0/60.0, repeats: true) { _ in
//            for i in clouds.indices {
//                clouds[i].x += clouds[i].speed
//                
//                if clouds[i].x > screenSize.width * (1 + maxWidthPercent / 100.0) {
//                    clouds[i].x = -clouds[i].width
//                    clouds[i].y = CGFloat.random(in: maxHeight...screenSize.height * cover)
//                    clouds[i].speed = CGFloat.random(in: minSpeed...maxSpeed)
//                    clouds[i].shapeType = Int.random(in: 1...8)
//                }
//            }
//        }
//    }
//}
