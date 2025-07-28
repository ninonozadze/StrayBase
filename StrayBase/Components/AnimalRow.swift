//
//  AnimalRow.swift
//  StrayBase
//
//  Created by Nino Nozadze on 26.07.25.
//

import SwiftUI

struct AnimalRow: View {
    let animal: Animal
    
    var body: some View {
        HStack(spacing: 16) {
            AsyncImage(url: URL(string: animal.imageURL ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Image(SharedUtils.appIcon)
                    .resizable()
                    .scaledToFill()
                    .foregroundColor(.gray.opacity(0.6))
                    .frame(width: 70, height: 70)
                    .background(Color.gray.opacity(0.1))
            }
            .frame(width: 70, height: 70)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(animal.name)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                    
                    Spacer()
                    
                    Text("ID: \(animal.animalId)")
                        .font(.caption)
                        .fontWeight(.medium)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.blue.opacity(0.1))
                        .foregroundColor(.blue)
                        .clipShape(Capsule())
                }
                
                HStack {
                    Image(systemName: SharedUtils.AnimalRow.organizationImage)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Text(animal.reporterName)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 2)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray.opacity(0.1), lineWidth: 1)
        )
    }
}
