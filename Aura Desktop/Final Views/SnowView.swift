//
//  SnowView.swift
//  Aura Desktop
//
//  Created by Rajveer Sodhi on 2025-02-01.
//

import SwiftUI

struct SnowView: View {
    var body: some View {
        ViewBuilder(settings: SnowSettingsManager.shared, textureImage: "snowflake")
    }
}

