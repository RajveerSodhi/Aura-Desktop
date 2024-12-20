import SwiftUI
import AppKit
import CoreGraphics

@main
struct Aura_DesktopApp: App {
    private static var desktopWindow: NSWindow?
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate

    init() {
        if Self.desktopWindow == nil {
            let screenFrame = NSScreen.main?.frame ?? .zero
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

            window.contentView = NSHostingView(rootView: ContentViewController())
            
            window.makeKeyAndOrderFront(nil)
            window.orderBack(nil)
            Self.desktopWindow = window
        }
    }

    var body: some Scene {
        Settings {
            SettingsView()
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusBarItem: NSStatusItem?
    var settingsWindow: NSWindow?

    func applicationDidFinishLaunching(_ notification: Notification) {
        // Create the menu bar item
        statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        if let button = statusBarItem?.button {
            button.image = NSImage(systemSymbolName: "gearshape", accessibilityDescription: "Settings")
            button.action = #selector(showSettings)
            button.target = self
        }
    }

    @objc func showSettings() {
        if settingsWindow == nil {
            let settingsView = SettingsView()
            settingsWindow = NSWindow(
                contentRect: NSRect(x: 0, y: 0, width: 300, height: 150),
                styleMask: [.titled, .closable, .miniaturizable],
                backing: .buffered,
                defer: false
            )
            settingsWindow?.contentView = NSHostingView(rootView: settingsView)
            settingsWindow?.title = "Settings"
        }
        settingsWindow?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
    }
}
