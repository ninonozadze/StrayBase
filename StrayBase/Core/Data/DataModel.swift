//
//  DataModel.swift
//  StrayBase
//
//  Created by Nino Nozadze on 27.07.25.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseStorage
import UIKit

struct Animal: Codable, Identifiable {
    @DocumentID var id: String?
    var name: String
    var animalId: String
    var type: AnimalType
    var breed: String
    var age: String
    var gender: Gender
    var size: Size
    var locationFound: String
    var imageURL: String?
    var medicalRecordsURL: String?
    var reporterName: String
    var reporterPhone: String
    var reporterEmail: String
    var dateReported: Date
    var isActive: Bool
    
    init() {
        self.name = ""
        self.animalId = ""
        self.type = .dog
        self.breed = ""
        self.age = ""
        self.gender = .unknown
        self.size = .medium
        self.locationFound = ""
        self.imageURL = nil
        self.medicalRecordsURL = nil
        self.reporterName = ""
        self.reporterPhone = ""
        self.reporterEmail = ""
        self.dateReported = Date()
        self.isActive = true
    }
    
    init(from form: ReportStrayForm) {
        self.name = form.animal.name
        self.animalId = form.animal.id
        self.type = form.animal.type
        self.breed = form.animal.breed
        self.age = form.animal.age
        self.gender = form.animal.gender
        self.size = form.animal.size
        self.locationFound = form.animal.locationFound
        self.imageURL = nil
        self.medicalRecordsURL = nil
        self.reporterName = form.contact.name
        self.reporterPhone = form.contact.phone
        self.reporterEmail = form.contact.email
        self.dateReported = Date()
        self.isActive = true
    }
}

class FirestoreService: ObservableObject {
    private let db = Firestore.firestore()
    private let storage = Storage.storage()
    
    func addAnimal(_ animal: Animal) async throws -> String {
        let document = try db.collection("animals").addDocument(from: animal)
        return document.documentID
    }
    
    func updateAnimal(_ animal: Animal) async throws {
        guard let id = animal.id else {
            throw FirestoreError.invalidDocumentID
        }
        try db.collection("animals").document(id).setData(from: animal)
    }
    
    func getActiveAnimals() async throws -> [Animal] {
        let snapshot = try await db.collection("animals")
            .whereField("isActive", isEqualTo: true)
            .order(by: "dateReported", descending: true)
            .getDocuments()
        
        return try snapshot.documents.compactMap { document in
            try document.data(as: Animal.self)
        }
    }
    
    func getAnimalsByType(_ type: AnimalType) async throws -> [Animal] {
        let snapshot = try await db.collection("animals")
            .whereField("type", isEqualTo: type.rawValue)
            .whereField("isActive", isEqualTo: true)
            .order(by: "dateReported", descending: true)
            .getDocuments()
        
        return try snapshot.documents.compactMap { document in
            try document.data(as: Animal.self)
        }
    }
    
    func searchAnimalsByLocation(_ location: String) async throws -> [Animal] {
        let snapshot = try await db.collection("animals")
            .whereField("locationFound", isGreaterThanOrEqualTo: location)
            .whereField("locationFound", isLessThan: location + "\u{f8ff}")
            .whereField("isActive", isEqualTo: true)
            .getDocuments()
        
        return try snapshot.documents.compactMap { document in
            try document.data(as: Animal.self)
        }
    }
    
    func getAnimal(by id: String) async throws -> Animal? {
        let document = try await db.collection("animals").document(id).getDocument()
        return try document.data(as: Animal.self)
    }
    
    func markAnimalAsFound(_ animalId: String) async throws {
        try await db.collection("animals").document(animalId).updateData([
            "isActive": false
        ])
    }
    
    func deleteAnimal(_ animalId: String) async throws {
        try await db.collection("animals").document(animalId).delete()
    }
    
    func uploadImage(_ image: UIImage, path: String) async throws -> String {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            throw StorageError.imageCompressionFailed
        }
        
        let storageRef = storage.reference().child("images/\(path)")
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        _ = try await storageRef.putDataAsync(imageData, metadata: metadata)
        let downloadURL = try await storageRef.downloadURL()
        return downloadURL.absoluteString
    }
    
    func uploadMedicalFile(_ fileURL: URL, path: String) async throws -> String {
        let storageRef = storage.reference().child("medical_records/\(path)")
        let metadata = StorageMetadata()
        metadata.contentType = "application/pdf"
        
        _ = try await storageRef.putFileAsync(from: fileURL, metadata: metadata)
        let downloadURL = try await storageRef.downloadURL()
        return downloadURL.absoluteString
    }
    
    func deleteFile(url: String) async throws {
        let storageRef = storage.reference(forURL: url)
        try await storageRef.delete()
    }
}

class AnimalRepository: ObservableObject {
    private let firestoreService = FirestoreService()
    
    @Published var animals: [Animal] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func saveAnimalReport(from form: ReportStrayForm) async throws -> String {
        var animal = Animal(from: form)
        
        let timestamp = Int(Date().timeIntervalSince1970)
        let animalIdForFiles = form.animal.id.isEmpty ? UUID().uuidString : form.animal.id
        
        if let image = form.animal.image {
            let imagePath = "\(animalIdForFiles)_\(timestamp).jpg"
            animal.imageURL = try await firestoreService.uploadImage(image, path: imagePath)
        }
        
        if let medicalFileURL = form.medical.file {
            let fileName = form.medical.fileName.isEmpty ? "medical_\(timestamp).pdf" : form.medical.fileName
            let filePath = "\(animalIdForFiles)_\(fileName)"
            animal.medicalRecordsURL = try await firestoreService.uploadMedicalFile(medicalFileURL, path: filePath)
        }
        
        let documentId = try await firestoreService.addAnimal(animal)
        
        await loadAnimals()
        
        return documentId
    }
    
    @MainActor
    func loadAnimals() async {
        isLoading = true
        errorMessage = nil
        
        do {
            animals = try await firestoreService.getActiveAnimals()
        } catch {
            errorMessage = "Failed to load animals: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    @MainActor
    func loadAnimals(by type: AnimalType) async {
        isLoading = true
        errorMessage = nil
        
        do {
            animals = try await firestoreService.getAnimalsByType(type)
        } catch {
            errorMessage = "Failed to load animals: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    @MainActor
    func searchAnimals(by location: String) async {
        guard !location.isEmpty else {
            await loadAnimals()
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        do {
            animals = try await firestoreService.searchAnimalsByLocation(location)
        } catch {
            errorMessage = "Failed to search animals: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    func markAsFound(_ animal: Animal) async throws {
        guard let id = animal.id else { return }
        try await firestoreService.markAnimalAsFound(id)
        await loadAnimals()
    }
    
    func deleteAnimal(_ animal: Animal) async throws {
        guard let id = animal.id else { return }
        
        if let imageURL = animal.imageURL {
            try await firestoreService.deleteFile(url: imageURL)
        }
        
        if let medicalURL = animal.medicalRecordsURL {
            try await firestoreService.deleteFile(url: medicalURL)
        }
        
        try await firestoreService.deleteAnimal(id)
        await loadAnimals()
    }
}

enum FirestoreError: LocalizedError {
    case invalidDocumentID
    case networkError
    case encodingError
    
    var errorDescription: String? {
        switch self {
        case .invalidDocumentID:
            return "Invalid document ID"
        case .networkError:
            return "Network connection error"
        case .encodingError:
            return "Data encoding error"
        }
    }
}

enum StorageError: LocalizedError {
    case imageCompressionFailed
    case uploadFailed
    case downloadFailed
    
    var errorDescription: String? {
        switch self {
        case .imageCompressionFailed:
            return "Failed to compress image"
        case .uploadFailed:
            return "Failed to upload file"
        case .downloadFailed:
            return "Failed to download file"
        }
    }
}
