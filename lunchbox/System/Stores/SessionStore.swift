import SwiftUI
import Foundation
import Combine

struct SessionStore {
    private static let currentCustomer = "current_customer"
    private static let customerAuthorizationKey = "customer_authorization_key"
    private static let sessionKey = "session_key"
    private static let routeKey = "route_key"
    private static let customerDeviceTokenKey = "customer_device_token"
    private static let firstTimeNovadine = "first_time_novadine"
    private static let popUpMessageKey = "pop_up_message"
    
    private var keyStore: KeyStore
    
    var currentCustomer = CurrentValueSubject<Customer?, Never>(nil)
    var currentAuthToken = CurrentValueSubject<String?, Never>(nil)
    var currentSessionToken = CurrentValueSubject<String?, Never>(nil)
    var currentRouteId = CurrentValueSubject<String?, Never>(nil)
    var currentDeviceToken = CurrentValueSubject<String?, Never>(nil)
    //var loyalty = CurrentValueSubject<Loyalty?, Never>(nil)
    //var popUpMessage = CurrentValueSubject<StoredPopUpMessage?, Never>(nil)
    
    init(keyStore: KeyStore) {
        self.keyStore = keyStore
        
        currentCustomer.send(storedCurrentCustomer())
        currentAuthToken.send(storedAuthToken())
        currentSessionToken.send(storedSessionToken())
        currentRouteId.send(storedRouteId())
        currentDeviceToken.send(storedDeviceToken())
    }
    
    func storeRouteId(routeId: String) {
        keyStore.set(value: routeId, for: SessionStore.routeKey)
        
        currentRouteId.send(routeId)
    }
    
    func storeCurrentCustomer(_ customer: Customer) {
        guard let encodedCustomer = try? JSONEncoder().encode(customer) else{
            return
        }
        keyStore.set(value: encodedCustomer, for: SessionStore.currentCustomer)
        currentCustomer.send(customer)
    }
    
    func storeCustomerAuhtorization(token: String) {
        keyStore.set(value: token, for: SessionStore.customerAuthorizationKey)
        
        currentAuthToken.send(token)
    }
    
    func storeSessionToken(token: String ) {
        keyStore.set(value: token, for: SessionStore.sessionKey)
        currentSessionToken.send(token)
    }
    
    func storedDeviceToken() -> String? {
        return keyStore.get(SessionStore.customerDeviceTokenKey) as? String
    }
    
    func storedRouteId() -> String? {
        return keyStore.get(SessionStore.routeKey) as? String
    }
    
    func storedSessionToken() -> String? {
        return keyStore.get(SessionStore.sessionKey) as? String
    }
    func storedAuthToken() -> String? {
        return keyStore.get(SessionStore.customerAuthorizationKey) as? String
        
    }
    
    func storedCurrentCustomer() -> Customer? {
        guard let data = keyStore.get(SessionStore.currentCustomer) as? Data else {
            return nil
        }
        
        return try? JSONDecoder().decode(Customer.self, from: data)
    }
    
    func clear() {
        currentCustomer.send(nil)
    }
}
