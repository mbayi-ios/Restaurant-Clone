import SwiftUI
import Combine



struct HomeView : View {
    @State var progress: Double = 10
    @State var animatedProgress: Double = 0.0
    
    @Binding var isShowingLogin: Bool
    
    @Environment(\.dependencies.state.themeConfigurationState.themeConfiguration?.settings?.hubMarketing) var hubMarketing
    @Environment(\.dependencies.state.storesConfigurationState.storesConfiguration) var storesConfiguration
    
    @EnvironmentObject var authStatus: AuthStatus
    @EnvironmentObject var sessionCustomer: SessionCustomer
    
    private func cartSection() -> some View {
        Image(systemName: "cart.fill")
            .resizable()
            .scaledToFit()
            .frame(width: 25, height: 25)
    }
    
    private func headerSection() -> some View  {
        HStack {
            
            Text(String.localizedStringWithFormat(NSLocalizedString("HomePage.Label.WelcomeMessage", comment: "HomePage.Label.WelcomeMessage"), authStatus.isLoggedIn ? sessionCustomer.customer?.firstName ?? String(localized: "HomePage.Label.WelcomeMessageGuest") : String(localized: "HomePage.Label.WelcomeMessageGuest")))
            
           
            Spacer()
            
            cartSection()
        }
        .padding(.horizontal)
    }
    
    var body: some View {
        
        BaseNavigationView {
            VStack(alignment: .leading) {
                headerSection()
                
                VStack {
                    HStack {
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                        
                        VStack(alignment: .leading) {
                            Text("Header Text1234")
                                .font(.system(size: 18))
                                .fontWeight(.bold)
                            
                            Text("BodyText1234")
                                .font(.system(size: 12))
                                .fontWeight(.light)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "x.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                        
                    }
                    
                }
                
                .padding()
                .background(Color.gray.opacity(0.5))
                .cornerRadius(10)
                .padding(.horizontal)
                
                ScrollView {
                    // carousel View
                    TabView {
                        Image("food-1")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 500, height:500)
                            .clipped()
                    }
                    .tabViewStyle(PageTabViewStyle())
                    .frame(height: 500)
                    .cornerRadius(10)
                    .padding(.horizontal)
                    
                    // start order button
                    Button {
                        print("button clicked")
                    } label: {
                        Text("Start Order")
                            .fontWeight(.medium)
                    }
                    .frame(maxWidth: .infinity)
                    .frame( height: 50)
                    .foregroundColor(.white)
                    .background(Color.brand)
                    .cornerRadius(50)
                    .padding()
                    
                    // past order
                    VStack(alignment: .leading) {
                        Text("Past Orders")
                            .fontWeight(.bold)
                            .font(.system(size: 24))
                        
                        HStack {
                            Group {
                                Image(systemName: "bag")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 30, height: 40)
                                    .foregroundColor(.white)
                            }
                            .padding(28)
                            .frame(width: 83, height: 83)
                            .background(Color.black)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8, style: .circular)
                                    .inset(by: 1)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                            
                            Spacer()
                            VStack(alignment: .leading) {
                                Text("You don't have any order yet")
                                
                                Button {
                                    
                                } label: {
                                    Text("Start Order Now")
                                        .fontWeight(.medium)
                                        .padding()
                                }
                                .foregroundColor(.white)
                                .frame(width: 200, height: 35)
                                .background(Color.brand)
                                .cornerRadius(50)
                            }
                            
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        
                        
                    }
                    .padding(.horizontal)
                    
                    // loyalty section
                    HStack {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("AM")
                                .foregroundColor(.white)
                                .padding(8)
                                .background(Color.brand)
                                .clipShape(Circle())
                            
                            VStack {
                                Text("0 points until your next reward!")
                                    .font(.system(size: 18))
                                    .fontWeight(.bold)
                                    .lineLimit(3)
                                    .frame(width: 180)
                                Text("You're almost there")
                                    .fontWeight(.medium)
                                    .foregroundColor(.white)
                            }
                            Button {
                                
                            } label:  {
                                Text("View Your Perks")
                                    .fontWeight(.medium)
                                    .font(.system(size: 15))
                                    .foregroundColor(.white)
                            }
                            
                            .padding()
                            .frame(height: 30)
                            .background(Color.brand)
                            .cornerRadius(50)
                            
                        }
                        ZStack {
                            Circle()
                                .stroke(Color.brand, lineWidth: 25)
                            Circle()
                                .trim(from: 0, to: 10)
                                .stroke(Color.brand, style: StrokeStyle(lineWidth: 25, lineCap: .round)
                                )
                                .rotationEffect(.degrees(-90))
                                .animation(.easeOut, value: 10)
                        }
                        .padding()
                        .onAppear {
                            animatedProgress = 0
                            withAnimation {
                                animatedProgress = progress
                            }
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
                    
                    // hubmarketing
                    if let hubMarketing = hubMarketing {
                        ForEach(hubMarketing.indices, id: \.self) { index in
                            HomeHubContentView(hubMarketing: hubMarketing[index])
                        }
                        
                    }
                }
                .onAppear {
                    print("the hubs are \(String(describing: hubMarketing))")
                }
            }
        }
    }
}

