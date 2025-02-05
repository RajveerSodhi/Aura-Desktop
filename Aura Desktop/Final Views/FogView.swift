//
//  FogView.swift
//  Aura Desktop
//
//  Created by Rajveer Sodhi on 2025-02-01.
//

import SwiftUI

struct FogView: View {
    @State private var visibleFog: Set<Int> = [1]

    var body: some View {
        ZStack {
            Color.black.opacity(0.5)

            ForEach(1..<4, id: \.self) { i in
                if visibleFog.contains(i) {
                    ViewBuilder(settings: FogSettingsManager.shared, textureImage: "fog\(i)")
                }
            }
        }
        .onAppear {
            for i in 2..<4 {
                let delay = Double.random(in: 1.5...8)
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                    visibleFog.insert(i)
                }
            }
        }
    }
}
