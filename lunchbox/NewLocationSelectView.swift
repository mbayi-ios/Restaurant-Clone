import SwiftUI
import UIKit
import MapKit

struct NewLocationSelectView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.2)
                .ignoresSafeArea()
            
            VStack {
                VStack {
                    TextField("Enter your address", text: .constant(""))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    Map(coordinateRegion: $region)
                        .frame(width: 400, height: 300)
                }
                
                // if there is no location
                VStack {
                    Text("There are no locations within 25miles")
                        .fontWeight(.medium)
                        .padding()
                    Button {}
                    label: {
                        Text("Show All Locations")
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                            .background(Color.brand)
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                    }
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Attleboro Papa Gino's")
                                .font(.system(size: 18))
                                .fontWeight(.bold)
                            Text("103 Pleassant Street, Atrro, MA 0223")
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        Image(systemName: "heart")
                    }
                    .padding(.horizontal)
                    
                    HStack {
                        Text("Closed")
                        Text("Pickup Time: 20 mins")
                    }
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                    .padding(.top, 10)
                    .padding(.horizontal)
                    
                    Divider()
                    HStack {
                        Button {}
                        label: {
                            Text("View Hours")
                                .font(.system(size: 14))
                                
                        }
                        Spacer()
                        Button{}
                        label: {
                            Text("Order Now")
                                .font(.system(size: 14))
                        }
                    }
                    .foregroundColor(.brand)
                    .padding()
                }
                .frame(maxWidth: .infinity)
                .frame(height: 160)
                .background(Color.white)
                .padding()
            }
        }
    }
}

#Preview {
    NewLocationSelectView()
}
