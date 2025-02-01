//
//  WeatherSettings.swift
//  Aura Desktop
//
//  Created by Rajveer Sodhi on 2025-01-31.
//

import SwiftUI

protocol WeatherSettings {
    var birthRate: CGFloat { get set }
    var speed: CGFloat { get set }
    var speedRange: CGFloat { get set }
    var scale: CGFloat { get set }
    var scaleRange: CGFloat { get set }
    var angle: CGFloat { get set }
    var angleRange: CGFloat { get set }
    var xAcceleration: CGFloat { get set }
    var yAcceleration: CGFloat { get set }
    var bgOpacity: CGFloat { get set }
    var bgColor: Color { get set }
    var direction: CGFloat { get set }
    var color: NSColor { get set }
    var alpha: CGFloat { get set }
    var alphaRange: CGFloat { get set }
}
