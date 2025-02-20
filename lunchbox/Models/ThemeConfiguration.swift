struct ThemeConfiguration{
    struct Settings {
        struct HubMarketing: Codable, Equatable {
            let image: String?
            let title: String?
            let buttonURL: String?
            let buttonText: String?
            let description: String?
        }
        
        let hubMarketing: [HubMarketing]?
    }
    
    let settings: Settings?
    
}
