import SwiftUI
import Combine
import Foundation

struct SessionStore {
    private static let currentCustomer = "current_customer"
    private var keyStore: KeyStore
    
    var currentCustomer = CurrentValueSubject<Customer?, Never>(nil)
    
    init(keyStore: KeyStore) {
        self.keyStore = keyStore
    }
    
}
class AuthStatus: ObservableObject {
    @Published private(set) var isLoggedIn: Bool = false
    
    private var cancellables: Set<AnyCancellable> = []
    private let sessionStore: SessionStore
    
    init(sessionStore: SessionStore) {
        self.sessionStore = sessionStore
        
        sessionStore.currentCustomer
            .receive(on: DispatchQueue.main)
            .sink { customer  in
                self.isLoggedIn = !(customer?.isGuest ?? true )
            }.store(in: &cancellables)
    }
}

struct AccountPageView: View {
    @EnvironmentObject var authStatus: AuthStatus
   // @EnvironmentObject var sessionCustomer: SessionCustomer
    
    var body: some View {
        if authStatus.isLoggedIn {
            NavigationView {
                VStack {
                    VStack {
                        Text("Amby Mbayi")
                            .fontWeight(.bold)
                            .font(.system(size: 24))
                            .padding()
                        Divider()
                        
                        VStack {
                            NavigationLink(destination: ProfilePageView()) {
                                HStack {
                                    Text("Profile")
                                        .fontWeight(.medium)
                                        .font(.system(size: 18))
                                    Spacer()
                                    Image(systemName: "chevron.forward")
                                }
                                .foregroundColor(.gray)
                                .padding()
                            }
                            
                            HStack {
                                Text("Order History")
                                    .fontWeight(.medium)
                                    .font(.system(size: 18))
                                Spacer()
                                Image(systemName: "chevron.forward")
                            }
                            .foregroundColor(.gray)
                            .padding()
                            
                            HStack {
                                Text("Favorite Items")
                                    .fontWeight(.medium)
                                    .font(.system(size: 18))
                                Spacer()
                                Image(systemName: "chevron.forward")
                            }
                            .foregroundColor(.gray)
                            .padding()
                            
                            HStack {
                                Text("Manage Cards")
                                    .fontWeight(.medium)
                                    .font(.system(size: 18))
                                Spacer()
                                Image(systemName: "chevron.forward")
                            }
                            .foregroundColor(.gray)
                            .padding()
                            
                            HStack {
                                Text("Gift Cards")
                                    .fontWeight(.medium)
                                    .font(.system(size: 18))
                                Spacer()
                                Image(systemName: "chevron.forward")
                            }
                            .foregroundColor(.gray)
                            .padding()
                            
                            HStack {
                                Button { }
                                label: {
                                    Text("LOGOUT")
                                        .fontWeight(.medium)
                                        .font(.system(size: 13))
                                        .underline()
                                        .foregroundColor(Color.brand)
                                }
                                Spacer()
                            }
                            .padding()
                        }
                    }
                    Spacer()
                    HStack {
                        Image("facebook")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                        
                        Image("instagram")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                        
                        Image("youtube")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                        
                        Image("tiktok")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                        
                        Image("linkedin")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                    }
                    
                    TermsOfServiceView()
                }
            }
        }
        
        else {
            SignInView()
        }
    }
}

#Preview {
    AccountPageView()
}
