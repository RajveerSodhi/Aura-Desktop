//
//  CloudView.swift
//  Aura Desktop
//
//  Created by Rajveer Sodhi on 2025-02-05.
//

import SwiftUI

struct CloudView: View {
    @State private var visibleCloud: Set<Int> = [1]

    var body: some View {
        ZStack {
            Color.black.opacity(0.5)

            ForEach(1..<7, id: \.self) { i in
                if visibleCloud.contains(i) {
                    ViewBuilder(settings: CloudSettingsManager.shared, textureImage: "cloud\(i)")
                }
            }
        }
        .onAppear {
            for i in 2..<7 {
                let delay = Double.random(in: 3...11)
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                    visibleCloud.insert(i)
                }
            }
        }
    }
}
