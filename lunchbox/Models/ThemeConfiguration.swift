struct ThemeConfiguration: Codable {
    
    struct Settings: Codable {
        
        struct HubMarketing: Codable, Equatable {
            
            let image: String?
            let title: String?
            let buttonURL: String?
            let buttonText: String?
            let description: String?
        }
        
        let hubMarketing: [HubMarketing]?
    }
    
    var id: String {
        return tenantId
    }
    
    let tenantId: String
    let settings: Settings?
    
}
