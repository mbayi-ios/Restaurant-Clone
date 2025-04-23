struct ThemeConfiguration: Codable {
    
    struct Settings: Codable {
        
        struct ThemeImages: Codable {
            let logoUrl: String?
            let desktopLogoUrl: String?
            let wordmark: String?
            let startOrderPageImage: String?
            let giftCardImage: String?
        }
       
        struct HubMarketing: Codable{
            let image: String?
            let title: String?
            let buttonURL: String?
            let buttonText: String?
            let description: String?
        }
        
       // let themeImages: ThemeImages?
        let hubMarketing: [HubMarketing]?
    }
    
    var id: String {
        return tenantId
    }
    
    let tenantId: String
    let settings: Settings?
    
}
