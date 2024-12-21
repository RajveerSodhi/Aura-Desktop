import SwiftUI

class WeatherFetcher: ObservableObject {
    @Published var weatherData: WeatherData?

    private let apiKey: String = "3b0216ae8f1704869334c2f0cd6b65c3"
    private let units: String = "m"
    private let baseUrl: String = "https://api.weatherstack.com"
    private let query: String = "fetch:ip"

    func fetchWeather() async {
        
        do {
            let url = URL(string: "\(baseUrl)/current?access_key=\(apiKey)&query=\(query)&units=\(units)")!
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decodedData = try JSONDecoder().decode(WeatherData.self, from: data)
            DispatchQueue.main.async {
                self.weatherData = decodedData
                print("Fetched Weather Data: \(decodedData)")
            }
        } catch {
            print("Error fetching weather data in WeatherFetcher: \(error.localizedDescription)")
        }
    }
}
