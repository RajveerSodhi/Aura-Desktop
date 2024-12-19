import SwiftUI

struct CloudyWithOptionsView: View {
    let maxClouds: Int
    let cloudColor: Color
    let cloudOpacity: Double
    let blur: Double
    let minSpeed: Double
    let maxSpeed: Double
    let minWidthPercent: Double
    let maxWidthPercent: Double
    let minHeight: Double
    let maxHeight: Double
    let cover: Double
    let cloudType: Int
    
    var body: some View {
        ZStack {
            switch cloudType {
                case 1:
                    CloudView1(maxClouds: maxClouds,
                              cloudColor: cloudColor,
                              cloudOpacity: cloudOpacity,
                              blur: blur,
                              minSpeed: minSpeed,
                              maxSpeed: maxSpeed,
                              minWidthPercent: minWidthPercent,
                              maxWidthPercent: maxWidthPercent,
                              minHeight: minHeight,
                              maxHeight: minHeight,
                               cover: cover
                    )
                case 2:
                    CloudView2(maxClouds: maxClouds,
                               cloudColor: cloudColor,
                               cloudOpacity: cloudOpacity,
                               blur: blur,
                               minSpeed: minSpeed,
                               maxSpeed: maxSpeed,
                               minWidthPercent: minWidthPercent,
                               maxWidthPercent: maxWidthPercent,
                               minHeight: minHeight,
                               maxHeight: minHeight,
                               cover: cover
                    )
                case 3:
                    CloudView3(maxClouds: maxClouds,
                               cloudColor: cloudColor,
                               cloudOpacity: cloudOpacity,
                               blur: blur,
                               minSpeed: minSpeed,
                               maxSpeed: maxSpeed,
                               minWidthPercent: minWidthPercent,
                               maxWidthPercent: maxWidthPercent,
                               minHeight: minHeight,
                               maxHeight: minHeight,
                               cover: cover
                    )
                default:
                    CloudView1(maxClouds: maxClouds,
                               cloudColor: cloudColor,
                               cloudOpacity: cloudOpacity,
                               blur: blur,
                               minSpeed: minSpeed,
                               maxSpeed: maxSpeed,
                               minWidthPercent: minWidthPercent,
                               maxWidthPercent: maxWidthPercent,
                               minHeight: minHeight,
                               maxHeight: minHeight,
                               cover: cover
                    )
            }
        }
    }
}


