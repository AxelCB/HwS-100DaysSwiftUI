import SwiftUI

struct LargeBlueTitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

extension View {
    func largeBlueTitleStyle() -> some View {
        modifier(LargeBlueTitleModifier())
    }
}
