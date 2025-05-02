//
//  SettingsTabView.swift
//  StrayBase
//
//  Created by Nino Nozadze on 21.03.25.
//

import SwiftUI

struct SettingsTabView: View {
    var body: some View {
        VStack {
            Image("pet-care") // TODO: tmp
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width / 7,
                       height: UIScreen.main.bounds.width / 7)
                .foregroundColor(.gray)
            
            Text("SettingsTabView") // TODO: tmp
                .font(.title3)
                .fontWeight(.bold)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}

struct SettingsTabView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsTabView()
    }
}
