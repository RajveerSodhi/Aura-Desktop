import SpriteKit
import SwiftUI

class SceneBuilder: SKScene, ObservableObject {
    private var sceneEmitter: SKEmitterNode?
    
    var birthRate: CGFloat
    var textureImage: String
    var scale: CGFloat
    var scaleRange: CGFloat
    var angle: CGFloat
    var angleRange: CGFloat
    var Speed: CGFloat
    var speedRange: CGFloat
    var xAcceleration: CGFloat
    var yAcceleration: CGFloat
    var color: NSColor
    var lifetime: CGFloat = 10
    var emitterPosition: CGPoint = .zero
    var emitterPositionRange: CGVector = CGVector(dx: 0, dy: 0)
    var rotAngle: CGFloat = 0
    var direction: CGFloat
    var Alpha: CGFloat
    var alphaRange: CGFloat
    
    init(
        birthRate: CGFloat,
        textureImage: String,
        scale: CGFloat,
        scaleRange: CGFloat,
        angle: CGFloat,
        angleRange: CGFloat,
        direction: CGFloat,
        speed: CGFloat,
        speedRange: CGFloat,
        xAcceleration: CGFloat,
        yAcceleration: CGFloat,
        color: NSColor,
        alpha: CGFloat,
        alphaRange: CGFloat) {
        
        self.birthRate = birthRate
        self.textureImage = textureImage
        self.scale = scale
        self.scaleRange = scaleRange
        self.angle = angle
        self.angleRange = angleRange
        self.direction = direction
        self.Speed = speed
        self.speedRange = speedRange
        self.xAcceleration = xAcceleration
        self.yAcceleration = yAcceleration
        self.color = color
        self.Alpha = alpha
        self.alphaRange = alphaRange
        
        super.init(size: NSScreen.main?.frame.size ?? CGSize(width: 800, height: 600))
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func sceneDidLoad() {
        super.sceneDidLoad()
        backgroundColor = .clear
        
        let emitter = SKEmitterNode()
        
//        adjustForAngle()
//        adjustPositionForHorizontal()
//        
        emitter.targetNode = self
        emitter.particleBirthRate = birthRate
        
        emitter.particleTexture = SKTexture(imageNamed: textureImage)
        emitter.particleColorBlendFactor = 1.0;
        emitter.particleColor = color;
        emitter.particleBlendMode = .alpha
        
        emitter.particleScale = scale
        emitter.particleScaleRange = scaleRange
        
        emitter.position = emitterPosition
        emitter.particlePositionRange = emitterPositionRange
        
        emitter.emissionAngle = angle
        emitter.emissionAngleRange = angleRange
        emitter.particleRotation = rotAngle
        
        emitter.particleAlpha = Alpha
        emitter.particleAlphaRange = alphaRange
        
        emitter.particleLifetime = lifetime

        emitter.particleSpeed = Speed
        emitter.particleSpeedRange = speedRange
        
        emitter.yAcceleration = yAcceleration
        emitter.xAcceleration = xAcceleration
        
        addChild(emitter)
        self.sceneEmitter = emitter
    }
    
    func convertToRadians(_ angle: CGFloat) -> CGFloat {
        return angle * .pi / 180
    }
    
    func calculateHorizontalLifetime(extra: CGFloat) {
        let distance = size.width + extra
        let lifetime = ceil (distance / self.Speed)
        
        self.lifetime = lifetime
    }
    
    func calculateFallingLifetime() {
        let width = size.width * (1 + self.angle/60.0)
        let height = size.height + 20
        let diagonal = pow((pow(width, 2) + pow(height, 2)), 0.5)
        let lifetime = ceil(diagonal / self.Speed)
        
        self.lifetime = lifetime
    }
    
    func adjustPositionForHorizontal() {
        if textureImage.contains("fog") {
            calculateHorizontalLifetime(extra: 2500)
            
            self.emitterPosition = CGPoint(x: -750 + CGFloat(Int.random(in: -450..<200)), y: size.height / 2  + CGFloat(Int.random(in: -600..<600)))
            self.emitterPositionRange = CGVector(dx: 0, dy: size.height * 1.2)
        }
        
        if textureImage.contains("cloud") {
            calculateHorizontalLifetime(extra: 1500)
            
            self.emitterPosition = CGPoint(x: -500 + CGFloat(Int.random(in: -400..<200)), y: size.height / 2  + CGFloat(Int.random(in: -600..<600)))
            self.emitterPositionRange = CGVector(dx: 0, dy: size.height * 1.5)
        }
    }
    
    func adjustForAngle() {
        if (textureImage.contains("raindrop") || textureImage == "snowflake") && self.angle != 0 {
            // adjust lifetime, birthrate, and emission position range before adding direction
            let absoluteShift: CGFloat = 1 + self.angle/60.0
            self.birthRate *= absoluteShift
            self.emitterPositionRange = CGVector(dx: size.width * absoluteShift, dy: 0)
            
            // dynamically calculate lifetime
            calculateFallingLifetime()
            
            // add direction
            if self.direction == -1 && self.angle > 0 {
                self.angle *= -1
            }
            
            if self.direction == 1 && self.angle < 0 {
                self.angle *= -1
            }
            
            let relativeShift: CGFloat = 1 - self.angle/60.0
            
            // adjust emitter position with angle and direction
            self.emitterPosition = CGPoint(x: size.width / 2 * relativeShift, y: size.height - 10)
            
            // rotate sprites with angle and direction, except if snow since that is round
            if textureImage != "snowflake" {
                self.rotAngle = convertToRadians(self.angle)
            }
            
            // correct for downward flowing particles
            if textureImage == "light_raindrop" || textureImage == "raindrop" || textureImage == "snowflake" {
                self.angle += 270
            }
            
            // seet new angle after correction
            self.angle = convertToRadians(self.angle)
        }
    }
    
    
    func setBirthRate(_ rate: CGFloat) {
        birthRate = rate * (1 + self.angle/60.0)
        sceneEmitter?.particleBirthRate = birthRate
    }
    
    func setSpeed(_ speed: CGFloat) {
        Speed = speed
        sceneEmitter?.particleSpeed = speed
        calculateFallingLifetime()
    }
    
    func setSpeedRange(_ newRange: CGFloat) {
        speedRange = newRange
        sceneEmitter?.particleSpeedRange = newRange
    }
    
    func setAngle(_ newAngle: CGFloat) {
        angle = newAngle
        adjustForAngle()
    }
    
    func setAngleRange(_ range: CGFloat) {
        angleRange = range
        sceneEmitter?.emissionAngleRange = range
    }
    
    func setDirection(_ newDir: CGFloat) {
        direction = newDir
        adjustForAngle()
    }
    
    func setColor(_ newColor: NSColor) {
        color = newColor
        sceneEmitter?.particleColor = newColor
    }
    
    func setParticleScale(_ newScale: CGFloat) {
        scale = newScale
        sceneEmitter?.particleScale = newScale
    }
    
    func setScaleRange(_ newRange: CGFloat) {
        scaleRange = newRange
        sceneEmitter?.particleScaleRange = newRange
    }
    
    func setXAcceleration(_ xAccel: CGFloat) {
        xAcceleration = xAccel
        sceneEmitter?.xAcceleration = xAccel
    }
    
    func setYAcceleration(_ yAccel: CGFloat) {
        yAcceleration = yAccel
        sceneEmitter?.yAcceleration = yAccel
    }
    
    func setAlpha(_ newAlpha: CGFloat) {
        Alpha = newAlpha
        sceneEmitter?.particleAlpha = newAlpha
    }
    
    func setAlphaRange(_ range: CGFloat) {
        alphaRange = range
        sceneEmitter?.particleAlphaRange = range
    }

}
