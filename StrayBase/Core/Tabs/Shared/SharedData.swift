//
//  SharedData.swift
//  StrayBase
//
//  Created by Nino Nozadze on 20.06.25.
//

enum AnimalType: String, CaseIterable, Codable {
    case dog = "dog"
    case cat = "cat"
    case other = "other"
}

enum Gender: String, CaseIterable, Codable {
    case male = "male"
    case female = "female"
    case unknown = "unknown"
}

enum Size: String, CaseIterable, Codable {
    case small = "small"
    case medium = "medium"
    case large = "large"
}

enum OrganizationType: String, CaseIterable {
    
    case shelter = "Shelters"
    case clinic = "Veterinary Clinics"
    
    var keyword: String {
        switch self {
        case .shelter:
            return "animal shelter nearby"
        case .clinic:
            return "veterinary clinic"
        }
    }
    
    var navTitle: String {
        switch self {
        case .shelter:
            return "Animal Shelters"
        case .clinic:
            return "Veterinary Clinics"
        }
    }
    
    var searchStateDesc: String {
        return "Searching \(self.rawValue)…"
    }
    
    var searchTitle: String {
        return "Search \(self.rawValue)"
    }
    
    var notFoundTitle: String {
        return "No \(self.rawValue) found"
    }
    
}

struct OrganizationConsts {
    static let unknown = "Unknown"
    static let noAddress = "No address"
    static let retryButtonLabel = "Retry"
    static let notFoundImageName = "house.slash"
    static let notFoundSuggestionText = "Try adjusting your search or filters"
    static let clearFilters = "Clear Filters"
}
