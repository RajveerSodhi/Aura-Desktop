import SwiftUI

struct LightRainyView: View {
    var body: some View {
        ZStack {
            RainView(maxRaindrops: 150, angle: 0.0, color: Color(.gray), backgroundColor: Color(.black),
                     backgroundOpacity: 0.1, minLength: 10.0, maxLength: 20.0, minSpeed: 5.0, maxSpeed: 9.0, minStartY: 0.0, maxStartY: 900.0)
            
            RainBottomView(maxRaindrops: 70, rainColor: Color(.gray), startDelay: 2.0)
        }
    }
}
