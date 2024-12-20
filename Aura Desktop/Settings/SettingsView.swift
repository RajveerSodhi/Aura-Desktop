import SwiftUI

struct SettingsView: View {
    @State private var selectedSection: SettingsSection? = .general

    var body: some View {
        NavigationSplitView {
            List(SettingsSection.allCases, id: \.self, selection: $selectedSection) { section in
                Label(section.title, systemImage: section.icon)
            }
            .listStyle(SidebarListStyle())
            .frame(minWidth: 150)
        } detail: {
            Group {
                switch selectedSection {
                case .general:
                    GeneralSettingsView()
                case .weather:
                    WeatherSettingsView()
                case .about:
                    AboutView()
                case .none:
                    Text("Select a section")
                        .foregroundColor(.gray)
                }
            }
            .padding()
        }
        .navigationTitle("Settings")
    }
}

enum SettingsSection: String, CaseIterable {
    case general
    case weather
    case about

    var title: String {
        switch self {
        case .general: return "General"
        case .weather: return "Weather"
        case .about: return "About"
        }
    }

    var icon: String {
        switch self {
        case .general: return "gearshape"
        case .weather: return "cloud.sun"
        case .about: return "info.circle"
        }
    }
}

#Preview {
    SettingsView()
}
