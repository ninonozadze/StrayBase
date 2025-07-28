//
//  DashboardView.swift
//  StrayBase
//
//  Created by Nino Nozadze on 17.06.25.
//

import SwiftUI

struct DashboardView: View {
    
    @EnvironmentObject var animalRepository: AnimalRepository
    @State private var searchText = ""
    @State private var showingFilterSheet = false
    
    var filteredAnimals: [Animal] {
        let allAnimals = animalRepository.animals
        guard !searchText.isEmpty else {
            return allAnimals
        }
        
        return allAnimals.filter { animal in
            animal.name.localizedCaseInsensitiveContains(searchText) ||
            animal.animalId.localizedCaseInsensitiveContains(searchText) ||
            animal.reporterName.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                HStack(spacing: 20) {
                    StatCard(
                        title: SharedUtils.TabViews.DashboardView.totelAnimalTitle,
                        value: "\(filteredAnimals.count)",
                        color: .blue
                    )
                    StatCard(
                        title: SharedUtils.TabViews.DashboardView.organizationTitle,
                        value: "\(Set(filteredAnimals.map { $0.reporterName }).count)",
                        color: .green
                    )
                }
                .padding(.horizontal)
                .padding(.top, 10)
                .padding(.bottom, 10)
                
                List(filteredAnimals) { animal in
                    ZStack {
                        AnimalRow(animal: animal)
                            .padding(.vertical, 4)
                        
                        NavigationLink("", destination: AnimalDetailView(animal: animal))
                            .opacity(0)
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                }
                .listStyle(.plain)
                .searchable(text: $searchText,
                            prompt: SharedUtils.TabViews.DashboardView.searchPrompt)
            }
            .navigationTitle(SharedUtils.TabViews.DashboardView.navTitle)
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    
    static var previews: some View {
        DashboardView()
    }
    
}
