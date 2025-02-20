import SwiftUI
import Combine

class SplashViewModel: ObservableObject {
    @Environment(\.dependencies.tasks) var tasks
    @State private var cancellables = Set<AnyCancellable>()
    
    
    func fetchConfiguration() {
        tasks.initialize(GetThemeConfigurationTask.self)
            .execute()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { response in
                switch response {
                case .finished:
                    print("splash finished")
                    
                case .failure(let error):
                    _ = error
                }
            }, receiveValue: { response in
                
            })
            .store(in: &cancellables)
    }
    
}
struct SplashView: View {
    @State var viewModel = SplashViewModel()
    
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
            viewModel.fetchConfiguration()
        }
    }
    
}

#Preview {
    SplashView(splashCompleted: .constant(false))
}
