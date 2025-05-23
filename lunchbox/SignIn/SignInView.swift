import SwiftUI
import Nuke
import NukeUI



struct SignInView: View {
    @Environment(\.theme) var theme: Theme
    @Environment(\.dependencies.state.themeConfigurationState.themeConfiguration) var themeConfiguration
    @Environment(\.dependencies.tasks) var tasks
    @Environment(\.dismiss) var dismiss
    

    var nestedNavigationAction: (() -> Void) = {}
    @ObservedObject var viewModel = SignInViewModel()
    
    var isSignInRootView: Bool = false
    var isSignInNestedNavigationView: Bool = false
    var isSecondInStack: Bool = false
    
    var body: some View {
        if isSignInRootView {
            BaseNavigationView {
                contentView()
            }
            .onAppear() {
                
            }
            .onReceive(viewModel.dismissalPublisher) { shouldDismiss in
                print("Dismissal triggered")
                nestedNavigationAction()
                dismiss()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarBackButtonHidden(true)
        }
        /*else if isSignInNestedNavigationView {
            VStack(alignment: .leading) {
                self.navBarLogo()
                    .padding(.leading, 8)
                contentView()
                    .onReceive(viewModel.dismissalPublisher) { shouldDismiss in
                        print("Dismissal triggered")
                        nestedNavigationAction()
                        dismiss()
                    }
                    .navigationViewStyle(StackNavigationViewStyle())
            }
        }
        else  {
            VStack {
                HStack {
                    navBarLogo()
                    Spacer()
                }
                contentView()
            }
            .onReceive(viewModel.dismissalPublisher) { shouldDismiss in
                print("Dismissal triggered")
                nestedNavigationAction()
                dismiss()
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
        */
    }
    
    private func headerLabel() -> some View {
        VStack( alignment: .center, spacing: 16) {
            Text("logoUrl:")
//            if let logoUrl = themeConfiguration?.settings?.themeImages?.logoUrl, let url = URL(string: logoUrl) {
//               
//                Group {
//                    LazyImage(url: url, content: { state in
//                        if let image = state.image {
//                            image
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 160, height:80)
//                        } else {
//                            Spacer()
//                        }
//                    })
//                    .onAppear {
//                        print("🖼️ LazyImage will load from URL: \(url)")
//                    }
//                }
//               
//            }
            
            theme.icons.base.brand
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .padding()
            Text("Sign Into Your Account")
                .fontWeight(.bold)
                .font(.system(size: 26))
                .padding(.bottom, 5)
        }
        
        
    }
    private func createAccountLabel() -> some View  {
        HStack{
            Text("Dont have an account?")
                .foregroundColor(.gray)
                .font(.system(size: 14))
            NavigationLink {
                CreateAccountView()
                    .navigationBarBackButtonHidden(true)
            }
            label: {
                Text("CREATE ACCOUNT")
                    .font(.system(size: 14))
                    .underline()
            }
            
        }
    }
    private func createAccountButton() -> some View  {
        Group {
            if isSecondInStack {
                Button {
                    dismiss()
                    nestedNavigationAction()
                } label: {
                    createAccountLabel()
                }
            } else {
                NavigationLink(destination: BaseView {
                    CreateAccountView()
                }) {
                    createAccountLabel()
                }
            }
        }
    }
    
    
    private func contentView() -> some View {
        VStack {
            ScrollView {
                VStack {
                    
                    headerLabel()
                    
                    createAccountButton()
                    
                    VStack(alignment: .leading) {
                        
                        VStack(alignment: .leading) {
                            Text("Email Address")
                                .fontWeight(.bold)
                                .font(.system(size: 16))
                            TextField("Email", text: $viewModel.model.email)
                                .autocapitalization(.none)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        .padding()
                        
                        VStack(alignment: .leading) {
                            Text("Password")
                                .fontWeight(.bold)
                                .font(.system(size: 16))
                            TextField("Password", text: $viewModel.model.password)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .autocapitalization(.none)
                        }
                        .padding(.top, -20)
                        .padding()
                        
                        Button {}
                        label: {
                            Text("FORGET PASSWORD?")
                                .underline()
                                .fontWeight(.medium)
                                .font(.system(size: 12))
                        }
                        .padding(.horizontal)
                        
                        Button{}
                        label: {
                            Image("apple")
                                .resizable()
                                .frame(width: 15, height: 15)
                            
                            Text("Sign in with Apple")
                                .foregroundColor(.white)
                                .fontWeight(.medium)
                            
                        }
                        
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.black)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .padding(.top, 20)
                        
                    }
                    
                    Spacer()
                    
                    TermsOfServiceView()
                    
                    Button {
                        viewModel.handleSignIn()
                    } label: {
                        Text("Sign In")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 45)
                    .background(Color.brand)
                    .cornerRadius(50)
                    .padding(.horizontal)
                    
                }
            }
        }
    }
    
    private func navBarLogo() -> some View {
        HStack {
            NavigationBackButton(nestedNavigationAction: isSignInNestedNavigationView ? nestedNavigationAction : nil)
            Spacer()
        }
        .padding([.top, .bottom], 5)
        .frame(width: 100)
        .padding(.leading, 20)
    }
}


struct NavigationBackButton: View {
   // @Environment(\.theme) var theme: Theme
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var nestedNavigationAction: (() -> Void)? = nil
    
    var body: some View {
        Button {
            if let nestedNavigationAction = nestedNavigationAction {
                nestedNavigationAction()
            } else {
                presentationMode.wrappedValue.dismiss()
            }
        } label: {
            Image(systemName: "chrome.backward.chevron")
                .resizable()
                .scaledToFit()
                .frame(width: 15, height: 15)
        }
    }
}
