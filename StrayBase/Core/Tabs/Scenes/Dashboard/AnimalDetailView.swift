//
//  AnimalDetailView.swift
//  StrayBase
//
//  Created by Nino Nozadze on 28.07.25.
//

import SwiftUI

struct AnimalDetailView: View {
    
    let animal: Animal
    @EnvironmentObject var animalRepository: AnimalRepository
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                AsyncImage(url: URL(string: animal.imageURL ?? "")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Image(SharedUtils.appIcon)
                        .resizable()
                        .scaledToFill()
                        .foregroundColor(.gray.opacity(0.6))
                        .background(Color.gray.opacity(0.1))
                }
                .frame(height: 300)
                .clipped()
                .cornerRadius(16)
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Basic Information")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    DetailRow(
                        title: "Name",
                        value: animal.name
                    )
                    DetailRow(
                        title: "Animal ID",
                        value: animal.animalId
                    )
                    DetailRow(
                        title: "Type",
                        value: animal.type.rawValue.capitalized
                    )
                    DetailRow(
                        title: "Breed",
                        value: animal.breed
                    )
                    DetailRow(
                        title: "Age",
                        value: animal.age
                    )
                    DetailRow(
                        title: "Gender",
                        value: animal.gender.rawValue.capitalized
                    )
                    DetailRow(
                        title: "Size",
                        value: animal.size.rawValue.capitalized
                    )
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Location")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    DetailRow(
                        title: "Found at",
                        value: animal.locationFound
                    )
                    DetailRow(
                        title: "Date Reported",
                        value: DateFormatter.shortDate.string(from: animal.dateReported)
                    )
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Reporter Information")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    DetailRow(
                        title: "Name",
                        value: animal.reporterName
                    )
                    DetailRow(
                        title: "Phone",
                        value: animal.reporterPhone
                    )
                    DetailRow(
                        title: "Email",
                        value: animal.reporterEmail
                    )
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                
                if let medicalURL = animal.medicalRecordsURL {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Medical Records")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Link("View Medical Records", destination: URL(string: medicalURL)!)
                            .foregroundColor(.blue)
                            .font(.body)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                }
            }
            .padding()
        }
        .navigationTitle(animal.name)
        .navigationBarTitleDisplayMode(.large)
    }
}

