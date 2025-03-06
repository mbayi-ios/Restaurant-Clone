import SwiftUI
import Combine

class SignInViewModel: ObservableObject {
    @Environment(\.dependencies.tasks) var tasks
    @Published var model = SignInModel()
    
    func handleSignIn() {
        let taskModel = SignInTask.Model(email: model.email, password: model.password)
        
        let task = tasks.initialize(SignInTask.self)
        
        return task.execute(with: taskModel)
            .receive(on: DispatchQueue.main)
            .subscribe(Subscribers.Sink(receiveCompletion: { response in
                switch response {
                case .finished:
                    break
                case .failure(let error):
                    print("the error is \(error)")
                }
            }, receiveValue: { response in
                    print("success")
            }))
    }
    
}
