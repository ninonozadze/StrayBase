//
//  StrayBaseApp.swift
//  StrayBase
//
//  Created by Nino Nozadze on 21.03.25.
//

import SwiftUI

@main
struct StrayBaseApp: App {
    
    @StateObject var viewModel = AuthViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
    
}
