//
//  ReportStrayView.swift
//  StrayBase
//
//  Created by Nino Nozadze on 17.06.25.
//

import SwiftUI
import PhotosUI

struct ReportStrayView: View {
    @State private var form = ReportStrayForm()

    @State private var isSubmitting = false
    @State private var showingSuccessAlert = false
    @State private var showingErrorAlert = false
    @State private var errorMessage = ""

    @State private var showingImagePicker = false
    @State private var showingDocumentPicker = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    headerSection
                    photoSection
                    basicInfoSection
                    physicalDetailsSection
                    locationSection
                    contactSection
                    medicalRecordsSection
                    submitButton
                }
                .padding()
            }
            .navigationTitle("Report Stray Animal")
            .navigationBarTitleDisplayMode(.large)
            .alert("Success", isPresented: $showingSuccessAlert) {
                Button("OK") {
                    clearForm()
                }
            } message: {
                Text("Stray animal report submitted successfully!")
            }
            .alert("Error", isPresented: $showingErrorAlert) {
                Button("OK") { }
            } message: {
                Text(errorMessage)
            }
        }
    }
    
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Help a stray")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            
            Text("Please fill out the information below to report a stray animal.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var photoSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("Animal Photo", systemImage: "camera")
                .font(.headline)
            
            if let animalImage = animalImage {
                Image(uiImage: animalImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200)
                    .clipped()
                    .cornerRadius(12)
                    .overlay(
                        Button("Change Photo") {
                            showingImagePicker = true
                        }
                            .buttonStyle(.borderedProminent)
                            .controlSize(.small),
                        alignment: .bottomTrailing
                    )
                    .padding(.bottom, 8)
            } else {
                Button(action: { showingImagePicker = true }) {
                    VStack(spacing: 12) {
                        Image(systemName: "camera.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.blue)
                        
                        Text("Add Photo")
                            .font(.headline)
                        
                        Text("Tap to select a photo of the animal")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 150)
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                }
                .buttonStyle(.plain)
            }
        }
        .photosPicker(isPresented: $showingImagePicker, selection: $selectedPhoto, matching: .images)
        .onChange(of: selectedPhoto) { newItem in
            Task {
                if let data = try? await newItem?.loadTransferable(type: Data.self),
                   let image = UIImage(data: data) {
                    animalImage = image
                }
            }
        }
    }
    
    private var basicInfoSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Label("Basic Information", systemImage: "info.circle")
                .font(.headline)
            
            VStack(spacing: 12) {
                InputView(
                    text: $animalName,
                    title: "Animal Name (if known)",
                    placeholder: "",
                    style: .rounded
                )
                
                InputView(
                    text: $animalID,
                    title: "Animal ID",
                    placeholder: "",
                    style: .rounded
                )
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Animal Type")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Picker("Animal Type", selection: $animalType) {
                            ForEach(AnimalType.allCases, id: \.self) { type in
                                Text(type.rawValue.capitalized).tag(type)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                }
            
                InputView(
                    text: $animalBreed,
                    title: "Breed (if known)",
                    placeholder: "",
                    style: .rounded
                )
                
                InputView(
                    text: $animalAge,
                    title: "Estimated Age",
                    placeholder: "",
                    style: .rounded
                )
                
            }
        }
    }
    
    private var physicalDetailsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Label("Physical Details", systemImage: "ruler")
                .font(.headline)
            
            VStack(spacing: 12) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Gender")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Picker("Gender", selection: $animalGender) {
                            ForEach(Gender.allCases, id: \.self) { gender in
                                Text(gender.rawValue.capitalized).tag(gender)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                }
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Size")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Picker("Size", selection: $animalSize) {
                            ForEach(Size.allCases, id: \.self) { size in
                                Text(size.rawValue.capitalized).tag(size)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                }
                
            }
        }
    }
    
    private var locationSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Label("Location Information", systemImage: "location")
                .font(.headline)
            
            VStack(spacing: 12) {
                InputView(
                    text: $locationFound,
                    title: "City",
                    placeholder: "",
                    style: .rounded
                )
            }
        }
    }
    
    private var contactSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Label("Reporter", systemImage: "person")
                .font(.headline)
            
            VStack(spacing: 12) {
                InputView(
                    text: $contactName,
                    title: "Organization Name",
                    placeholder: "",
                    style: .rounded
                )
                
                InputView(
                    text: $contactPhone,
                    title: "Phone Number",
                    placeholder: "",
                    style: .rounded
                )
                .keyboardType(.phonePad)
                
                InputView(
                    text: $contactEmail,
                    title: "Email Address",
                    placeholder: "",
                    style: .rounded
                )
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
            }
        }
    }
    
    private var medicalRecordsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Label("Medical Records", systemImage: "doc.text")
                .font(.headline)
            
            VStack(spacing: 12) {
                if !medicalFileName.isEmpty {
                    HStack {
                        Image(systemName: "doc.fill")
                            .foregroundColor(.blue)
                        Text(medicalFileName)
                            .font(.subheadline)
                        Spacer()
                        Button("Remove") {
                            selectedMedicalFile = nil
                            medicalFileName = ""
                        }
                        .font(.caption)
                        .foregroundColor(.red)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                }
                
                Button(action: { showingDocumentPicker = true }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text(medicalFileName.isEmpty ? "Upload Medical Records (PDF)" : "Change File")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .foregroundColor(.blue)
                    .cornerRadius(8)
                }
                .sheet(isPresented: $showingDocumentPicker) {
                    DocumentPicker(selectedFile: $selectedMedicalFile, fileName: $medicalFileName)
                }
            }
        }
    }
    
    private var submitButton: some View {
        Button(action: submitReport) {
            HStack {
                if isSubmitting {
                    ProgressView()
                        .scaleEffect(0.8)
                        .foregroundColor(.white)
                }
                Text(isSubmitting ? "Submitting..." : "Submit Report")
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(isFormValid ? Color.blue : Color.gray)
            .foregroundColor(.white)
            .cornerRadius(12)
        }
        .disabled(!isFormValid || isSubmitting)
    }
    
    private var isFormValid: Bool {
        !animalName.isEmpty &&
        !contactName.isEmpty &&
        !contactPhone.isEmpty &&
        !contactEmail.isEmpty &&
        animalImage != nil
    }
    
    private func submitReport() {
        // TODO: implementation
    }
    
    private func clearForm() {
        animalName = ""
        animalID = ""
        animalType = .dog
        animalBreed = ""
        animalAge = ""
        animalGender = .unknown
        animalSize = .medium
        locationFound = ""
        contactName = ""
        contactPhone = ""
        contactEmail = ""
        animalImage = nil
        selectedPhoto = nil
        selectedMedicalFile = nil
        medicalFileName = ""
    }
}

struct ReportStrayView_Previews: PreviewProvider {
    static var previews: some View {
        ReportStrayView()
    }
}
