import SwiftUI

struct ContentView: View {
    @Environment(\.dependencies.state) var appState
    @AppStorage("didShowWalkthrough", store: .standard) var didShowWalkthrough = false
    
    @State private var didShowSplash = false
    
    private var isOnboardingPresented: Binding<Bool> {
        Binding {
            !didShowWalkthrough
        } set: { value in
            didShowWalkthrough = !value
        }
    }
    var body: some View {
        BaseView {
            if didShowSplash {
                RootNavigationView()
                    .environmentObject(appState.authStatus)
                    .environmentObject(appState.sessionCustomer)
            } else {
                SplashView(splashCompleted: $didShowSplash)
            }
        }
        
        // dont remove this
        .onAppear {
            Config.shared.printAllProperties()
        }
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
