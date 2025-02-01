//
//  LightSnowSettingsManager.swift
//  Aura Desktop
//
//  Created by Rajveer Sodhi on 2025-02-01.
//

import SwiftUI

class LightSnowSettingsManager: ObservableObject, WeatherSettings {
    static let shared = LightSnowSettingsManager()
    
    @Published var birthRate: CGFloat {
        didSet { UserDefaults.standard.set(birthRate, forKey: "LightSnowBirthRate") }
    }
    @Published var speed: CGFloat {
        didSet { UserDefaults.standard.set(speed, forKey: "LightSnowSpeed") }
    }
    @Published var speedRange: CGFloat {
        didSet { UserDefaults.standard.set(speedRange, forKey: "LightSnowSpeedRange") }
    }
    @Published var scale: CGFloat {
        didSet { UserDefaults.standard.set(scale, forKey: "LightSnowScale") }
    }
    @Published var scaleRange: CGFloat {
        didSet { UserDefaults.standard.set(scaleRange, forKey: "LightSnowScaleRange") }
    }
    @Published var angle: CGFloat {
        didSet { UserDefaults.standard.set(angle, forKey: "LightSnowAngle") }
    }
    @Published var angleRange: CGFloat {
        didSet { UserDefaults.standard.set(angleRange, forKey: "LightSnowAngleRange") }
    }
    @Published var xAcceleration: CGFloat {
        didSet { UserDefaults.standard.set(xAcceleration, forKey: "LightSnowXAcceleration") }
    }
    @Published var yAcceleration: CGFloat {
        didSet { UserDefaults.standard.set(yAcceleration, forKey: "LightSnowYAcceleration") }
    }
    @Published var bgOpacity: CGFloat {
        didSet { UserDefaults.standard.set(bgOpacity, forKey: "LightSnowBgOpacity") }
    }
    @Published var bgColor: Color {
        didSet { UserDefaults.standard.set(bgColor, forKey: "LightSnowBgColor") }
    }
    @Published var direction: CGFloat {
        didSet { UserDefaults.standard.set(direction, forKey: "LightSnowDirection") }
    }
    @Published var color: NSColor {
        didSet { UserDefaults.standard.set(color, forKey: "LightSnowColor") }
    }
    @Published var alpha: CGFloat {
        didSet { UserDefaults.standard.set(alpha, forKey: "LightSnowAlpha") }
    }
    @Published var alphaRange: CGFloat {
        didSet { UserDefaults.standard.set(alphaRange, forKey: "LightSnowAlphaRange") }
    }

    init() {
        let defaults = UserDefaults.standard
        
        self.birthRate = defaults.object(forKey: "LightSnowBirthRate") as? CGFloat ?? 20
        self.scale = defaults.object(forKey: "LightSnowScale") as? CGFloat ?? 0.7
        self.scaleRange = defaults.object(forKey: "LightSnowScaleRange") as? CGFloat ?? 0.4
        self.speed = defaults.object(forKey: "LightSnowSpeed") as? CGFloat ?? 60
        self.speedRange = defaults.object(forKey: "LightSnowSpeedRange") as? CGFloat ?? 50
        self.angle = defaults.object(forKey: "LightSnowAngle") as? CGFloat ?? 0
        self.angleRange = defaults.object(forKey: "LightSnowAngleRange") as? CGFloat ?? .pi / 16
        self.xAcceleration = defaults.object(forKey: "LightSnowXAcceleration") as? CGFloat ?? 0
        self.yAcceleration = defaults.object(forKey: "LightSnowYAcceleration") as? CGFloat ?? 0
        self.bgOpacity = defaults.object(forKey: "LightSnowBgOpacity") as? CGFloat ?? 0.3
        self.bgColor = defaults.object(forKey: "LightSnowBgColor") as? Color ?? Color.blue
        self.direction = defaults.object(forKey: "LightSnowDirection") as? CGFloat ?? -1.0
        self.color = defaults.object(forKey: "LightSnowColor") as? NSColor ?? NSColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1)
        self.alpha = defaults.object(forKey: "LightSnowAlpha") as? CGFloat ?? 0.9
        self.alphaRange = defaults.object(forKey: "LightSnowAlphaRange") as? CGFloat ?? 0.1
    }
}
