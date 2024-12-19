import SwiftUI

struct DarkCloudCoverView: View {
    let maxClouds = 16
    let cloudColor = Color(.gray)
    let cloudOpacity = 0.9
    let blur = 12.0
    let minSpeed = 0.4
    let maxSpeed = 0.8
    let minWidthPercent = 23.0
    let maxWidthPercent = 45.0
    let minHeight = 100.0
    let maxHeight = 160.0
    let cover = 0.95
    let cloudType = 1
    
    var body: some View {
        CloudyWithOptionsView(
            maxClouds: maxClouds,
            cloudColor: cloudColor,
            cloudOpacity: cloudOpacity,
            blur: blur,
            minSpeed: minSpeed,
            maxSpeed: maxSpeed,
            minWidthPercent: minWidthPercent,
            maxWidthPercent: maxWidthPercent,
            minHeight: minHeight,
            maxHeight: maxHeight,
            cover: cover,
            cloudType: cloudType
        )
    }
}
