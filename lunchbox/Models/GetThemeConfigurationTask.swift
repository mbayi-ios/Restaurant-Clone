import Foundation
import Combine

protocol Task {
    associatedtype RepositoryType: Repository
    
    init(repository: RepositoryType)
}

protocol TaskCombine {
    associatedtype CombineResponse
}

protocol TaskCombineNoninjectable: Task, TaskCombine {
    func execute() -> AnyPublisher<CombineResponse, Error>
}

protocol TaskModelInjectable: Task {
    associatedtype Model
}

protocol TaskInjectable: TaskModelInjectable {
    func execute(with object: Model)
}

protocol TaskCombineInjectable: TaskModelInjectable, TaskCombine {
    func execute(with object: Model) -> AnyPublisher<CombineResponse, Error>
    
}

struct GetThemeConfigurationTask: TaskCombineNoninjectable {
    typealias Model = String
    typealias RepositoryType = ThemeConfigurationRepository
    typealias CombineResponse = ThemeConfiguration
    
    private let repository: RepositoryType
    
    init(repository: RepositoryType) {
        self.repository = repository
    }
    
    func execute() -> AnyPublisher<CombineResponse, Error> {
        return repository.getThemeConfiguration()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
       
    }
}

struct GetThemeConfigurationPayload: Encodable {
    
}

struct GetThemeConfigurationResponse: Decodable {
    let data: AssetData?
}

struct AssetData: Codable {
    let hub_marketing: [AssetHubMarketing]?
}

struct AssetHubMarketing: Codable {
    let image: String?
    let title: String?
    let button_url: String?
    let button_text: String?
    let description: String?
}

extension ThemeConfiguration {
    init(response: AssetData?) {
        self.tenantId =  "" // fix me
        self.settings = Settings(response: response)
        
    }
}
extension ThemeConfiguration.Settings {
    init(response: AssetData?) {
        self.hubMarketing = response?.hub_marketing?.compactMap {HubMarketing(response: $0) }
    }
}

extension ThemeConfiguration.Settings.HubMarketing {
    init(response: AssetHubMarketing) {
        self.image = response.image
        self.title = response.title
        self.buttonURL = response.button_url
        self.buttonText = response.button_text
        self.description = response.description
    }
}

struct GetThemeConfigurationRequest: HTTPRequest {
    typealias Payload = GetThemeConfigurationPayload
    typealias Response = GetThemeConfigurationResponse
    
    let path: HTTPEndpoint = NovadineEndpoint.theme_config
    
    let method = HTTPMethod.GET
    var body: Payload?
}

protocol Repository {
    
}

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
            print("configuration")
            
           self.store.storeThemeConfiguration(configuration)
            
            return configuration
            
        }.eraseToAnyPublisher()
    }
}
