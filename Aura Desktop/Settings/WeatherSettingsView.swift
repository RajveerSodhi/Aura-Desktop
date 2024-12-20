import SwiftUI

struct WeatherSettingsView: View {
    @AppStorage("temperatureUnit") private var temperatureUnit = "Celsius"
    @AppStorage("city") private var city = "Kelowna"

    var body: some View {
        Form {
            Section(header: Text("Weather Settings")) {
                TextField("City", text: $city)

                Picker("Temperature Unit", selection: $temperatureUnit) {
                    Text("Celsius").tag("Celsius")
                    Text("Fahrenheit").tag("Fahrenheit")
                }
                .pickerStyle(SegmentedPickerStyle())
            }
        }
        .padding()
    }
}
