//
//  ViewModelProtocol.swift
//  lunchbox
//
//  Created by Ambrose Mbayi on 21/04/2025.
//

import SwiftUI

protocol ViewModelProtocol: ObservableObject {
    associatedtype Model: ModelProtocol
    
    var model: Model { get }
}
