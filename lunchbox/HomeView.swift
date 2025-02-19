import SwiftUI

struct HomeView : View {
    @State var progress: Double = 10
    @State var animatedProgress: Double = 0.0
    
    var body: some View {
        BaseNavigationView {
            VStack {
                HStack {
                    Text("Hi Amby!")
                        .fontWeight(.bold)
                        .font(.system(size: 30))
                    Spacer()
                    
                    Image(systemName: "cart.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                }
                .padding(.horizontal)
                
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
                .background(Color.gray)
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
                    .background(Color.red)
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
                                .background(Color.red)
                                .cornerRadius(50)
                            }
                            
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray)
                        .cornerRadius(10)
                        
                        
                    }
                    .padding(.horizontal)
                    
                    // loyalty section
                    HStack {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("AM")
                                .padding(8)
                                .background(Color.yellow)
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
                            .background(Color.red)
                            .cornerRadius(50)
                            
                        }
                        ZStack {
                            Circle()
                                .stroke(Color.red, lineWidth: 25)
                            Circle()
                                .trim(from: 0, to: 10)
                                .stroke(Color.green, style: StrokeStyle(lineWidth: 25, lineCap: .round)
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
                    .background(Color.gray)
                    .cornerRadius(10)
                    .padding(.horizontal)
                    
                    
                    
                    
                    // hubmarketing
                    VStack(alignment: .leading) {
                        Image("food-3")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(10, corners: [.topLeft, .topRight])
                        VStack(alignment: .leading, spacing: 11) {
                            Text("Loyalty Program")
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                                .padding(.horizontal, 16)
                            
                            Text("Our program is Free to join and simple way to ear perks just by eating the food you love. Earn $5 for every 75 points you earn")
                                .font(.system(size: 14))
                                .lineLimit(3)
                                .padding(.horizontal, 16)
                        }
                        
                        HStack {
                            Button {
                                
                            } label : {
                                Text("Learn More")
                                    .foregroundColor(.white)
                                    .fontWeight(.medium)
                                    .font(.system(size: 15))
                            }
                            .frame(width: 150, height: 30)
                            .background(Color.red)
                            .cornerRadius(50)
                            .padding(.leading, 16)
                            .padding(.bottom, 16)
                            
                            Spacer()
                        }
                    }
                    .background(Color.gray)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .padding()
                }
                
                
            }
            
            
        }
    }
}

struct HomeView_Previews: PreviewProvider
{
    static var previews: some View
    {
        HomeView()
    }
}
