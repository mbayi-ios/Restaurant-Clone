//
//  GetThemeConfigurationResponse.swift
//  lunchbox
//
//  Created by Ambrose Mbayi on 21/04/2025.
//



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
