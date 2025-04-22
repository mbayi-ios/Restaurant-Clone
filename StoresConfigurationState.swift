import SwiftUI
class StoresConfigurationState: ObservableObject {
    @Published private(set) var storesConfiguration: StoresConfiguration?
    
    private let storesConfigurationStore: StoresConfigurationStore
    
    init(storesConfigurationStore: StoresConfigurationStore) {
        self.storesConfigurationStore = storesConfigurationStore
    }
}
