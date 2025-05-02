//
//  FosterListTabView.swift
//  StrayBase
//
//  Created by Nino Nozadze on 02.05.25.
//

import SwiftUI

struct FosterListTabView: View {
    var body: some View {
        VStack {
            Image("pet-care") // TODO: tmp
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width / 7,
                       height: UIScreen.main.bounds.width / 7)
                .foregroundColor(.gray)
            
            Text("FosterListTabView") // TODO: tmp
                .font(.title3)
                .fontWeight(.bold)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}

struct FosterListTabView_Previews: PreviewProvider {
    static var previews: some View {
        FosterListTabView()
    }
}
