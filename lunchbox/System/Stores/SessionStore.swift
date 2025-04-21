import SwiftUI
import Foundation
import Combine

struct SessionStore {
    private static let currentCustomer = "current_customer"
    private var keyStore: KeyStore
    
    var currentCustomer = CurrentValueSubject<Customer?, Never>(nil)
    
    init(keyStore: KeyStore) {
        self.keyStore = keyStore
    }
    
    func clear() {
        currentCustomer.send(nil)
    }
}
