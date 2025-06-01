//
//  UserContentView.swift
//  StrayBase
//
//  Created by Nino Nozadze on 02.05.25.
//

import SwiftUI

private typealias TabViewsConst = SharedUtils.TabViews

struct UserContentView: View {
    
    var body: some View {
        TabView {
            NavigationStack {
                DashboardTabView()
                    .navigationTitle(TabViewsConst.DashboardTabView.navigationTitle)
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Label(TabViewsConst.DashboardTabView.tabItemLabel,
                      systemImage: TabViewsConst.DashboardTabView.tabItemImageName)
            }
            
            NavigationStack {
                ProfileTabView()
                    .navigationTitle(TabViewsConst.ProfileTabView.navigationTitle)
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Label(TabViewsConst.ProfileTabView.tabItemLabel,
                      systemImage: TabViewsConst.ProfileTabView.tabItemImageName)
            }
        }
    }
    
}

struct UserContentView_Previews: PreviewProvider {
    static var previews: some View {
        UserContentView()
    }
}
