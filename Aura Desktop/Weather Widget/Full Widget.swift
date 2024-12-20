import SwiftUI

struct FullWidget: View {
    @StateObject private var weatherFetcher = WeatherFetcher()

    var body: some View {
        ZStack {
            if let weather = weatherFetcher.weatherData {
                let temperature = String(weather.current.temperature)
                let unit = "°C"
                let condition = weather.current.weather_descriptions.first ?? "N/A"

                Widget(temperature: temperature, unit: unit, condition: condition)
            } else {
                Text("Fetching weather data...")
                    .foregroundColor(.gray)
            }
        }
        .task {
                await weatherFetcher.fetchWeather()
            }
    }
}
