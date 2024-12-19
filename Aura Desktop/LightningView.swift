import SwiftUI

struct LightningView: View {
    @State private var flashOpacity: Double = 0.0
    
    let lightningStrikesPerMinute: Int

    var body: some View {
        ZStack {
            Color.white
                .opacity(flashOpacity)
                .ignoresSafeArea()
                .animation(.easeOut(duration: 0.2), value: flashOpacity)
        }
        .onAppear {
            scheduleLightningFlashes()
        }
    }

    func scheduleLightningFlashes() {
        let averageInterval = 60.0 / Double(lightningStrikesPerMinute)
        
        let randomInterval = Double.random(in: averageInterval * 0.5...averageInterval * 1.5)

        Timer.scheduledTimer(withTimeInterval: randomInterval, repeats: false) { _ in
            flashOpacity = Double.random(in: 0.4...0.8)

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                flashOpacity = 0.0
            }

            scheduleLightningFlashes()
        }
    }
}
