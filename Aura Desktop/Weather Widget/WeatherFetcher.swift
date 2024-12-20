import SwiftUI

class WeatherFetcher: ObservableObject {
    @Published var weatherData: WeatherData?

    private let apiKey: String = "3b0216ae8f1704869334c2f0cd6b65c3"
    private let units: String = "m"

    func fetchWeather() async {
        
        do {
            let url = URL(string: "http://api.weatherstack.com/current?access_key=\(apiKey)&query=Kelowna&units=\(units)")!
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decodedData = try JSONDecoder().decode(WeatherData.self, from: data)
            DispatchQueue.main.async {
                self.weatherData = decodedData
                print("Fetched Weather Data: \(decodedData)")
            }
        } catch {
            print("Error fetching weather data: \(error.localizedDescription)")
        }
    }
}
