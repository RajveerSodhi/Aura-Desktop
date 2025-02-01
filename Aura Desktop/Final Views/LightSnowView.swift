//
//  LightSnowView.swift
//  Aura Desktop
//
//  Created by Rajveer Sodhi on 2025-02-01.
//

import SwiftUI

struct LightSnowView: View {
    var body: some View {
        ViewBuilder(settings: LightSnowSettingsManager.shared, textureImage: "snowflake")
    }
}

