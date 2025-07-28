//
//  StrayBaseApp.swift
//  StrayBase
//
//  Created by Nino Nozadze on 21.03.25.
//

import SwiftUI
import Firebase

@main
struct StrayBaseApp: App {
    
    @StateObject var viewModel = AuthViewModel()
    @StateObject var locationViewModel = LocationModel()
    @StateObject var animalRepository = AnimalRepository()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
                .environmentObject(locationViewModel)
                .environmentObject(animalRepository)
                .onAppear {
                    locationViewModel.setupLocationManager()
                }
        }
    }
    
}
