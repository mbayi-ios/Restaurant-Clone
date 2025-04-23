import Combine
import SwiftUI

class ThemeConfigurationRepository: Repository {
    private let client: HTTPClient
    private let store: ThemeConfigurationStore
    
    init(client: HTTPClient, store: ThemeConfigurationStore) {
        self.client = client
        self.store = store
    }
    
    func getThemeConfiguration() -> AnyPublisher<ThemeConfiguration, Error> {
        let request = GetThemeConfigurationRequest()
        
        return client.perform(request).tryMap { response in
            let configuration = ThemeConfiguration(response: response.data)
            
            
           self.store.storeThemeConfiguration(configuration)
            
            return configuration
            
        }.eraseToAnyPublisher()
    }
}
