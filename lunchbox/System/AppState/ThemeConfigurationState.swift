import SwiftUI
import Combine



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
