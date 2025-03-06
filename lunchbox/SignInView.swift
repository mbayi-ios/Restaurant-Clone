import SwiftUI

struct SignInView: View {
    var body: some View {
        NavigationView {
            VStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .padding()
                Text("Sign Into Your Account")
                    .fontWeight(.bold)
                    .font(.system(size: 26))
                    .padding(.bottom, 5)
                
                HStack{
                    Text("Dont have an account?")
                        .foregroundColor(.gray)
                        .font(.system(size: 14))
                    NavigationLink {
                        SignupView()
                            .navigationBarBackButtonHidden(true)
                    }
                    label: {
                        Text("CREATE ACCOUNT")
                            .font(.system(size: 14))
                            .underline()
                    }
                    
                }
                VStack(alignment: .leading) {
                    
                    VStack(alignment: .leading) {
                        Text("Email Address")
                            .fontWeight(.bold)
                            .font(.system(size: 16))
                        TextField("Email", text: .constant(""))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Password")
                            .fontWeight(.bold)
                            .font(.system(size: 16))
                        TextField("Password", text: .constant(""))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
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

#Preview {
    SignInView()
}
