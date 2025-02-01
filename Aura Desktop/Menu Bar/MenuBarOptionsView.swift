//
//  MenuBarOptionsView.swift
//  Aura Desktop
//
//  Created by Rajveer Sodhi on 2025-01-27.
//

import SwiftUI

struct MenuBarOptionsView: View {
    @AppStorage("isEnabled") private var isEnabled: Bool = true
    
    func quit() {
        NSApp.terminate(nil)
    }
    
    func toggleEnabled() {
        isEnabled = !isEnabled
    }
    
    var body: some View {
        VStack() {
            Button(isEnabled ? "Disable" : "Enable") {
                toggleEnabled()
            }

            SettingsLink {
                Text("Preferences")
            }
            
            Divider()
            
            Button("Quit") {
                quit()
            }
        }
    }
}

#Preview {
    MenuBarOptionsView()
}
