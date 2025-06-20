//
//  SharedData.swift
//  StrayBase
//
//  Created by Nino Nozadze on 20.06.25.
//

enum AnimalType: String, CaseIterable {
    case dog = "dog"
    case cat = "cat"
    case other = "other"
}

enum Gender: String, CaseIterable {
    case male = "male"
    case female = "female"
    case unknown = "unknown"
}

enum Size: String, CaseIterable {
    case small = "small"
    case medium = "medium"
    case large = "large"
}
