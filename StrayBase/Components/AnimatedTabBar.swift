//
//  AnimatedTabBar.swift
//  StrayBase
//
//  Created by Nino Nozadze on 10.06.25.
//

import SwiftUI

struct AnimatedTabBar: View {
    
    
    @Binding var selectedTab: SharedUtils.tab
    
    private let allTabs: [SharedUtils.tab] = [
        .dashboard, .shelter, .addStray, .clinic, .profile
    ]
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(allTabs, id: \.self) { tab in
                AnimatedTabBarButton(
                    tab: tab,
                    selectedTab: $selectedTab
                )
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(30)
        .padding(.horizontal)
    }
    
}

struct AnimatedTabBarButton: View {
    
    let tab: SharedUtils.tab
    @Binding var selectedTab: SharedUtils.tab
    
    var isSelected: Bool {
        selectedTab == tab
    }
    
    var body: some View {
        GeometryReader { reader in
            Button(action: {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                    selectedTab = tab
                }
            }, label: {
                VStack(spacing: 4) {
                    Image(systemName: tab.tabImageName)
                        .symbolVariant(isSelected ? .fill : .none)
                        .scaleEffect(isSelected ? 1.1 : 1.0)
                        .font(.system(size: 25, weight: .semibold))
                        .foregroundStyle(Color.cyan)
                        .offset(y: isSelected ? -5 : 0)
                    
                    Text(tab.tabTitle)
                        .font(.caption)
                        .foregroundColor(isSelected ? .cyan : .gray)
                        .scaleEffect(isSelected ? 1.1 : 1.0)
                }
            })
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(height: 50)
    }
}

struct AnimatedTabBar_Previews: PreviewProvider {
    static var previews: some View {
        UserContentView()
    }
}
