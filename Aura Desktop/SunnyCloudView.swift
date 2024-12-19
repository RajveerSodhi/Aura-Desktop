import SwiftUI

struct SunnyCloudView: View {
    var body: some View {
        ZStack {
            CloudView3(maxClouds: 5,
                      cloudColor: Color(.white),
                      cloudOpacity: 0.8,
                      blur: 0.0,
                      minSpeed: 0.35,
                      maxSpeed: 0.8,
                      minWidthPercent: 18.0,
                      maxWidthPercent: 30.0,
                      minHeight: 70.0,
                      maxHeight: 135.0
            )
        }
    }
}

