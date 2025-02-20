import SwiftUI

struct ProfilePageView: View {
    @State private var isOn = false
    var body: some View {
        NavigationView {
            ScrollView {
                Text("Amby Mbayi")
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                    .padding()
                
                Divider()
                
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
                        TextField("DD/MM/YYYY", text: .constant(""))
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
                
                HStack {
                    Button { }
                    label: {
                        Text("DELETE ACCOUNT")
                            .fontWeight(.bold)
                            .font(.system(size: 14))
                            .foregroundColor(Color.brand)
                    }
                    Spacer()
                }
                .padding()
                
                Button {
                    
                } label: {
                    Text("Save")
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
    ProfilePageView()
}


