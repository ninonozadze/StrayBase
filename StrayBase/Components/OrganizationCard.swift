//
//  OrganizationCard.swift
//  StrayBase
//
//  Created by Nino Nozadze on 02.07.25.
//

import SwiftUI
import MapKit

struct OrganizationCard: View {
    let shelter: Shelter
    
    @Environment(\.openURL) private var openURL
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(shelter.name)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .lineLimit(2)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    if let distance = shelter.distance {
                        Text("\(String(format: "%.1f", distance / 1000)) km")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
            
            VStack(alignment: .leading, spacing: 8) {
                InfoRow(
                    icon: "location.fill",
                    iconColor: .blue,
                    text: shelter.address,
                    textColor: .secondary
                )
                
                if let phone = shelter.phone {
                    InfoRow(
                        icon:"phone.fill",
                        iconColor: .green,
                        text: phone,
                        textColor: .secondary
                    )
                }
                
                if let website = shelter.website {
                    InfoRow(
                        icon:"globe",
                        iconColor: .purple,
                        text: website,
                        textColor: .blue
                    )
                }
            }
            
            HStack(spacing: 12) {
                if let phone = shelter.phone,
                   let phoneURL = URL(string: "tel:\(phone)") {
                    ActionButton(
                        action: {
                            openURL(phoneURL)
                        },
                        imageName: "phone",
                        text: "Call",
                        backgroundColor: .blue
                    )
                }
                
                ActionButton(
                    action: {
                        let geocoder = CLGeocoder()
                        geocoder.geocodeAddressString(shelter.address) { placemarks, error in
                            guard let placemark = placemarks?.first,
                                  let location = placemark.location else { return }
                            
                            let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: location.coordinate))
                            mapItem.name = shelter.name
                            mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
                        }
                    },
                    imageName: "location",
                    text: "Directions",
                    backgroundColor: .green
                )
                
                if let website = shelter.website,
                    let websiteURL = URL(string: website) {
                    ActionButton(
                        action: {
                            openURL(websiteURL)
                        },
                        imageName: "globe",
                        text: "Website",
                        backgroundColor: .purple
                    )
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}

