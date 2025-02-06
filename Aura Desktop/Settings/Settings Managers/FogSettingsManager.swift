//
//  FogSettingsManager.swift
//  Aura Desktop
//
//  Created by Rajveer Sodhi on 2025-02-01.
//

import SwiftUI

class FogSettingsManager: ObservableObject, WeatherSettings {
    
    static let shared = FogSettingsManager()
    
    @Published var birthRate: CGFloat {
        didSet { UserDefaults.standard.set(birthRate, forKey: "FogBirthRate") }
    }
    @Published var speed: CGFloat {
        didSet { UserDefaults.standard.set(speed, forKey: "FogSpeed") }
    }
    @Published var speedRange: CGFloat {
        didSet { UserDefaults.standard.set(speedRange, forKey: "FogSpeedRange") }
    }
    @Published var scale: CGFloat {
        didSet { UserDefaults.standard.set(scale, forKey: "FogScale") }
    }
    @Published var scaleRange: CGFloat {
        didSet { UserDefaults.standard.set(scaleRange, forKey: "FogScaleRange") }
    }
    @Published var angle: CGFloat {
        didSet { UserDefaults.standard.set(angle, forKey: "FogAngle") }
    }
    @Published var angleRange: CGFloat {
        didSet { UserDefaults.standard.set(angleRange, forKey: "FogAngleRange") }
    }
    @Published var xAcceleration: CGFloat {
        didSet { UserDefaults.standard.set(xAcceleration, forKey: "FogXAcceleration") }
    }
    @Published var yAcceleration: CGFloat {
        didSet { UserDefaults.standard.set(yAcceleration, forKey: "FogYAcceleration") }
    }
    @Published var bgOpacity: CGFloat {
        didSet { UserDefaults.standard.set(bgOpacity, forKey: "FogBgOpacity") }
    }
    @Published var bgColor: Color {
        didSet { UserDefaults.standard.set(bgColor, forKey: "FogBgColor") }
    }
    @Published var direction: CGFloat {
        didSet { UserDefaults.standard.set(direction, forKey: "FogDirection") }
    }
    @Published var color: NSColor {
        didSet { UserDefaults.standard.set(color, forKey: "FogColor") }
    }
    @Published var alpha: CGFloat {
        didSet { UserDefaults.standard.set(alpha, forKey: "FogAlpha") }
    }
    @Published var alphaRange: CGFloat {
        didSet { UserDefaults.standard.set(alphaRange, forKey: "FogAlphaRange") }
    }


    init() {
        let defaults = UserDefaults.standard
        
        self.birthRate = defaults.object(forKey: "FogBirthRate") as? CGFloat ?? CGFloat.random(in: 0.02..<0.08)
        self.scale = defaults.object(forKey: "FogScale") as? CGFloat ?? 1.7
        self.scaleRange = defaults.object(forKey: "FogScaleRange") as? CGFloat ?? 0.5
        self.speed = defaults.object(forKey: "FogSpeed") as? CGFloat ?? 55
        self.speedRange = defaults.object(forKey: "FogSpeedRange") as? CGFloat ?? 40
        self.angle = defaults.object(forKey: "FogAngle") as? CGFloat ?? 0
        self.angleRange = defaults.object(forKey: "FogAngleRange") as? CGFloat ?? 0
        self.xAcceleration = defaults.object(forKey: "FogXAcceleration") as? CGFloat ?? 0
        self.yAcceleration = defaults.object(forKey: "FogYAcceleration") as? CGFloat ?? 0
        self.bgOpacity = defaults.object(forKey: "FogBgOpacity") as? CGFloat ?? 0
        self.bgColor = defaults.object(forKey: "FogBgColor") as? Color ?? Color.black
        self.direction = defaults.object(forKey: "FogDirection") as? CGFloat ?? 0
        self.color = defaults.object(forKey: "FogColor") as? NSColor ?? NSColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1)
        self.alpha = defaults.object(forKey: "FogAlpha") as? CGFloat ?? 1.0
        self.alphaRange = defaults.object(forKey: "FogAlphaRange") as? CGFloat ?? 0
    }
}
