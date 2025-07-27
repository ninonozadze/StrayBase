//
//  ReportStrayView.swift
//  StrayBase
//
//  Created by Nino Nozadze on 17.06.25.
//

import SwiftUI
import PhotosUI

struct ReportStrayView: View {
    
    private typealias ReportPageConsts = SharedUtils.TabViews.ReportPage
    
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
            .navigationTitle(ReportPageConsts.navTitle)
            .navigationBarTitleDisplayMode(.large)
            .alert(ReportPageConsts.successTitle,
                   isPresented: $showingSuccessAlert) {
                Button(ReportPageConsts.Buttons.okButton) {
                    clearForm()
                }
            } message: {
                Text(ReportPageConsts.successMessage)
            }
            .alert(ReportPageConsts.errorTitle,
                   isPresented: $showingErrorAlert) {
                Button(ReportPageConsts.Buttons.okButton) { }
            } message: {
                Text(errorMessage)
            }
        }
    }
    
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(ReportPageConsts.headerTitle)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            
            Text(ReportPageConsts.headerSubtitle)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var photoSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label(ReportPageConsts.Sections.animalPhotoTitle,
                  systemImage: ReportPageConsts.Sections.animalPhotoName)
                .font(.headline)
            
            if let animalImage = form.animal.image {
                Image(uiImage: animalImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200)
                    .clipped()
                    .cornerRadius(12)
                    .overlay(
                        Button(ReportPageConsts.Buttons.changePhoto) {
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
                        Image(systemName: ReportPageConsts.Images.camera)
                            .font(.system(size: 40))
                            .foregroundColor(.blue)
                        
                        Text(ReportPageConsts.Texts.addPhoto)
                            .font(.headline)
                        
                        Text(ReportPageConsts.Texts.selectPhoto)
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
        .photosPicker(isPresented: $showingImagePicker, selection: $form.animal.selectedPhoto, matching: .images)
        .onChange(of: form.animal.selectedPhoto) { oldValue, newValue in
            Task {
                if let data = try? await newValue?.loadTransferable(type: Data.self),
                   let image = UIImage(data: data) {
                    form.animal.image = image
                }
            }
        }
    }
    
    private var basicInfoSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Label(ReportPageConsts.Sections.basicInfo,
                  systemImage: ReportPageConsts.Images.info)
                .font(.headline)
            
            VStack(spacing: 12) {
                InputView(
                    text: $form.animal.name,
                    title: ReportPageConsts.Fields.name,
                    placeholder: "",
                    style: .rounded
                )
                
                InputView(
                    text: $form.animal.id,
                    title: ReportPageConsts.Fields.id,
                    placeholder: "",
                    style: .rounded
                )
                
                VStack(alignment: .leading) {
                    Text(ReportPageConsts.Fields.type)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Picker(ReportPageConsts.Fields.type,
                           selection: $form.animal.type) {
                        ForEach(AnimalType.allCases, id: \.self) { type in
                            Text(type.rawValue.capitalized).tag(type)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            
                InputView(
                    text: $form.animal.breed,
                    title: ReportPageConsts.Fields.breed,
                    placeholder: "",
                    style: .rounded
                )
                
                InputView(
                    text: $form.animal.age,
                    title: ReportPageConsts.Fields.age,
                    placeholder: "",
                    style: .rounded
                )
            }
        }
    }
    
    private var physicalDetailsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Label(ReportPageConsts.Sections.physicalDetails,
                  systemImage: ReportPageConsts.Images.ruler)
                .font(.headline)
            
            VStack(spacing: 12) {
                VStack(alignment: .leading) {
                    Text(ReportPageConsts.Fields.gender)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Picker(ReportPageConsts.Fields.gender,
                           selection: $form.animal.gender) {
                        ForEach(Gender.allCases, id: \.self) { gender in
                            Text(gender.rawValue.capitalized).tag(gender)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                VStack(alignment: .leading) {
                    Text(ReportPageConsts.Fields.size)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Picker(ReportPageConsts.Fields.size,
                           selection: $form.animal.size) {
                        ForEach(Size.allCases, id: \.self) { size in
                            Text(size.rawValue.capitalized).tag(size)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
        }
    }
    
    private var locationSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Label(ReportPageConsts.Sections.location,
                  systemImage: ReportPageConsts.Images.location)
                .font(.headline)
            
            InputView(
                text: $form.animal.locationFound,
                title: ReportPageConsts.Fields.city,
                placeholder: "",
                style: .rounded
            )
        }
    }
    
    private var contactSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Label(ReportPageConsts.Sections.reporter,
                  systemImage: ReportPageConsts.Images.person)
                .font(.headline)
            
            VStack(spacing: 12) {
                InputView(
                    text: $form.contact.name,
                    title: ReportPageConsts.Fields.orgName,
                    placeholder: "",
                    style: .rounded
                )
                
                InputView(
                    text: $form.contact.phone,
                    title: ReportPageConsts.Fields.orgPhone,
                    placeholder: "",
                    style: .rounded
                )
                .keyboardType(.phonePad)
                
                InputView(
                    text: $form.contact.email,
                    title: ReportPageConsts.Fields.orgEmail,
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
            Label(ReportPageConsts.Sections.medicalRecords,
                  systemImage: ReportPageConsts.Images.docText)
                .font(.headline)
            
            VStack(spacing: 12) {
                if !form.medical.fileName.isEmpty {
                    HStack {
                        Image(systemName: ReportPageConsts.Images.docFill)
                            .foregroundColor(.blue)
                        Text(form.medical.fileName)
                            .font(.subheadline)
                        Spacer()
                        Button(ReportPageConsts.Buttons.remove) {
                            form.medical.file = nil
                            form.medical.fileName = ""
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
                        Image(systemName: ReportPageConsts.Images.plus)
                        Text(form.medical.fileName.isEmpty
                             ? ReportPageConsts.Buttons.uploadMedical
                             : ReportPageConsts.Buttons.changeFile)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .foregroundColor(.blue)
                    .cornerRadius(8)
                }
                .sheet(isPresented: $showingDocumentPicker) {
                    DocumentPicker(selectedFile: $form.medical.file, fileName: $form.medical.fileName)
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
                Text(isSubmitting
                     ? ReportPageConsts.Buttons.submitting
                     : ReportPageConsts.Buttons.submit)
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
        !form.animal.id.isEmpty &&
        !form.contact.name.isEmpty &&
        !form.contact.phone.isEmpty &&
        !form.contact.email.isEmpty
    }
    
    private func submitReport() {
        // TODO: implementation
    }
    
    private func clearForm() {
        form = ReportStrayForm()
    }
}

struct ReportStrayView_Previews: PreviewProvider {
    static var previews: some View {
        ReportStrayView()
    }
}
