import SwiftUI
import Combine
import Nuke


class ThemeConfigurationState: ObservableObject {
    
    @Published private(set) var themeConfiguration: ThemeConfiguration?
    
    private var cancellables: Set<AnyCancellable> = []
    private let themeConfigurationStore: ThemeConfigurationStore
    private let prefetcher = ImagePrefetcher()
    
    init(themeConfigurationStore: ThemeConfigurationStore) {
        self.themeConfigurationStore = themeConfigurationStore
        
        themeConfigurationStore.themeConfiguration
            .receive(on: DispatchQueue.main)
            .sink { configuration in
                self.themeConfiguration = configuration
              
                self.prefetchImages()
                
            }.store(in: &cancellables)
    }
    
    private func prefetchImages() {
       
        var imagesForPrefetch = [URL]()
        
//        if let themeImages = themeConfiguration?.settings?.themeImages {
//            if let image = themeImages.logoUrl, let imageUrl = URL(string: image) {
//                imagesForPrefetch.append(imageUrl)
//            }
//        }
        
        prefetcher.startPrefetching(with: imagesForPrefetch)
        print("this is",imagesForPrefetch)
    }
}
