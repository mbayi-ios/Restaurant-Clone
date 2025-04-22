
import SwiftUI

class AccountPageModel: ModelProtocol {
    @Environment(\.dependencies.state.sessionCustomer.customer) var customer
    
}
