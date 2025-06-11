//
//  ContentView.swift
//  StrayBase
//
//  Created by Nino Nozadze on 21.03.25.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        if viewModel.userSession != nil {
            UserContentView()
        } else {
            LoginView()
        }
    }
}

#Preview {
    ContentView()
}
