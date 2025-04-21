import Combine
import SwiftUI
import Foundation

class AuthStatus: ObservableObject {
    @Published private(set) var isLoggedIn: Bool = false
    
    private var cancellables: Set<AnyCancellable> = []
    private let sessionStore: SessionStore
    
    init(sessionStore: SessionStore) {
        self.sessionStore = sessionStore
        
        sessionStore.currentCustomer
            .receive(on: DispatchQueue.main)
            .sink { customer  in
                self.isLoggedIn = !(customer?.isGuest ?? true )
            }.store(in: &cancellables)
    }
}
