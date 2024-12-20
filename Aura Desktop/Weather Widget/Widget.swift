import SwiftUI

struct Widget: View {
    let temperature: String
    let unit: String
    let condition: String

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white.opacity(0.1))
                .cornerRadius(30)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)

            VStack(spacing: 8) {
                Text("\(temperature)\(unit)")
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                
                Text(condition)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .foregroundColor(.white.opacity(0.8))
            }
            .padding(10)
        }
        .frame(width: 180, height: 180)
    }
}

// Preview
#Preview {
    Widget(
        temperature: "20",
        unit: "°C",
        condition: "Sunny"
    )
}
