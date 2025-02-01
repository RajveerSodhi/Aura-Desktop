//
//  MenuBarView.swift
//  Aura Desktop
//
//  Created by Rajveer Sodhi on 2025-01-27.
//

import SwiftUI

struct MenuBarView: View {
    var body: some View {
        Image("menuIcon")
            .resizable()
            .frame(width: 18, height: 18)
            .accessibilityLabel("Settings")
    }
}
