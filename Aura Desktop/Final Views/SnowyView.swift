import SwiftUI

struct SnowyView: View {
    let fog: Bool = true
    
    var body: some View {
        ZStack {
            if fog {
                SnowFogView()
            }
            
            SnowView(maxSnowflakes: 200, angle: 0.0, backgroundColor: Color(.blue), backgroundOpacity: 0.2, minSize: 5.0, maxSize: 13.0, minSpeed: 1.0, maxSpeed: 3.0, minStartY: 0.0, maxStartY: 1000.0, wind: true)
            
            // set maxSnowflakes to 80 * (1 - angles/100.0)
            SnowBottomView(maxSnowflakes: 80, startDelay: 8.0, minSize: 5.0, maxSize: 13.0)
        }
    }
}
