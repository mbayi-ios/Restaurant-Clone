import SwiftUI

struct SplashView: View {
    @Binding var splashCompleted: Bool
    var body: some View {
        ZStack {
            Color.brand
                .ignoresSafeArea()
            VStack {
                Image("logo-white")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                Text("SnackSnap")
                    .fontWeight(.black)
                    .font(.system(size: 36))
                    .foregroundColor(Color.main)
                    .padding()
            }
            
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                splashCompleted = true
            }
        }
    }
}

#Preview {
    SplashView(splashCompleted: .constant(false))
}
