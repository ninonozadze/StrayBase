//
//  UserContentView.swift
//  StrayBase
//
//  Created by Nino Nozadze on 02.05.25.
//

import SwiftUI

struct UserContentView: View {
    
    @State private var selectedTab: SharedUtils.tab = .dashboard
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.white
                .ignoresSafeArea()
            
            Group {
                switch selectedTab {
                case .dashboard:
                    DashboardTabView()
                case .shelter:
                    SheltersListTabView()
                case .addStray:
                    AddStrayTabView()
                case .foster:
                    FostersListTabView()
                case .profile:
                    ProfileView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            
            AnimatedTabBar(selectedTab: $selectedTab)
        }
    }
    
}

struct UserContentView_Previews: PreviewProvider {
    static var previews: some View {
        UserContentView()
    }
}
