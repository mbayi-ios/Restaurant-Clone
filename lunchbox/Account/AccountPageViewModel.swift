import SwiftUI
import Foundation



class AccountPageViewModel: ViewModelProtocol {
   
    @Environment(\.dependencies.tasks) var tasks
    
    @Published var model = AccountPageModel()
    
    var titleText: String {
        guard let firstName = self.model.customer?.firstName,
              let lastName = self.model.customer?.lastName else {
            return String(localized: "Title")
        }
        
        return "\(firstName) \(lastName)"
    }
    
    func handleLogoutRequest() {
        let task = tasks.initialize(SignOutTask.self)
        task.execute()
    }
}
