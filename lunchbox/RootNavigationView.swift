import SwiftUI

struct RootNavigationView: View {
    @Environment(\.dependencies.tasks) var tasks
    
    @State var tab: Tab = .home
    @State private var isShowingLogin: Bool = false
    
    var body: some View {
        VStack{
            selectedView()
            tabBar()
        }
        .ignoresSafeArea(.keyboard)
    }
    
    
    private func orderTabItem() -> some View {
        TabItem(
            isSelected: tab == .order,
            title: "Order",
            icon: Image(systemName: "cart"),
            iconSelected: Image(systemName: "cart.fill")) {
                tab = .order
            }
    }
    
    private func scanTabItem() -> some View {
        TabItem(
            isSelected: tab == .scan,
            title: "Scan",
            icon: Image(systemName: "qrcode"),
            iconSelected: Image(systemName: "qrcode")) {
                tab = .scan
            }
    }
    
    private func rewardsTabItem() -> some View {
        TabItem(
            isSelected: tab == .rewards,
            title: "Rewards",
            icon: Image(systemName: "star"),
            iconSelected: Image(systemName: "star.fill")) {
                tab = .rewards
            }
    }
    
    private func accountTabItem() -> some View {
        TabItem(
            isSelected: tab == .account,
            title: isShowingLogin ? "Account" : "Login",
            icon: Image(systemName: "person"),
            iconSelected: Image(systemName: "person.fill")) {
                tab = .account
            }
    }

    private func selectedView() -> some View {
        switch tab {
        case .home:
            return AnyView(HomeView(isShowingLogin: $isShowingLogin))
        case .rewards:
            return AnyView(RewardsPageView())
        case .order:
            return AnyView(OrderPageView())
        case .scan:
            return AnyView(ScanPageView())
        case .account:
            return AnyView(AccountPageView())
        }
    }
    
    private func tabBar() -> some View {
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Divider()
                    .foregroundColor(.pink)
                
                HStack {
                    TabItem(
                        isSelected: tab == .home,
                        title: "Home",
                        icon: Image(systemName: "house"),
                        iconSelected: Image(systemName: "house.fill"))
                    {
                        tab = .home
                        if isShowingLogin {
                            isShowingLogin = false
                        }
                    }
                    orderTabItem()
                    
                    if isShowingLogin {
                        scanTabItem()
                        rewardsTabItem()
                    }
                    
                    accountTabItem()
                }
                
                Spacer()
            }
            .ignoresSafeArea(.keyboard)
        }
        .frame(height: 49)
    }
}


extension RootNavigationView {
    enum Tab {
        case home
        case rewards
        case order
        case account
        case scan
    }
    
    
    struct TabItem: View {
        private let isSelected: Bool
        private let action: () -> Void
        private let title: String
        private let iconDefault: Image
        private let iconSelected: Image
        var tabIcon: String? = "selected" // fix me
        
        init(isSelected: Bool, title: String, icon: Image, iconSelected: Image, tabIcon: String? = nil, action: @escaping () -> Void) {
            self.action = action
            self.isSelected = isSelected
            self.iconDefault = icon
            self.iconSelected = iconSelected
            self.tabIcon = tabIcon
            self.title = title
        }
        
        var body: some View {
            Button {
                action()
            } label: {
                VStack(alignment: .center) {
                    icon()
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(isSelected ? .brand : .black)
                    Text(title)
                        .font(.system(size: 12))
                        .fontWeight(.medium)
                        .foregroundColor(isSelected ? .brand : .black)
                }
            }
            .foregroundColor(.black)
            .frame(maxWidth: .infinity)
            .frame(height: 40)
            .padding(.vertical, 4)
        }
        
        private func icon() -> Image {
            isSelected ? iconSelected : iconDefault
        }
        
    }
}

struct RewardsPageView : View {
    var body: some View {
        VStack {
            Text("Rewards View")
        }
    }
}

struct ScanPageView : View {
    var body: some View {
        VStack {
            Text("Scan View")
        }
    }
}
