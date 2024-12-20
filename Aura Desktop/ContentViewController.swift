import SwiftUI
import CoreLocation

struct ContentViewController: View {
    @StateObject private var weatherFetcher = WeatherFetcher()
    @State private var weatherCondition: String = "Light Snowy"
    let weatherConditionMapper = ["Sunny": SunnyView(),
                                  "Partly cloudy": SunnyView(),
                                  "Cloudy": CloudyView(),
                                  "Overcast": DarkCloudyView(),
                                  "Mist": FoggyView(),
                                  "Patchy rain possible": LightRainyView(),
                                  "Patchy snow possible": LightSnowyView(),
                                  "Patchy sleet possible": LightSnowyView(),
                                  "Patchy freezing drizzle possible": LightRainyView(),
                                  "Thundery outbreaks possible": StormyView(),
                                  "Blowing snow": SnowyView(),
                                  "Blizzard": SnowStormyView(),
                                  "Fog": FoggyView(),
                                  "Freezing fog": FoggyView(),
                                  "Patchy light drizzle": LightRainyView(),
                                  "Light drizzle": LightRainyView(),
                                  "Freezing drizzle": LightRainyView(),
                                  "Heavy freezing drizzle": LightRainyView(),
                                  "Patchy light rain": LightRainyView(),
                                  "Light rain": LightRainyView(),
                                  "Moderate rain at times": RainyView(),
                                  "Moderate rain": RainyView(),
                                  "Heavy rain at times": RainyView(),
                                  "Heavy rain": RainyView(),
                                  "Light freezing rain": RainyView()
    ] as [String : Any]
    
    var body: some View {
        ZStack {
//            weatherConditionMapper[weatherCondition] ?? EmptyView()
            
            if weatherCondition.contains("Sunny") {
                            SunnyView()
            } else if weatherCondition.contains("Snow") {
                SnowyView()
            } else if weatherCondition.contains("Rain") {
                RainyView()
            } else if weatherCondition.contains("Cloud") {
                CloudyView()
            } else {
                Text("Fetching Weather...")
                    .font(.largeTitle)
                    .foregroundColor(.gray)
            }
            
            Widget(temperature: "23", unit: "°C", condition: "Cloudy")
//            FullWidget()
        }
        .onAppear {
            Task {
                await fetchWeather()
            }
        }
    }
    
    func fetchWeather() async {
            do {
                await weatherFetcher.fetchWeather()
                if let weather = weatherFetcher.weatherData {
                    weatherCondition = weather.current.weather_descriptions.first ?? "Unknown"
                }
            } catch {
                print("Error fetching weather: \(error.localizedDescription)")
                weatherCondition = "Snow"
            }
        }
}

