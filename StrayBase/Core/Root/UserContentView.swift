//
//  UserContentView.swift
//  StrayBase
//
//  Created by Nino Nozadze on 02.05.25.
//

import SwiftUI

struct UserContentView: View {
    
    @State private var selectedTab: SharedUtils.tab = .dashboard
    private let tabBarHeight: CGFloat = 80
    
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
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.bottom, tabBarHeight + 4)

            
            AnimatedTabBar(selectedTab: $selectedTab)
                .frame(height: tabBarHeight)
        }
    }
    
}

struct UserContentView_Previews: PreviewProvider {
    static var previews: some View {
        UserContentView()
    }
}
