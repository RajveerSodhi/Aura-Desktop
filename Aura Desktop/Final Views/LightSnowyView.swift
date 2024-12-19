import SwiftUI

struct LightSnowyView: View {
    let fog: Bool = true
    
    var body: some View {
        ZStack {
            if fog {
                SnowFogView()
            }
            
            
            SnowView(maxSnowflakes: 120, angle: 0.0, backgroundColor: Color(.blue), backgroundOpacity: 0.1, minSize: 1.0, maxSize: 8.0, minSpeed: 1.0, maxSpeed: 1.7, minStartY: 0.0, maxStartY: 1000.0, wind: true)
            
            // set maxSnowflakes to 50 * (1 - angles/100.0)
            SnowBottomView(maxSnowflakes: 50, startDelay: 12.0, minSize: 1.0, maxSize: 7.0)
        }
    }
}
