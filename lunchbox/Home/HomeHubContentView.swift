import SwiftUI

struct HomeHubContentView: View {
    
    private let title: String?
    private let description: String?
    private let imageUrl: String?
    private let buttonText: String?
    private let buttonUrlString: String?
    
    init(hubMarketing: ThemeConfiguration.Settings.HubMarketing) {
        title = hubMarketing.title
        description = hubMarketing.description
        imageUrl = hubMarketing.image
        buttonText = hubMarketing.buttonText
        buttonUrlString = hubMarketing.buttonURL
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Image("food-3")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(10, corners: [.topLeft, .topRight])
            VStack(alignment: .leading, spacing: 11) {
                if let title = title {
                    Text(title)
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .padding(.horizontal, 16)
                }
                
                if let description = description {
                    Text(description)
                        .font(.system(size: 14))
                        .lineLimit(3)
                        .padding(.horizontal, 16)
                }
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
                .background(Color.brand)
                .cornerRadius(50)
                .padding(.leading, 16)
                .padding(.bottom, 16)
                
                Spacer()
            }
        }
        .background(Color.white)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
        .padding()
    }
}
