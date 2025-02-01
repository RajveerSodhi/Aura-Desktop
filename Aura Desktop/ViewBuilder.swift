import SwiftUI
import SpriteKit

struct ViewBuilder<T: WeatherSettings & ObservableObject>: View {
    @ObservedObject var settings: T
    @StateObject var scene: SceneBuilder
    
    init(settings: T) {
        self.settings = settings
        
        let scene = SceneBuilder(
            birthRate: settings.birthRate,
            textureImage: settings.textureImage,
            scale: settings.scale,
            scaleRange: settings.scaleRange,
            angle: settings.angle,
            angleRange: settings.angleRange,
            direction: settings.direction,
            speed: settings.speed,
            speedRange: settings.speedRange,
            xAcceleration: settings.xAcceleration,
            yAcceleration: settings.yAcceleration,
            color: settings.color,
            alpha: settings.alpha,
            alphaRange: settings.alphaRange
        )
        
        _scene = StateObject(wrappedValue: scene)
    }

    var body: some View {
        let sceneOpacity: CGFloat = settings.bgOpacity
        let sceneBg: Color = settings.bgColor
        ZStack {
            sceneBg.opacity(sceneOpacity).edgesIgnoringSafeArea(.all)
            SpriteSceneView(scene: scene)
                .edgesIgnoringSafeArea(.all)
        }
        .onChange(of: settings.birthRate) { oldValue, newValue in
            scene.setBirthRate(newValue)
        }
        .onChange(of: settings.scale) { oldValue, newValue in
            scene.setParticleScale(newValue)
        }
        .onChange(of: settings.scaleRange) { oldValue, newValue in
            scene.setScaleRange(newValue)
        }
        .onChange(of: settings.speed) { oldValue, newValue in
            scene.setSpeed(newValue)
        }
        .onChange(of: settings.speedRange) { oldValue, newValue in
            scene.setSpeedRange(newValue)
        }
        .onChange(of: settings.angle) { oldValue, newValue in
            scene.setAngle(newValue)
        }
        .onChange(of: settings.angleRange) { oldValue, newValue in
            scene.setAngleRange(newValue)
        }
        .onChange(of: settings.direction) { oldValue, newValue in
            scene.setDirection(newValue)
        }
        .onChange(of: settings.color) { oldValue, newValue in
            scene.setColor(newValue)
        }
        .onChange(of: settings.alpha) { oldValue, newValue in
            scene.setAlpha(newValue)
        }
        .onChange(of: settings.alphaRange) { oldValue, newValue in
            scene.setAlphaRange(newValue)
        }
        .onChange(of: settings.xAcceleration) { oldValue, newValue in
            scene.setXAcceleration(newValue)
        }
        .onChange(of: settings.yAcceleration) { oldValue, newValue in
            scene.setYAcceleration(newValue)
        }
    }
}
