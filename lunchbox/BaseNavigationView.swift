import SwiftUI

struct BaseNavigationView<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder _ content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        NavigationView {
            content
                .background(Color.gray.opacity(0.2))
        }
    }
}


