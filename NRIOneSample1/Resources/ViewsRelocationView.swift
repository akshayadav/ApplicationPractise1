//
//  RelocationView.swift
//  NRIOneSample1
//
//  Created by Akshay Yadav on 3/5/26.
//

import SwiftUI

struct RelocationView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var currentLocation = ""
    @State private var destinationCity = ""
    @State private var moveDate = Date()
    @State private var additionalNotes = ""
    @State private var showingConfirmation = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Personal Information") {
                    TextField("Full Name", text: $name)
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                    TextField("Phone Number", text: $phone)
                        .keyboardType(.phonePad)
                }
                
                Section("Relocation Details") {
                    TextField("Current Location", text: $currentLocation)
                    TextField("Destination City", text: $destinationCity)
                    DatePicker("Expected Move Date", selection: $moveDate, displayedComponents: .date)
                }
                
                Section("Additional Information") {
                    TextEditor(text: $additionalNotes)
                        .frame(minHeight: 100)
                }
                
                Section {
                    Button {
                        showingConfirmation = true
                    } label: {
                        Text("Submit Request")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(red: 0.7, green: 0.2, blue: 0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .listRowBackground(Color.clear)
                }
            }
            .navigationTitle("Relocation Assistance")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Request Submitted", isPresented: $showingConfirmation) {
                Button("OK") {
                    // Reset form
                    name = ""
                    email = ""
                    phone = ""
                    currentLocation = ""
                    destinationCity = ""
                    additionalNotes = ""
                }
            } message: {
                Text("Our relocation team will contact you within 24 hours.")
            }
        }
    }
}

#Preview {
    RelocationView()
}
