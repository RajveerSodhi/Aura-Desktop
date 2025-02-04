import SwiftUI
import AppKit
import CoreGraphics

@main
struct Aura_DesktopApp: App {
    private static var desktopWindow: NSWindow?
    @AppStorage("selectedDisplayOption") private var selectedDisplayOption: String = "defaultDisplay"

    init() {
        Self.configureWindow(for: selectedDisplayOption)
        }

        static func configureWindow(for option: String) {
            let selectedScreen: NSScreen?

            switch option {
            case "defaultDisplay":
                selectedScreen = NSScreen.screens.first
            case "activeMenuBar":
                selectedScreen = NSScreen.main
            default:
                selectedScreen = NSScreen.main
            }

            guard let screenFrame = selectedScreen?.frame else { return }

            if Self.desktopWindow == nil {
                let window = NSWindow(
                    contentRect: screenFrame,
                    styleMask: [.borderless],
                    backing: .buffered,
                    defer: false
                )
                window.level = NSWindow.Level(Int(CGWindowLevelForKey(.desktopWindow)))
                window.isOpaque = false
                window.backgroundColor = .clear
                window.ignoresMouseEvents = true
                window.collectionBehavior = [.canJoinAllSpaces, .stationary]
                window.contentView = NSHostingView(rootView: RainView())
                window.makeKeyAndOrderFront(nil)
                window.orderBack(nil)
                Self.desktopWindow = window
            } else {
                Self.desktopWindow?.setFrame(screenFrame, display: true)
            }
        }

    var body: some Scene {
        MenuBarExtra {
            Picker("Display:", selection: $selectedDisplayOption) {
                Text("Default Display").tag("defaultDisplay")
                Text("Active Menu Bar").tag("activeMenuBar")
            }
            .pickerStyle(RadioGroupPickerStyle())
            .onChange(of: selectedDisplayOption) { oldValue, newValue in
                Self.configureWindow(for: newValue)
            }

            MenuBarOptionsView()
        } label: {
            MenuBarView()
        }
        Settings {
            SettingsView()
        }
    }
}
