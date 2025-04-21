import SwiftUI
import Foundation



class AccountPageViewModel: ViewModelProtocol {
   
    @Environment(\.dependencies.tasks) var tasks
    
    @Published var model = AccountPageModel()
    
    func handleLogoutRequest() {
        let task = tasks.initialize(SignOutTask.self)
        task.execute()
    }
}
