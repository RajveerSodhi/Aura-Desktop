import SwiftUI
import AppKit
import CoreGraphics

@main
struct Aura_DesktopApp: App {
    private static var desktopWindow: NSWindow?

    init() {
        if Self.desktopWindow == nil {
            let screenFrame = NSScreen.main?.frame ?? .zero
            let window = NSWindow(
                contentRect: screenFrame,
                styleMask: [.borderless],
                backing: .buffered,
                defer: false
            )
            // Configure window to sit behind everything (desktop level)
            window.level = NSWindow.Level(Int(CGWindowLevelForKey(.desktopWindow)))
            window.isOpaque = false
            window.backgroundColor = .clear
            window.ignoresMouseEvents = true
            window.collectionBehavior = [.canJoinAllSpaces, .stationary]

            // Set SwiftUI view
            window.contentView = NSHostingView(rootView: RainView())
            window.makeKeyAndOrderFront(nil)
            window.orderBack(nil) // Send to the back layer
            Self.desktopWindow = window
        }
    }

    var body: some Scene {
        Settings {
            EmptyView()
        }
    }
}
