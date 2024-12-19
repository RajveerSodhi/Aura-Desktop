import SwiftUI

struct RainyView: View {
    var body: some View {
        ZStack {
            RainView(maxRaindrops: 220, angle: 0.0, color: Color(.gray), backgroundColor: Color(.black), backgroundOpacity: 0.2, minLength: 13.0, maxLength: 25.0, minSpeed: 9.0, maxSpeed: 13.0, minStartY: 0.0, maxStartY: 800.0)
            
            RainBottomView(maxRaindrops: 80, rainColor: Color(.gray), startDelay: 1.7)
        }
    }
}
