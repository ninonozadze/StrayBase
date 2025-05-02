//
//  AddStrayTabView.swift
//  StrayBase
//
//  Created by Nino Nozadze on 21.03.25.
//

import SwiftUI

struct AddStrayTabView: View {
    var body: some View {
        VStack {
            Image("pet-care") // TODO: tmp
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width / 7,
                       height: UIScreen.main.bounds.width / 7)
                .foregroundColor(.gray)
            
            Text("AddStrayTabView") // TODO: tmp
                .font(.title3)
                .fontWeight(.bold)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}

struct AddStrayTabView_Previews: PreviewProvider {
    static var previews: some View {
        AddStrayTabView()
    }
}
