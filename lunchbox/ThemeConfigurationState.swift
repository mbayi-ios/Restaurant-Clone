import SwiftUI
import Combine

struct ThemeConfigurationStore {
    private static let themeConfigurationKey = "client_configuration"
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    var themeConfiguration = CurrentValueSubject<ThemeConfiguration?, Never>(nil)
    
    init() {
        themeConfiguration.send(storedThemeConfiguration())
    }
    
    func storeThemeConfiguration(_ configuration: ThemeConfiguration?) {
        guard configuration != nil, let data = try? encoder.encode(configuration) else {
            
            UserDefaults.standard.removeObject(forKey: ThemeConfigurationStore.themeConfigurationKey)
            
            themeConfiguration.send(nil)
            return
        }
        print("data is \(data)")
        
        UserDefaults.standard.set(data, forKey: ThemeConfigurationStore.themeConfigurationKey)
        
        themeConfiguration.send(configuration)
    }
    
    private func storedThemeConfiguration() -> ThemeConfiguration? {
        guard let data = UserDefaults.standard.data(forKey: ThemeConfigurationStore.themeConfigurationKey),
              let configuration = try? decoder.decode(ThemeConfiguration.self, from: data) else {
            return nil
        }
        
        return configuration
    }
    
    func clearThemeConfig() {
        themeConfiguration.send(nil)
    }
}

class ThemeConfigurationState: ObservableObject {
    
    @Published private(set) var themeConfiguration: ThemeConfiguration?
    
    private var cancellables: Set<AnyCancellable> = []
    private let themeConfigurationStore: ThemeConfigurationStore
    
    init(themeConfigurationStore: ThemeConfigurationStore) {
        self.themeConfigurationStore = themeConfigurationStore
        
        themeConfigurationStore.themeConfiguration
            .receive(on: DispatchQueue.main)
            .sink { configuration in
                self.themeConfiguration = configuration
              //  print("hey this is configuration \(configuration)")
            }.store(in: &cancellables)
    }
}
