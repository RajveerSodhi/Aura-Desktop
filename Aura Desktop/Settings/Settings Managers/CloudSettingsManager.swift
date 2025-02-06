//
//  CloudSettingsManager.swift
//  Aura Desktop
//
//  Created by Rajveer Sodhi on 2025-02-01.
//

import SwiftUI

class CloudSettingsManager: ObservableObject, WeatherSettings {
    
    static let shared = CloudSettingsManager()
    
    @Published var birthRate: CGFloat {
        didSet { UserDefaults.standard.set(birthRate, forKey: "CloudBirthRate") }
    }
    @Published var speed: CGFloat {
        didSet { UserDefaults.standard.set(speed, forKey: "CloudSpeed") }
    }
    @Published var speedRange: CGFloat {
        didSet { UserDefaults.standard.set(speedRange, forKey: "CloudSpeedRange") }
    }
    @Published var scale: CGFloat {
        didSet { UserDefaults.standard.set(scale, forKey: "CloudScale") }
    }
    @Published var scaleRange: CGFloat {
        didSet { UserDefaults.standard.set(scaleRange, forKey: "CloudScaleRange") }
    }
    @Published var angle: CGFloat {
        didSet { UserDefaults.standard.set(angle, forKey: "CloudAngle") }
    }
    @Published var angleRange: CGFloat {
        didSet { UserDefaults.standard.set(angleRange, forKey: "CloudAngleRange") }
    }
    @Published var xAcceleration: CGFloat {
        didSet { UserDefaults.standard.set(xAcceleration, forKey: "CloudXAcceleration") }
    }
    @Published var yAcceleration: CGFloat {
        didSet { UserDefaults.standard.set(yAcceleration, forKey: "CloudYAcceleration") }
    }
    @Published var bgOpacity: CGFloat {
        didSet { UserDefaults.standard.set(bgOpacity, forKey: "CloudBgOpacity") }
    }
    @Published var bgColor: Color {
        didSet { UserDefaults.standard.set(bgColor, forKey: "CloudBgColor") }
    }
    @Published var direction: CGFloat {
        didSet { UserDefaults.standard.set(direction, forKey: "CloudDirection") }
    }
    @Published var color: NSColor {
        didSet { UserDefaults.standard.set(color, forKey: "CloudColor") }
    }
    @Published var alpha: CGFloat {
        didSet { UserDefaults.standard.set(alpha, forKey: "CloudAlpha") }
    }
    @Published var alphaRange: CGFloat {
        didSet { UserDefaults.standard.set(alphaRange, forKey: "CloudAlphaRange") }
    }


    init() {
        let defaults = UserDefaults.standard
        
        self.birthRate = defaults.object(forKey: "CloudBirthRate") as? CGFloat ?? CGFloat.random(in: 0.01..<0.025)
        self.scale = defaults.object(forKey: "CloudScale") as? CGFloat ?? 1
        self.scaleRange = defaults.object(forKey: "CloudScaleRange") as? CGFloat ?? 0.2
        self.speed = defaults.object(forKey: "CloudSpeed") as? CGFloat ?? 50
        self.speedRange = defaults.object(forKey: "CloudSpeedRange") as? CGFloat ?? 40
        self.angle = defaults.object(forKey: "CloudAngle") as? CGFloat ?? 0
        self.angleRange = defaults.object(forKey: "CloudAngleRange") as? CGFloat ?? 0
        self.xAcceleration = defaults.object(forKey: "CloudXAcceleration") as? CGFloat ?? 0
        self.yAcceleration = defaults.object(forKey: "CloudYAcceleration") as? CGFloat ?? 0
        self.bgOpacity = defaults.object(forKey: "CloudBgOpacity") as? CGFloat ?? 0
        self.bgColor = defaults.object(forKey: "CloudBgColor") as? Color ?? Color.black
        self.direction = defaults.object(forKey: "CloudDirection") as? CGFloat ?? 0
        self.color = defaults.object(forKey: "CloudColor") as? NSColor ?? NSColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1)
        self.alpha = defaults.object(forKey: "CloudAlpha") as? CGFloat ?? 0.9
        self.alphaRange = defaults.object(forKey: "CloudAlphaRange") as? CGFloat ?? 0.3
    }
}
