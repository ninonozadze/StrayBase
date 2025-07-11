//
//  VeterinaryClinicListTabView.swift
//  StrayBase
//
//  Created by Nino Nozadze on 02.05.25.
//

import SwiftUI

struct VeterinaryClinicListTabView: View {
    
    var body: some View {
        OrganizationListView(organizationType: .clinic)
    }
    
}

struct VeterinaryClinicListTabView_Previews: PreviewProvider {
    
    static var previews: some View {
        VeterinaryClinicListTabView()
    }
    
}
