//
//  WeatherSettingsManager.swift
//  Aura Desktop
//
//  Created by Rajveer Sodhi on 2025-01-27.
//

import SwiftUI

class AppSettingsManager: ObservableObject {
    static let shared = AppSettingsManager()

    @Published var frameRate: Int {
        didSet { UserDefaults.standard.set(frameRate, forKey: "frameRate") }
    }

    init() {
        let defaults = UserDefaults.standard

        self.frameRate = defaults.object(forKey: "frameRate") as? Int ?? 24
    }
}
