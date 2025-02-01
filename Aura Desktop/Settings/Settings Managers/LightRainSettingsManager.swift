//
//  LightRainSettingsManager.swift
//  Aura Desktop
//
//  Created by Rajveer Sodhi on 2025-01-29.
//

import SwiftUI

class LightRainSettingsManager: ObservableObject, WeatherSettings {
    static let shared = LightRainSettingsManager()
    
    @Published var birthRate: CGFloat {
        didSet { UserDefaults.standard.set(birthRate, forKey: "LightRainBirthRate") }
    }
    @Published var speed: CGFloat {
        didSet { UserDefaults.standard.set(speed, forKey: "LightRainSpeed") }
    }
    @Published var speedRange: CGFloat {
        didSet { UserDefaults.standard.set(speedRange, forKey: "LightRainSpeedRange") }
    }
    @Published var scale: CGFloat {
        didSet { UserDefaults.standard.set(scale, forKey: "LightRainScale") }
    }
    @Published var scaleRange: CGFloat {
        didSet { UserDefaults.standard.set(scaleRange, forKey: "LightRainScaleRange") }
    }
    @Published var angle: CGFloat {
        didSet { UserDefaults.standard.set(angle, forKey: "LightRainAngle") }
    }
    @Published var angleRange: CGFloat {
        didSet { UserDefaults.standard.set(angleRange, forKey: "LightRainAngleRange") }
    }
    @Published var xAcceleration: CGFloat {
        didSet { UserDefaults.standard.set(xAcceleration, forKey: "LightRainXAcceleration") }
    }
    @Published var yAcceleration: CGFloat {
        didSet { UserDefaults.standard.set(yAcceleration, forKey: "LightRainYAcceleration") }
    }
    @Published var bgOpacity: CGFloat {
        didSet { UserDefaults.standard.set(bgOpacity, forKey: "LightRainBgOpacity") }
    }
    @Published var bgColor: Color {
        didSet { UserDefaults.standard.set(bgColor, forKey: "LightRainBgColor") }
    }
    @Published var direction: CGFloat {
        didSet { UserDefaults.standard.set(direction, forKey: "LightRainDirection") }
    }
    @Published var color: NSColor {
        didSet { UserDefaults.standard.set(color, forKey: "LightRainColor") }
    }
    @Published var alpha: CGFloat {
        didSet { UserDefaults.standard.set(alpha, forKey: "LightRainAlpha") }
    }
    @Published var alphaRange: CGFloat {
        didSet { UserDefaults.standard.set(alphaRange, forKey: "LightRainAlphaRange") }
    }

    init() {
        let defaults = UserDefaults.standard
        
        self.birthRate = defaults.object(forKey: "LightRainBirthRate") as? CGFloat ?? 65
        self.scale = defaults.object(forKey: "LightRainScale") as? CGFloat ?? 1.0
        self.scaleRange = defaults.object(forKey: "LightRainScaleRange") as? CGFloat ?? 0.35
        self.speed = defaults.object(forKey: "LightRainSpeed") as? CGFloat ?? 470
        self.speedRange = defaults.object(forKey: "LightRainSpeedRange") as? CGFloat ?? 85
        self.angle = defaults.object(forKey: "LightRainAngle") as? CGFloat ?? 0
        self.angleRange = defaults.object(forKey: "LightRainAngleRange") as? CGFloat ?? .pi / 32
        self.xAcceleration = defaults.object(forKey: "LightRainXAcceleration") as? CGFloat ?? 0
        self.yAcceleration = defaults.object(forKey: "LightRainYAcceleration") as? CGFloat ?? 0
        self.bgOpacity = defaults.object(forKey: "LightRainBgOpacity") as? CGFloat ?? 0.2
        self.bgColor = defaults.object(forKey: "LightRainBgColor") as? Color ?? Color.black
        self.direction = defaults.object(forKey: "LightRainDirection") as? CGFloat ?? -1.0
        self.color = defaults.object(forKey: "LightRainColor") as? NSColor ?? NSColor(red: 139.0/255.0, green: 145.0/255.0, blue: 255.0/255.0, alpha: 1)
        self.alpha = defaults.object(forKey: "LightRainAlpha") as? CGFloat ?? 1.0
        self.alphaRange = defaults.object(forKey: "LightRainAlphaRange") as? CGFloat ?? 0
    }
}
