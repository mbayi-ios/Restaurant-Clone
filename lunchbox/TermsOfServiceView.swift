import SwiftUI

struct TermsOfServiceView: View {
    var body: some View {
        HStack {
            Text("SnackSnap's")
            Button {}
            label: {
                Text("Terms of Service")
                    .underline()
            }
            Text("&")
            Button {}
            label: {
                Text("Privacy Policy")
                    .underline()
            }
        }
        .font(.system(size: 12))
        .padding()
    }
}

#Preview {
    TermsOfServiceView()
}
