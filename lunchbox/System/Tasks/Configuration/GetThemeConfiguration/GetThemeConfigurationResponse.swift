import Foundation

struct GetThemeConfigurationResponse: Decodable {
    let data: AssetData?
}

struct AssetData: Codable {
    let tenant: String?
    let images: AssetImages?
    let hub_marketing: [AssetHubMarketing]?
}

struct AssetHubMarketing: Codable {
    let image: String?
    let title: String?
    let button_url: String?
    let button_text: String?
    let description: String?
}

struct AssetImages: Codable
{
    let login_icon: String?
    let cart_icon: String?
    let logo: String?
    let start_order_page_image: String?
    let gift_card_image: String?
    let wordmark: String?
}

extension ThemeConfiguration {
    init(response: AssetData?) {
        self.tenantId = response?.tenant ??  ""
        self.settings = Settings(response: response)
        
    }
}

extension ThemeConfiguration.Settings {
    init(response: AssetData?) {
        
//        if let themeImages = response?.images {
//            
//            self.themeImages = ThemeImages(response: themeImages)
//            
//        } else {
//            
//            self.themeImages = nil
//        }
        
        self.hubMarketing = response?.hub_marketing?.compactMap {HubMarketing(response: $0) }
    }
}

extension ThemeConfiguration.Settings.ThemeImages {
    init(response: AssetImages) {
        self.logoUrl = response.logo
        self.desktopLogoUrl = response.login_icon
        self.startOrderPageImage = response.start_order_page_image
        self.giftCardImage = response.gift_card_image
        self.wordmark = response.wordmark
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
