//
//  ProfileView.swift
//  StrayBase
//
//  Created by Nino Nozadze on 25.03.25.
//

import SwiftUI

private typealias ProfileViewConsts = SharedUtils.AuthenticationViews.ProfileView

struct ProfileView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var showDeleteAlert = false
    @State private var showSignOutAlert = false
    
    var body: some View {
        if let user = viewModel.currentUser {
            List {
                Section {
                    HStack {
                        Text(user.initials)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 72, height: 72)
                            .background(Color(.systemGray3))
                            .clipShape(.circle)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(user.fullname)
                                .font(.headline)
                                .fontWeight(.semibold)
                                .padding(.top, 4)
                            
                            Text(user.email)
                                .font(.footnote)
                                .foregroundColor(.gray)
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
                        showSignOutAlert = true
                    } label: {
                        SettingsRowView(
                            imageName: ProfileViewConsts.signOutImageName,
                            title: ProfileViewConsts.signOutTitle,
                            tintColor: .red
                        )
                    }
                    .alert(isPresented: $showSignOutAlert) {
                        Alert(
                            title: Text(ProfileViewConsts.signOutAlertTitle),
                            message: Text(ProfileViewConsts.signOutAlertDescription),
                            primaryButton: .destructive(Text(ProfileViewConsts.signOutAlertButton)) {
                                Task {
                                    do {
                                        try await viewModel.signOut()
                                    } catch {
                                        print("DEBUG: Failed to sign out with error - \(error.localizedDescription)")
                                    }
                                }
                            },
                            secondaryButton: .cancel()
                        )
                    }
                    
                    Button {
                        showDeleteAlert = true
                    } label: {
                        SettingsRowView(
                            imageName: ProfileViewConsts.deleteAccountImageName,
                            title: ProfileViewConsts.deleteAccountTitle,
                            tintColor: .red
                        )
                    }
                    .alert(isPresented: $showDeleteAlert) {
                        Alert(
                            title: Text(ProfileViewConsts.deleteAlertTitle),
                            message: Text(ProfileViewConsts.deleteAlertDescription),
                            primaryButton: .destructive(Text(ProfileViewConsts.deleteAlertButton)) {
                                Task {
                                    do {
                                        try await viewModel.deleteAccount()
                                    } catch {
                                        print("DEBUG: Failed to delete account with error - \(error.localizedDescription)")
                                    }
                                }
                            },
                            secondaryButton: .cancel()
                        )
                    }
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
