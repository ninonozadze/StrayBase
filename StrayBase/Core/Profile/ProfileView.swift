//
//  ProfileView.swift
//  StrayBase
//
//  Created by Nino Nozadze on 25.03.25.
//

import SwiftUI

private typealias ProfileViewConsts = SharedUtils.AuthenticationViews.ProfileView

struct ProfileView: View {
    var body: some View {
        List {
            Section {
                HStack {
                    Text("NN") // TODO: tmp
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 72, height: 72)
                        .background(Color(.systemGray3))
                        .clipShape(.circle)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Nino Nozadze") // TODO: tmp
                            .font(.headline)
                            .fontWeight(.semibold)
                            .padding(.top, 4)
                        
                        Text("test@example.com") // TODO: tmp
                            .font(.footnote)
                            .accentColor(.gray)
                    }
                }
            }
            
            Section(ProfileViewConsts.generalSectionTitle) {
                HStack {
                    SettingsRowView(
                        imageName: ProfileViewConsts.versionImageName,
                        title: ProfileViewConsts.versionTitle,
                        tintColor: Color(.systemGray)
                    )
                    
                    Spacer()
                    
                    Text("1.0.0") // TODO: tmp
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            
            Section(ProfileViewConsts.accountSectionTitle) {
                Button {
                    print("sign out") // TODO: tmp
                } label: {
                    SettingsRowView(
                        imageName: ProfileViewConsts.signOutImageName,
                        title: ProfileViewConsts.signOutTitle,
                        tintColor: .red
                    )
                }
                
                Button {
                    print("delete") // TODO: tmp
                } label: {
                    SettingsRowView(
                        imageName: ProfileViewConsts.deleteAccountImageName,
                        title: ProfileViewConsts.deleteAccountTitle,
                        tintColor: .red
                    )
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
