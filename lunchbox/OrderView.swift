import SwiftUI

struct OrderPageView : View {
    var body: some View {
        ZStack {
            Color.gray.opacity(0.2)
                .ignoresSafeArea()
            
            VStack {
                Text("Start Your Order")
                    .fontWeight(.bold)
                    .font(.system(size: 30))
                Text("Please select service type")
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
                VStack {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Delivery")
                                .fontWeight(.bold)
                                .font(.system(size: 18))
                            Text("We'll bring your order to your door")
                                .foregroundColor(.gray)
                                .font(.system(size: 12))
                        }
                        Spacer()
                        Image(systemName: "chevron.forward")
                    }
                    .padding()
                    .background(Color.white)
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Pick-Up")
                                .fontWeight(.bold)
                                .font(.system(size: 18))
                            Text("We'll have your order ready at the store")
                                .foregroundColor(.gray)
                                .font(.system(size: 12))
                        }
                        Spacer()
                        Image(systemName: "chevron.forward")
                    }
                    .padding()
                    .background(Color.white)
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Drive-Thru")
                                .fontWeight(.bold)
                                .font(.system(size: 18))
                            Text("We'll your order at the drive thru")
                                .foregroundColor(.gray)
                                .font(.system(size: 12))
                        }
                        Spacer()
                        Image(systemName: "chevron.forward")
                    }
                    .padding()
                    .background(Color.white)
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Curbside Pickup")
                                .fontWeight(.bold)
                                .font(.system(size: 18))
                            Text("We'll bring your order to your car")
                                .foregroundColor(.gray)
                                .font(.system(size: 12))
                        }
                        Spacer()
                        Image(systemName: "chevron.forward")
                    }
                    .padding()
                    .background(Color.white)
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Catering Pickup")
                                .fontWeight(.bold)
                                .font(.system(size: 18))
                            Text("We'll have your catering order ready at the store")
                                .foregroundColor(.gray)
                                .font(.system(size: 12))
                        }
                        Spacer()
                        Image(systemName: "chevron.forward")
                    }
                    .padding()
                    .background(Color.white)
                    .padding(.horizontal)
                }
                .padding(.top, 20)
            }
        }
    }
}


#Preview {
    OrderPageView()
}
