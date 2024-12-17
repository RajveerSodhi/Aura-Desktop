import SwiftUI

struct Cloud: Identifiable {
    let id: UUID
    var x: CGFloat
    var y: CGFloat
    var width: CGFloat
    var height: CGFloat
    var speed: CGFloat
    var shapeType: Int
}
