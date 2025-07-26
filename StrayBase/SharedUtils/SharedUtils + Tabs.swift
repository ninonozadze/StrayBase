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
        
        struct DashboardView {
            static let navTitle = "Stray Animals"
            static let searchPrompt = "Search animals, ID, or organization"
            static let totelAnimalTitle = "Total Animals"
            static let organizationTitle = "Organizations"
        }
        
        struct ReportPage {
            static let navTitle = "Report Stray Animal"
            static let headerTitle = "Help a stray"
            static let headerSubtitle = "Please fill out the information below to report a stray animal."
            static let successTitle = "Success"
            static let successMessage = "Stray animal report submitted successfully!"
            static let errorTitle = "Error"
            
            struct Sections {
                static let animalPhotoTitle = "Animal Photo"
                static let animalPhotoName = "camera"
                static let basicInfo = "Basic Information"
                static let physicalDetails = "Physical Details"
                static let location = "Location Information"
                static let reporter = "Reporter"
                static let medicalRecords = "Medical Records"
            }
            
            struct Images {
                static let camera = "camera.fill"
                static let info = "info.circle"
                static let ruler = "ruler"
                static let person = "person"
                static let docText = "doc.text"
                static let docFill = "doc.fill"
                static let plus = "plus.circle.fill"
                static let location = "location"
                
            }
            
            struct Texts {
                static let addPhoto = "Add Photo"
                static let selectPhoto = "Tap to select a photo of the animal"
            }
            
            struct Fields {
                static let name = "Animal Name (if known)"
                static let id = "Animal ID"
                static let type = "Animal Type"
                static let breed = "Breed (if known)"
                static let age = "Estimated Age"
                static let gender = "Gender"
                static let size = "Size"
                static let city = "City"
                static let orgName = "Organization Name"
                static let orgPhone = "Phone Number"
                static let orgEmail = "Email Address"
            }
            
            struct Buttons {
                static let okButton = "OK"
                static let addPhoto = "Add Photo"
                static let changePhoto = "Change Photo"
                static let submit = "Submit Report"
                static let submitting = "Submitting..."
                static let remove = "Remove"
                static let uploadMedical = "Upload Medical Records (PDF)"
                static let changeFile = "Change File"
            }
        }
        
        struct ProfileView {
            static let reportStrayTitle = "Report A Stray"
            static let accountSectionTitle = "Account"
            
            static let reportImageName = "heart.circle.fill"
            static let reportTitle = "Report a Stray Animal"
            static let reportSubtitle = "Help us create database for stray animals"
            
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
