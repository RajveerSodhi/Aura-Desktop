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
            // Configure window to sit behind everything
            window.level = NSWindow.Level(Int(CGWindowLevelForKey(.desktopWindow)))
            window.isOpaque = false
            window.backgroundColor = .clear
            window.ignoresMouseEvents = true
            window.collectionBehavior = [.canJoinAllSpaces, .stationary]
            
            // Set SwiftUI view
            window.contentView = NSHostingView(rootView: SnowfallView())
            window.makeKeyAndOrderFront(nil)
            window.orderBack(nil) // Send it to the back
            Self.desktopWindow = window
        }
    }

    var body: some Scene {
        Settings {
            EmptyView() // No visible settings window
        }
    }
}

struct SnowfallView: View {
    @State private var snowflakes: [Snowflake] = []

    var body: some View {
        GeometryReader { geo in
            ZStack {
                // Snowflakes
                ForEach(snowflakes) { snowflake in
                    Circle()
                        .frame(width: snowflake.size, height: snowflake.size)
                        .foregroundColor(.white)
                        .position(x: snowflake.x, y: snowflake.y)
                        .opacity(0.8) // Slight transparency for realism
                        .animation(.linear(duration: 5), value: snowflake.y)
                }
            }
            .onAppear {
                startSnowfall(screenWidth: geo.size.width, screenHeight: geo.size.height)
            }
            .background(Color.clear) // Transparent background
        }
        .ignoresSafeArea()
    }

    // Function to add and animate snowflakes
    func startSnowfall(screenWidth: CGFloat, screenHeight: CGFloat) {
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { _ in
            let newSnowflake = Snowflake(
                id: UUID(),
                x: CGFloat.random(in: 0...screenWidth),
                y: -10, // Start above the screen
                size: CGFloat.random(in: 5...15),
                speed: CGFloat.random(in: 2...6)
            )
            snowflakes.append(newSnowflake)

            // Move snowflakes
            for i in snowflakes.indices {
                snowflakes[i].y += snowflakes[i].speed
            }

            // Remove snowflakes that fall below the screen
            snowflakes.removeAll { $0.y > screenHeight + 50 }
        }
    }
}
