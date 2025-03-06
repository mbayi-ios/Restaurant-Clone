import SwiftUI 
class SignInModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
}
