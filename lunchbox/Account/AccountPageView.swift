import SwiftUI
import Combine
import Foundation





struct AccountPageView: ViewProtocol {
    @EnvironmentObject var authStatus: AuthStatus
   // @EnvironmentObject var sessionCustomer: SessionCustomer
    @StateObject var viewModel = AccountPageViewModel()
    
    var body: some View {
        if authStatus.isLoggedIn {
            BaseNavigationView {
                contentView()
            }
            .navigationBarBackButtonHidden(true)
            .navigationViewStyle(StackNavigationViewStyle())
        }

        else {
            SignInView(isSignInRootView: true)
        }
    }
    
    private func contentView() -> some View  {
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
                    
                    logoutButton()
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
    
    private func logoutButton() -> some View {
        HStack {
            Button {
                viewModel.handleLogoutRequest()
            }
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

#Preview {
    AccountPageView()
}
