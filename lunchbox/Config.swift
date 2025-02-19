import Foundation

class Config {
    enum Property: String {
        case version = "CFBundleShortVersionString"
        case environment = "Environment"
        case hostUrl = "Host URL"
        case bffHostUrl = "BFF Host URL"
        case tenant = "Tenant"
        case googleApiKey = "GIDClientID"
        case sentryDsn = "Sentry DSN"
        case siftAccountId = "Sift Account ID"
        case siftBeaconKey = "Sift Beacon Key"
        case siftFraudEnabled = "Sift Fraud Enabled"
        case segmentKey = "Segment Key"
        case customerioKey = "CustomerIO Key"
        case flyBuyKey = "FlyBuy Key"
        case novadineApiKey = "Novadine API Key"
        case headerFontName = "Header Font Name"
        case bodyFontName = "Body Font Name"
        case placesApiKey = "LBX Google Places API Key"
        case applePayMerchantId = "Apple Pay Merchant Id"
        case bundleId = "Bundle Identifier"
        case disableAddTracking = "Disable Ad Tracking"
        case statusBarStyle = "UIStatusBarStyle"
        case bundleDisplayName = "CFBundleDisplayName"
    }
    
    enum Environment: String {
        case development
        case stage
        case production
    }
    
    static let shared = Config()
    
    private var bundle: Bundle {
        return Bundle(for: type(of: self))
    }
    
    var version: String {
        return propertyString(forKey: .version)
    }
    
    var environment: Environment {
        return Environment(rawValue: propertyString(forKey: .environment)) ?? .development
    }
    
    var bundleId: String {
        return propertyString(forKey: .bundleId)
    }
    
    var bundleDisplayName: String {
        return propertyString(forKey: .bundleDisplayName)
    }
    
    var hostUrl: String {
        return propertyString(forKey: .hostUrl)
    }
    
    var bffHostUrl: String {
        return propertyString(forKey: .bffHostUrl)
    }
    
    var tenant: String {
        return propertyString(forKey: .tenant)
    }
    
    var novadineApiKey: String {
        return propertyString(forKey: .novadineApiKey)
    }
    
    var googleAccessKey: String? {
        return safePropertyString(for: bundle, forKey: .googleApiKey)
    }
    
    
    private func safePropertyURL(for givenBundle: Bundle? = nil, forKey key: Property) -> URL? {
        guard let urlString = (givenBundle ?? bundle).object(forInfoDictionaryKey: key.rawValue) as? String,
              let url = URL(string: urlString) else {
            return nil
        }
        
        return url
    }
    
    private func propertyURL(for givenBundle: Bundle? = nil, forKey key: Property) -> URL {
        guard let url = safePropertyURL(for: givenBundle, forKey: key) else {
            fatalError("Info dictionary must specify a URL for key \"\(key)\".")
        }
        
        return url
    }
    
    private func safePropertyString(for givenBundle: Bundle? = nil, forKey key: Property) -> String? {
        guard let string = (givenBundle ?? bundle).object(forInfoDictionaryKey: key.rawValue) as? String else {
            return nil
        }
        
        print("the values \(key.rawValue) -> \(string ?? "nil")")
        return string.replacingOccurrences(of: "\\n", with: "\n")
                                                          
    }
    private func propertyString(for givenBundle: Bundle? = nil, forKey key: Property) -> String {
        let allKeys = (givenBundle ?? bundle).infoDictionary?.keys
        print("All available info keys: \(String(describing: allKeys))")
        
        guard let string = safePropertyString(for: givenBundle, forKey: key) else {
            fatalError("Info dictionary must specify a String for key \"\(key)\".")
        }
        return string
    }
}


enum SocialSignIn: String {
    case google = "google"
    case okta = "okta"
    case facebook = "facebook"
    case paytronix = "paytronix"
    case punchh = "punchh"
    case apple = "apple"
}


extension Config {
    func printAllProperties() {
        print("Host URL: \(hostUrl)")
        
        print("Environment is: \(environment)")
    }
}
