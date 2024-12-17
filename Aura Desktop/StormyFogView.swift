import SwiftUI

struct StormyFogView: View {
    var body: some View {
        FogView(maxFogStreaks: 8, fogColor: Color(.gray), fogOpacity: 0.6, blur: 22.0)
    }
}

