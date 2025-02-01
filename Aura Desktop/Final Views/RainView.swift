//
//  RainView.swift
//  Aura Desktop
//
//  Created by Rajveer Sodhi on 2025-01-31.
//

import SwiftUI

struct RainView: View {
    var body: some View {
        ViewBuilder(settings: RainSettingsManager.shared, textureImage: "raindrop")
    }
}
