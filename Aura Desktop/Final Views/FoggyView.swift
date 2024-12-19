import SwiftUI

struct FoggyView: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.2)
            
            FogView(maxFogStreaks: 12, fogColor: Color(.white), fogOpacity: 0.5, blur: 34.0, minWidthPercent: 45.0, maxWidthPercent: 80.0, minHeight: 38.0, maxHeight: 60.0, minSpeed: 0.5, maxSpeed: 1.6)
        }
    }
}
