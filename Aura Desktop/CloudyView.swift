import SwiftUI

struct CloudyView: View {
    var body: some View {
        ZStack {
            DayBackgroundView(backgroundOpacity: 0.25)
            
            CloudCoverView()
        }
    }
}
