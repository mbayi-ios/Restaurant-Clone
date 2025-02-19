import SwiftUI

struct SignupView: View {
    @State private var isOn = false
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .padding()
                    Text("Create Your Account")
                        .fontWeight(.bold)
                        .font(.system(size: 26))
                        .padding(.bottom, 5)
                    
                    HStack{
                        Text("Dont have an account?")
                            .foregroundColor(.gray)
                            .font(.system(size: 14))
                        
                        NavigationLink {
                            LoginView()
                                .navigationBarBackButtonHidden(true)
                        }
                        label: {
                            Text("SIGNIN")
                                .font(.system(size: 14))
                                .underline()
                        }
                    }
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("First Name")
                                .fontWeight(.bold)
                                .font(.system(size: 16))
                            TextField("First Name", text: .constant(""))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Last Name")
                                .fontWeight(.bold)
                                .font(.system(size: 16))
                            TextField("Last Name", text: .constant(""))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                    }
                    .padding()
                    .padding(.bottom, -20)
                    
                    VStack(alignment: .leading) {
                        Text("Email Address")
                            .fontWeight(.bold)
                            .font(.system(size: 16))
                        TextField("Email", text: .constant(""))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    .padding()
                    .padding(.bottom, -20)
                    
                    VStack(alignment: .leading) {
                        Text("Mobile Number")
                            .fontWeight(.bold)
                            .font(.system(size: 16))
                        TextField("(+) Add Mobile Number", text: .constant(""))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    .padding()
                    .padding(.bottom, -20)
                    
                    VStack(alignment: .leading) {
                        Text("Birthday (Optional)")
                            .fontWeight(.bold)
                            .font(.system(size: 16))
                        TextField("(+) Add Mobile Number", text: .constant(""))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    .padding()
                    .padding(.bottom, -20)
                    
                    
                    VStack(alignment: .leading) {
                        Text("Create Password")
                            .fontWeight(.bold)
                            .font(.system(size: 16))
                        TextField("Password", text: .constant(""))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Toggle(isOn: $isOn) {
                            Text("I want to receive email updates and promotions")
                                .foregroundColor(.black)
                                .font(.system(size: 12))
                                .fontWeight(.medium)
                        }
                        .toggleStyle(iOSCheckBoxToggleStyle())
                        .padding(.bottom, 5)
                        
                        Toggle(isOn: $isOn) {
                            Text("I want to receive order updates and promortions via text. Messsages and data reates may apply.")
                                .lineLimit(3)
                                .multilineTextAlignment(.leading)
                                .foregroundColor(.black)
                                .fontWeight(.medium)
                                .font(.system(size: 12))
                        }
                        .toggleStyle(iOSCheckBoxToggleStyle())
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
                
                Text("By Creating an account you agree to")
                    .fontWeight(.medium)
                    .font(.system(size: 12))
                    .padding(.top, 10)
                    .padding(.bottom, -21)
                    .foregroundColor(.gray)
                TermsOfServiceView()
                
                Button {
                    
                } label: {
                    Text("Create Account")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 45)
                .background(Color.red)
                .cornerRadius(50)
                .padding(.horizontal)
                
            }
        }
    }
    
}


struct iOSCheckBoxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        },
               label: {
            HStack {
                Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                configuration.label
            }
        }
        )
    }
}

#Preview {
    SignupView()
}


