//
//  ProfileView.swift
//  StrayBase
//
//  Created by Nino Nozadze on 25.03.25.
//

import SwiftUI

private typealias ProfileViewConsts = SharedUtils.TabViews.ProfileView

struct ProfileView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var showReportStray = false
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
                
                Section(ProfileViewConsts.reportStrayTitle) {
                    ActionRowButton(
                        action: { showReportStray = true },
                        leadingImage: ProfileViewConsts.reportImageName,
                        title: ProfileViewConsts.reportTitle,
                        subtitle: ProfileViewConsts.reportSubtitle
                    )
                }
                
                Section(ProfileViewConsts.accountSectionTitle) {
                    ConfirmActionButton(viewModel: .init(
                        imageName: ProfileViewConsts.signOutImageName,
                        title: ProfileViewConsts.signOutTitle,
                        tintColor: .red,
                        alertTitle: ProfileViewConsts.signOutAlertTitle,
                        alertMessage: ProfileViewConsts.signOutAlertDescription,
                        alertConfirmButtonTitle: ProfileViewConsts.signOutAlertButton,
                        action: {
                            do {
                                try await viewModel.signOut()
                            } catch {
                                print("DEBUG: Failed to sign out with error - \(error.localizedDescription)")
                            }
                        }
                    ))
                    
                    ConfirmActionButton(viewModel: .init(
                        imageName: ProfileViewConsts.deleteAccountImageName,
                        title: ProfileViewConsts.deleteAccountTitle,
                        tintColor: .red,
                        alertTitle: ProfileViewConsts.deleteAlertTitle,
                        alertMessage: ProfileViewConsts.deleteAlertDescription,
                        alertConfirmButtonTitle: ProfileViewConsts.deleteAlertButton,
                        action: {
                            do {
                                try await viewModel.deleteAccount()
                            } catch {
                                print("DEBUG: Failed to delete account with error - \(error.localizedDescription)")
                            }
                        }
                    ))
                }
            }
            .sheet(isPresented: $showReportStray) {
                ReportStrayView()
            }
        }
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
