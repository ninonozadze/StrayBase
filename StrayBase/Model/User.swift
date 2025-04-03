//
//  User.swift
//  StrayBase
//
//  Created by Nino Nozadze on 03.04.25.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let fullname: String
    let email: String
    
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullname) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        
        return ""
    }
}

extension User {
    static var MOCK_USER: User {
        .init(
            id: NSUUID().uuidString,
            fullname: "Nino Nozadze",
            email: "test@example.com"
        )
    }
}
