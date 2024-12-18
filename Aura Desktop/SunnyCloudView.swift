import SwiftUI

struct SunnyCloudView: View {
    var body: some View {
        ZStack {
            CloudView(maxClouds: 4,
                      cloudColor: Color(.white),
                      cloudOpacity: 0.6,
                      blur: 15.0,
                      minSpeed: 0.35,
                      maxSpeed: 0.8,
                      minWidthPercent: 18.0,
                      maxWidthPercent: 35.0,
                      minHeight: 67.0,
                      maxHeight: 100.0
            )
        }
    }
}

