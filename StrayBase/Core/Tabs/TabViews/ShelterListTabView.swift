//
//  ShelterListTabView.swift
//  StrayBase
//
//  Created by Nino Nozadze on 02.05.25.
//

import SwiftUI

struct ShelterListTabView: View {
    
    var body: some View {
        OrganizationListView(organizationType: .shelter)
    }
    
}

struct ShelterListTabView_Previews: PreviewProvider {
    
    static var previews: some View {
        ShelterListTabView()
    }
    
}
