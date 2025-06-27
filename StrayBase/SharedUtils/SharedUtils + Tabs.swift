//
//  SharedUtils + Tabs.swift
//  StrayBase
//
//  Created by Nino Nozadze on 18.06.25.
//

extension SharedUtils {
    
    enum tab: Hashable {
        case dashboard, shelter, addStray, clinic, profile
    }
    
}

extension SharedUtils.tab {
    
    var tabTitle: String {
        switch self {
        case .dashboard:
            return "Home"
        case .shelter:
            return "Shelters"
        case .addStray:
            return "Add Stray"
        case .clinic:
            return "Clinics"
        case .profile:
            return "Profile"
        }
    }

    var tabImageName: String {
        switch self {
        case .dashboard:
            return "house"
        case .shelter:
            return "mappin.and.ellipse.circle"
        case .addStray:
            return "pawprint"
        case .clinic:
            return "heart.text.square"
        case .profile:
            return "person"
        }
    }
    
}

extension SharedUtils {
    
    struct TabViews {
        
        struct ReportStrayView {
            // TODO: implementation
        }
        
        struct ProfileView {
            static let accountSectionTitle = "Account"
            
            static let signOutImageName = "arrow.left.circle.fill"
            static let signOutTitle = "Sign Out"
            
            static let deleteAccountImageName = "xmark.circle.fill"
            static let deleteAccountTitle = "Delete Account"
            
            static let deleteAlertTitle = "Delete Account"
            static let deleteAlertDescription = "Are you sure you want to delete your account?"
            static let deleteAlertButton = "Delete"
            
            static let signOutAlertTitle = "Sign out"
            static let signOutAlertDescription = "Are you sure you want to sign out?"
            static let signOutAlertButton = "Sign out"
        }
        
    }
}
