import Foundation
import SwiftUI

class Colors {
    var brand: Color = .blue
}

extension Colors: Equatable {
    static func == (lhs: Colors, rhs: Colors) -> Bool {
        return lhs.brand == rhs.brand
    }
}
