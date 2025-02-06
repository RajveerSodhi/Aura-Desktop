//import SpriteKit
//import SwiftUICore
//
//class RainScene: SKScene, ObservableObject {
//    private var rainEmitter: SKEmitterNode?
//
//    override func sceneDidLoad() {
//        super.sceneDidLoad()
//        
//        backgroundColor = .clear
//        
//        let emitter = SKEmitterNode()
//        
//        emitter.targetNode = self
//        emitter.particleBirthRate = 150
//        emitter.particleTexture = SKTexture(imageNamed: "light_raindrop")
//        emitter.particleScale = 0.75
//        emitter.particleScaleRange = 0.5
//        emitter.particleColor = .white
//        
//        emitter.position = CGPoint(x: size.width / 2, y: size.height)
//        emitter.particlePositionRange = CGVector(dx: size.width, dy: 0)
//        
//        emitter.particleLifetime = 4
//        emitter.particleLifetimeRange = 2
//        
//        emitter.emissionAngle = CGFloat(3 * Double.pi / 2)
//        emitter.emissionAngleRange = .pi / 16
//
//        emitter.particleSpeed = 100
//        emitter.particleSpeedRange = 80
//        
//        emitter.yAcceleration = -980  // adjust for “heavy” or “light” rain
//        emitter.xAcceleration = 50 * sin(CGFloat.random(in: 0...1) * .pi)
//        
//        addChild(emitter)
//        self.rainEmitter = emitter
//    }
//    
//    override func didChangeSize(_ oldSize: CGSize) {
//        super.didChangeSize(oldSize)
//        rainEmitter?.position = CGPoint(x: size.width / 2, y: size.height)
//        rainEmitter?.particlePositionRange = CGVector(dx: size.width, dy: 0)
//    }
//    
//    func updateRainSpeed(_ speed: CGFloat) {
//        rainEmitter?.particleSpeed = speed
//    }
//    
//    func updateBirthRate(_ rate: CGFloat) {
//        rainEmitter?.particleBirthRate = rate
//    }
//}
