import SwiftUI

struct WeatherSettingsView: View {
    @AppStorage("city") private var city = "Kelowna"
    @AppStorage("temperatureUnit") private var temperatureUnit = "Celsius"
    
    // RainView settings
    @AppStorage("rainMaxRaindrops") private var rainMaxRaindrops: Double = 220
    @AppStorage("rainMinLength") private var rainMinLength: Double = 13.0
    @AppStorage("rainMaxLength") private var rainMaxLength: Double = 25.0
    @AppStorage("rainMinSpeed") private var rainMinSpeed: Double = 9.0
    @AppStorage("rainMaxSpeed") private var rainMaxSpeed: Double = 13.0
    @AppStorage("rainBottomMaxRaindrops") private var rainBottomMaxRaindrops: Double = 80
    @AppStorage("rainBottomStartDelay") private var rainBottomStartDelay: Double = 1.7

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
            
            Section(header: Text("Rain Settings")) {
                SliderSettingView(label: "Max Raindrops (RainView)", value: $rainMaxRaindrops, range: 100...500, step: 10)
                SliderSettingView(label: "Min Length", value: $rainMinLength, range: 5...30, step: 1)
                SliderSettingView(label: "Max Length", value: $rainMaxLength, range: 10...50, step: 1)
                SliderSettingView(label: "Min Speed", value: $rainMinSpeed, range: 5...15, step: 0.5)
                SliderSettingView(label: "Max Speed", value: $rainMaxSpeed, range: 10...20, step: 0.5)
                SliderSettingView(label: "Bottom Raindrops", value: $rainBottomMaxRaindrops, range: 20...200, step: 10)
                SliderSettingView(label: "Bottom Start Delay", value: $rainBottomStartDelay, range: 0.5...3.0, step: 0.1)
            }
        }
        .padding()
    }
}

struct SliderSettingView: View {
    let label: String
    @Binding var value: Double
    let range: ClosedRange<Double>
    let step: Double

    var body: some View {
        VStack {
            Text("\(label): \(Int(value))")
                .font(.caption)
            Slider(value: $value, in: range, step: step)
        }
    }
}
