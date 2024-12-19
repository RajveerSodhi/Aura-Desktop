import SwiftUI

struct CloudCoverView: View {
    let maxClouds = 15
    let cloudColor = Color(.white)
    let cloudOpacity = 0.8
    let blur = 12.0
    let minSpeed = 0.3
    let maxSpeed = 0.6
    let minWidthPercent = 22.0
    let maxWidthPercent = 40.0
    let minHeight = 85.0
    let maxHeight = 155.0
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
