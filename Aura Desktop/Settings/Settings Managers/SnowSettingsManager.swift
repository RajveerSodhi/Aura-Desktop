//
//  SnowSettingsManager.swift
//  Aura Desktop
//
//  Created by Rajveer Sodhi on 2025-02-01.
//

import SwiftUI

class SnowSettingsManager: ObservableObject, WeatherSettings {
    static let shared = SnowSettingsManager()
    
    @Published var birthRate: CGFloat {
        didSet { UserDefaults.standard.set(birthRate, forKey: "SnowBirthRate") }
    }
    @Published var speed: CGFloat {
        didSet { UserDefaults.standard.set(speed, forKey: "SnowSpeed") }
    }
    @Published var speedRange: CGFloat {
        didSet { UserDefaults.standard.set(speedRange, forKey: "SnowSpeedRange") }
    }
    @Published var scale: CGFloat {
        didSet { UserDefaults.standard.set(scale, forKey: "SnowScale") }
    }
    @Published var scaleRange: CGFloat {
        didSet { UserDefaults.standard.set(scaleRange, forKey: "SnowScaleRange") }
    }
    @Published var angle: CGFloat {
        didSet { UserDefaults.standard.set(angle, forKey: "SnowAngle") }
    }
    @Published var angleRange: CGFloat {
        didSet { UserDefaults.standard.set(angleRange, forKey: "SnowAngleRange") }
    }
    @Published var xAcceleration: CGFloat {
        didSet { UserDefaults.standard.set(xAcceleration, forKey: "SnowXAcceleration") }
    }
    @Published var yAcceleration: CGFloat {
        didSet { UserDefaults.standard.set(yAcceleration, forKey: "SnowYAcceleration") }
    }
    @Published var bgOpacity: CGFloat {
        didSet { UserDefaults.standard.set(bgOpacity, forKey: "SnowBgOpacity") }
    }
    @Published var bgColor: Color {
        didSet { UserDefaults.standard.set(bgColor, forKey: "SnowBgColor") }
    }
    @Published var direction: CGFloat {
        didSet { UserDefaults.standard.set(direction, forKey: "SnowDirection") }
    }
    @Published var color: NSColor {
        didSet { UserDefaults.standard.set(color, forKey: "SnowColor") }
    }
    @Published var alpha: CGFloat {
        didSet { UserDefaults.standard.set(alpha, forKey: "SnowAlpha") }
    }
    @Published var alphaRange: CGFloat {
        didSet { UserDefaults.standard.set(alphaRange, forKey: "SnowAlphaRange") }
    }

    init() {
        let defaults = UserDefaults.standard
        
        self.birthRate = defaults.object(forKey: "SnowBirthRate") as? CGFloat ?? 40
        self.scale = defaults.object(forKey: "SnowScale") as? CGFloat ?? 1.05
        self.scaleRange = defaults.object(forKey: "SnowScaleRange") as? CGFloat ?? 0.45
        self.speed = defaults.object(forKey: "SnowSpeed") as? CGFloat ?? 95
        self.speedRange = defaults.object(forKey: "SnowSpeedRange") as? CGFloat ?? 65
        self.angle = defaults.object(forKey: "SnowAngle") as? CGFloat ?? 0
        self.angleRange = defaults.object(forKey: "SnowAngleRange") as? CGFloat ?? .pi / 24
        self.xAcceleration = defaults.object(forKey: "SnowXAcceleration") as? CGFloat ?? 0
        self.yAcceleration = defaults.object(forKey: "SnowYAcceleration") as? CGFloat ?? 0
        self.bgOpacity = defaults.object(forKey: "SnowBgOpacity") as? CGFloat ?? 0.3
        self.bgColor = defaults.object(forKey: "SnowBgColor") as? Color ?? Color.blue
        self.direction = defaults.object(forKey: "SnowDirection") as? CGFloat ?? -1.0
        self.color = defaults.object(forKey: "SnowColor") as? NSColor ?? NSColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1)
        self.alpha = defaults.object(forKey: "SnowAlpha") as? CGFloat ?? 1
        self.alphaRange = defaults.object(forKey: "SnowAlphaRange") as? CGFloat ?? 0
    }
}
