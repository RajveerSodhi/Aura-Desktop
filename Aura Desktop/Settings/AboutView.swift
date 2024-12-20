import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack(spacing: 10) {
            Text("Aura Desktop")
                .font(.largeTitle)
                .bold()
            Text("Version 1.0")
                .foregroundColor(.gray)
            Text("Developed by Your Name")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding()
    }
}
