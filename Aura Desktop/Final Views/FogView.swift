//
//  FogView.swift
//  Aura Desktop
//
//  Created by Rajveer Sodhi on 2025-02-01.
//

import SwiftUI

struct FogView: View {
    var body: some View {
        ZStack {
            ForEach(1..<7) { i in
                ViewBuilder(settings: FogSettingsManager.shared, textureImage: "fog\(i)")
            }
        }

    }
}

