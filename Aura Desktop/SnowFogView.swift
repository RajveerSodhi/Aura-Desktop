import SwiftUI

struct SnowFogView: View {
    var body: some View {
        FogView(maxFogStreaks: 8, fogColor: Color(.white), fogOpacity: 0.4, blur: 25.0)
    }
}
