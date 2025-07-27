//
//  DashboardView.swift
//  StrayBase
//
//  Created by Nino Nozadze on 17.06.25.
//

import SwiftUI

struct DashboardView: View {
    
    // temporary mock
    @State private var animals: [AnimalMock] = [
        AnimalMock(
            id: "0001",
            name: "კამპუსა",
            animalId: "0001",
            imageURL: "https://scontent.ftbs6-2.fna.fbcdn.net/v/t39.30808-6/504905391_3613360668797878_6234143278905922696_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=a5f93a&_nc_ohc=wO8hg2yokOUQ7kNvwGBTtnh&_nc_oc=AdlmWc_R6ZFGCWa_r8xwpQ_hGeE5fbbc-9ZuWR6REm_eCxbDzT5GtVhlzcmwBQ71bkg&_nc_zt=23&_nc_ht=scontent.ftbs6-2.fna&_nc_gid=7IxL54Hs1fAHOlxIfir4wQ&oh=00_AfSp-Mvu_IyxupWF2Ar2WuJM0FH-Vn38sWsKcNmMQeYBcA&oe=68891398",
            reporterName: "Free University"
        ),
        
        AnimalMock(
            id: "0002",
            name: "კუპატა",
            animalId: "0002",
            imageURL: "https://scontent.ftbs6-2.fna.fbcdn.net/v/t39.30808-6/476966233_627982379874019_1285517152150462362_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=833d8c&_nc_ohc=4DCxj3UgZ7AQ7kNvwHlH4nX&_nc_oc=AdkE-iVlJ_Tq-xWmK_nfuU0JjJpXpttJqSlKK3U5oA4VBkcFUaH3EkHMGcX0RbosTx8&_nc_zt=23&_nc_ht=scontent.ftbs6-2.fna&_nc_gid=a_GIXKCgACYJbmZUrg72AQ&oh=00_AfS2EMgFDbBMoBqMmw48BDwHb7odm43DaIur2erEZLtrCA&oe=68893B80",
            reporterName: "Animal Municipal Shelter"
        ),
        
        AnimalMock(
            id: "0003",
            name: "კამპუსა",
            animalId: "0003",
            imageURL: "https://scontent.ftbs6-2.fna.fbcdn.net/v/t39.30808-6/481165924_1141738251295353_8910477499379473949_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=cc71e4&_nc_ohc=O8TqvkOh0d4Q7kNvwEfdFF9&_nc_oc=AdkqXGNwct5CdgwqeNXW-AmPnh_RpimkNo7MWTBEX5tQMYA_PorceNcWAxhh9L1RUN4&_nc_zt=23&_nc_ht=scontent.ftbs6-2.fna&_nc_gid=MIaQutiAgH0cAHvk099XKA&oh=00_AfSapFzikwry7cH0aD3F5wjPnzya7rkqv-BDZ9KyG3Fq-w&oe=6889193E",
            reporterName: "GSPSA"
        )
    ]
    
    @StateObject private var repository = AnimalRepository()
    @State private var searchText = ""
    @State private var showingFilterSheet = false
    
    var filteredAnimals: [AnimalMock] {
        if !searchText.isEmpty {
            animals = animals.filter { animal in
                animal.name.localizedCaseInsensitiveContains(searchText) ||
                animal.animalId.localizedCaseInsensitiveContains(searchText) ||
                animal.reporterName.localizedCaseInsensitiveContains(searchText)
            }
        }
        return animals
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
                
                List(filteredAnimals) { animal in
                    AnimalRow(animal: animal)
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                        .padding(.vertical, 4)
                }
                .listStyle(PlainListStyle())
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
