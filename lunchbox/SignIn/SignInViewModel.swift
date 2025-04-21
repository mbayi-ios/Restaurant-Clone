import SwiftUI
import Combine

class SignInViewModel: ObservableObject {
    @Environment(\.dependencies.tasks) var tasks
    @Published var model = SignInModel()
    @Published var isLoading: Bool = false
    
    
    var dismissalPublisher = PassthroughSubject<Bool, Never>()
    private var shouldDismissView = false {
        didSet {
            dismissalPublisher.send(shouldDismissView)
        }
    }
    
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
                self.getCustomerMe()
                    print("success login")
            }))
    }
    
    
    func getCustomerMe() {
        let task = tasks.initialize(GetCustomerMeTask.self)
        
        return task.execute()
            .receive(on: DispatchQueue.main)
            .subscribe(Subscribers.Sink(receiveCompletion: { response in
                switch response {
                case .finished:
                    self.shouldDismissView = true
                    self.isLoading = false
                case .failure(_):
                    self.isLoading = false
                }
            }, receiveValue: { _ in }))
    }
}
