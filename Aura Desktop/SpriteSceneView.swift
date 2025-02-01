//
//  SpriteSceneView.swift
//  Aura Desktop
//
//  Created by Rajveer Sodhi on 2025-01-28.
//

import SwiftUI
import SpriteKit

struct SpriteSceneView: NSViewRepresentable {
    @ObservedObject var weatherSettings = AppSettingsManager.shared
    let scene: SKScene

    func makeNSView(context: Context) -> SKView {
        let skView = SKView()
        skView.preferredFramesPerSecond = weatherSettings.frameRate

        skView.presentScene(scene)
        scene.scaleMode = .resizeFill

        skView.allowsTransparency = true
        skView.ignoresSiblingOrder = true

        return skView
    }

    func updateNSView(_ nsView: SKView, context: Context) {
        nsView.preferredFramesPerSecond = weatherSettings.frameRate
    }
}
