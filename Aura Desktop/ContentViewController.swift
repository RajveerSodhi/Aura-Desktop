import SwiftUI
import CoreLocation

struct ContentViewController: View {
//    @StateObject private var weatherFetcher = WeatherFetcher()
    @State private var weatherCondition: String = "Fetching Weather..."
    
    var body: some View {
        ZStack {
            weatherView(for: "blowing snow")
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                Widget(temperature: "23", unit: "°C", condition: weatherCondition)
                    .padding()
            }
        }
        .onAppear {
            Task {
//                await fetchWeather()
            }
        }
    }
    
    @ViewBuilder
    private func weatherView(for condition: String) -> some View {
        switch condition.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) {
        case "sunny", "partly cloudy":
            SunnyView()
        case "cloudy":
            CloudyView()
        case "overcast":
            DarkCloudyView()
        case "mist", "fog", "freezing fog":
            FoggyView()
        case "patchy rain possible", "patchy freezing drizzle possible", "patchy light drizzle", "light drizzle",
             "freezing drizzle", "heavy freezing drizzle", "patchy light rain", "light rain", "light freezing rain":
            LightRainyView()
        case "moderate rain", "moderate rain at times", "heavy rain", "heavy rain at times":
            RainyView()
        case "patchy snow possible", "patchy sleet possible":
            LightSnowyView()
        case "blowing snow":
            SnowyView()
        case "thundery outbreaks possible":
            StormyView()
        case "blizzard":
            SnowStormyView()
        default:
            Color.clear.frame(maxWidth: .infinity)
        }
    }
    
//    func fetchWeather() async {
//        await weatherFetcher.fetchWeather()
//        if let weather = weatherFetcher.weatherData {
//            weatherCondition = weather.current.weather_descriptions.first ?? "Unknown"
//            print(weatherCondition)
//        } else {
//            print("Failed to fetch weather data.")
//            weatherCondition = "Error"
//        }
//    }
}
