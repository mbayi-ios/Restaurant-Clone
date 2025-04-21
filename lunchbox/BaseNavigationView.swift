import SwiftUI

struct BaseNavigationView<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder _ content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        NavigationView {
            DefaultSurface {
                content
                    .background(Color.gray.opacity(0.2))
            }
        }
    }
}


struct DefaultSurface<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder _ content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .background(Color.gray.opacity(0.2))
    }
}
