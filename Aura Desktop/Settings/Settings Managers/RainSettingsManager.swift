//
//  RainSettingsManager.swift
//  Aura Desktop
//
//  Created by Rajveer Sodhi on 2025-02-01.
//

import SwiftUI

class RainSettingsManager: ObservableObject, WeatherSettings {
    
    static let shared = RainSettingsManager()
    
    @Published var birthRate: CGFloat {
        didSet { UserDefaults.standard.set(birthRate, forKey: "RainBirthRate") }
    }
    @Published var speed: CGFloat {
        didSet { UserDefaults.standard.set(speed, forKey: "RainSpeed") }
    }
    @Published var speedRange: CGFloat {
        didSet { UserDefaults.standard.set(speedRange, forKey: "RainSpeedRange") }
    }
    @Published var scale: CGFloat {
        didSet { UserDefaults.standard.set(scale, forKey: "RainScale") }
    }
    @Published var scaleRange: CGFloat {
        didSet { UserDefaults.standard.set(scaleRange, forKey: "RainScaleRange") }
    }
    @Published var angle: CGFloat {
        didSet { UserDefaults.standard.set(angle, forKey: "RainAngle") }
    }
    @Published var angleRange: CGFloat {
        didSet { UserDefaults.standard.set(angleRange, forKey: "RainAngleRange") }
    }
    @Published var xAcceleration: CGFloat {
        didSet { UserDefaults.standard.set(xAcceleration, forKey: "RainXAcceleration") }
    }
    @Published var yAcceleration: CGFloat {
        didSet { UserDefaults.standard.set(yAcceleration, forKey: "RainYAcceleration") }
    }
    @Published var bgOpacity: CGFloat {
        didSet { UserDefaults.standard.set(bgOpacity, forKey: "RainBgOpacity") }
    }
    @Published var bgColor: Color {
        didSet { UserDefaults.standard.set(bgColor, forKey: "RainBgColor") }
    }
    @Published var direction: CGFloat {
        didSet { UserDefaults.standard.set(direction, forKey: "RainDirection") }
    }
    @Published var color: NSColor {
        didSet { UserDefaults.standard.set(color, forKey: "RainColor") }
    }
    @Published var alpha: CGFloat {
        didSet { UserDefaults.standard.set(alpha, forKey: "RainAlpha") }
    }
    @Published var alphaRange: CGFloat {
        didSet { UserDefaults.standard.set(alphaRange, forKey: "RainAlphaRange") }
    }


    init() {
        let defaults = UserDefaults.standard
        
        self.birthRate = defaults.object(forKey: "RainBirthRate") as? CGFloat ?? 100
        self.scale = defaults.object(forKey: "RainScale") as? CGFloat ?? 1
        self.scaleRange = defaults.object(forKey: "RainScaleRange") as? CGFloat ?? 0.25
        self.speed = defaults.object(forKey: "RainSpeed") as? CGFloat ?? 630
        self.speedRange = defaults.object(forKey: "RainSpeedRange") as? CGFloat ?? 90
        self.angle = defaults.object(forKey: "RainAngle") as? CGFloat ?? 0
        self.angleRange = defaults.object(forKey: "RainAngleRange") as? CGFloat ?? .pi / 32
        self.xAcceleration = defaults.object(forKey: "RainXAcceleration") as? CGFloat ?? 0
        self.yAcceleration = defaults.object(forKey: "RainYAcceleration") as? CGFloat ?? 0
        self.bgOpacity = defaults.object(forKey: "RainBgOpacity") as? CGFloat ?? 0.2
        self.bgColor = defaults.object(forKey: "RainBgColor") as? Color ?? Color.black
        self.direction = defaults.object(forKey: "RainDirection") as? CGFloat ?? -1.0
        self.color = defaults.object(forKey: "RainColor") as? NSColor ?? NSColor(red: 139.0/255.0, green: 145.0/255.0, blue: 255.0/255.0, alpha: 1)
        self.alpha = defaults.object(forKey: "RainAlpha") as? CGFloat ?? 1.0
        self.alphaRange = defaults.object(forKey: "RainAlphaRange") as? CGFloat ?? 0
    }
}
