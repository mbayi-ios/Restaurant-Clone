//
//  ViewProtocol.swift
//  lunchbox
//
//  Created by Ambrose Mbayi on 21/04/2025.
//

import SwiftUI

protocol ViewProtocol: View  {
    associatedtype ViewModel: ViewModelProtocol
    
    var viewModel: ViewModel { get }
}
