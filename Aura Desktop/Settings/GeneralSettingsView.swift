import SwiftUI

struct GeneralSettingsView: View {
    var body: some View {
        Form {
            Text("General Settings")
            Toggle("Enable Notifications", isOn: .constant(true))
            Toggle("Launch at Login", isOn: .constant(false))
        }
        .padding()
    }
}
