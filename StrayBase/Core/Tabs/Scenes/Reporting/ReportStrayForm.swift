//
//  ReportStrayForm.swift
//  StrayBase
//
//  Created by Nino Nozadze on 20.06.25.
//

struct ReportStrayForm {
    var animal = AnimalInfo()
    var contact = ContactInfo()
    var medical = MedicalInfo()
    
    struct AnimalInfo {
        var name = ""
        var id = ""
        var type = AnimalType.dog
        var breed = ""
        var age = ""
        var gender = Gender.unknown
        var size = Size.medium
        var locationFound = ""
        var image: UIImage?
        var selectedPhoto: PhotosPickerItem?
    }

    struct ContactInfo {
        var name = ""
        var phone = ""
        var email = ""
    }

    struct MedicalInfo {
        var file: URL?
        var fileName = ""
    }
}
