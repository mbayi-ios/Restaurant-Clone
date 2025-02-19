import SwiftUI

struct BaseNavigationView<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder _ content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        NavigationView {
            content
        }
    }
}


struct BaseView<Content:View>: View {
    let content: Content
    
    init(@ViewBuilder _ content: () -> Content) {
        self.content = content()
    }
    var body: some View  {
        content
    }
}
