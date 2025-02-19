import SwiftUI

struct AccountPageView: View {
    var body: some View {
        VStack {
            VStack {
                Text("Amby Mbayi")
                    .fontWeight(.bold)
                    .font(.system(size: 24))
                    .padding()
                Divider()
                
                VStack {
                    HStack {
                        Text("Profile")
                            .fontWeight(.medium)
                            .font(.system(size: 20))
                        Spacer()
                        Image(systemName: "chevron.forward")
                    }
                    .foregroundColor(.gray)
                    .padding()
                    
                    HStack {
                        Text("Order History")
                            .fontWeight(.medium)
                            .font(.system(size: 20))
                        Spacer()
                        Image(systemName: "chevron.forward")
                    }
                    .foregroundColor(.gray)
                    .padding()
                    
                    HStack {
                        Text("Favorite Items")
                            .fontWeight(.medium)
                            .font(.system(size: 20))
                        Spacer()
                        Image(systemName: "chevron.forward")
                    }
                    .foregroundColor(.gray)
                    .padding()
                    
                    HStack {
                        Text("Manage Cards")
                            .fontWeight(.medium)
                            .font(.system(size: 20))
                        Spacer()
                        Image(systemName: "chevron.forward")
                    }
                    .foregroundColor(.gray)
                    .padding()
                    
                    HStack {
                        Text("Gift Cards")
                            .fontWeight(.medium)
                            .font(.system(size: 20))
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
                                .font(.system(size: 15))
                                .underline()
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
            
            HStack {
                Text("Lunchbox's")
                Button {}
                label: {
                    Text("Terms of Service")
                        .underline()
                }
                Text("&")
                Button {}
                label: {
                    Text("Privacy Policy")
                        .underline()
                }
            }
            .padding()
        }
    }
}

#Preview {
    AccountPageView()
}
