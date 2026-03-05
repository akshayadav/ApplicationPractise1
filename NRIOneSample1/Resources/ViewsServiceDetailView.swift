//
//  ServiceDetailView.swift
//  NRIOneSample1
//
//  Created by Akshay Yadav on 3/5/26.
//

import SwiftUI
import SwiftData

struct ServiceDetailView: View {
    let serviceType: ServiceType
    @Environment(\.modelContext) private var modelContext
    @Query private var services: [Service]
    
    var filteredServices: [Service] {
        services.filter { $0.serviceTypeEnum == serviceType }
    }
    
    var body: some View {
        List {
            Section {
                VStack(alignment: .leading, spacing: 12) {
                    Text(serviceType.rawValue)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text(serviceDescription)
                        .font(.body)
                        .foregroundStyle(.secondary)
                }
                .padding(.vertical, 8)
            }
            
            Section("Available Providers") {
                if filteredServices.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: serviceIcon)
                            .font(.system(size: 50))
                            .foregroundStyle(.gray)
                        
                        Text("No providers available yet")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        
                        Button {
                            addSampleService()
                        } label: {
                            Text("Add Sample Provider")
                                .font(.caption)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                } else {
                    ForEach(filteredServices) { service in
                        ServiceProviderRow(service: service)
                    }
                }
            }
            
            Section {
                Button {
                    // Request service action
                } label: {
                    Text("Request \(serviceType.rawValue)")
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
        .navigationTitle(serviceType.rawValue)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var serviceIcon: String {
        switch serviceType {
        case .interiors:
            return "sofa.fill"
        case .insurance:
            return "shield.fill"
        case .homeLoans:
            return "building.columns.fill"
        case .propertyManagement:
            return "building.2.fill"
        case .legalSupport:
            return "doc.text.fill"
        }
    }
    
    private var serviceDescription: String {
        switch serviceType {
        case .interiors:
            return "Transform your property with professional interior design services. From modern to traditional styles, our partners help create your dream space."
        case .insurance:
            return "Protect your investment with comprehensive property insurance. Coverage options for all types of real estate investments."
        case .homeLoans:
            return "Flexible financing options for NRI investors. Competitive rates and specialized NRI loan products."
        case .propertyManagement:
            return "Complete property management services including maintenance, tenant management, and rent collection."
        case .legalSupport:
            return "Expert legal assistance for property transactions, documentation, and NRI-specific legal requirements."
        }
    }
    
    private func addSampleService() {
        let service = Service(
            name: "Premium \(serviceType.rawValue)",
            type: serviceType,
            serviceDescription: serviceDescription,
            providerName: "NRI Services Partner",
            contactEmail: "contact@nrione.com",
            contactPhone: "+1-800-NRI-ONE"
        )
        modelContext.insert(service)
    }
}

struct ServiceProviderRow: View {
    let service: Service
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(service.providerName ?? "Provider")
                .font(.headline)
            
            if let description = service.serviceDescription {
                Text(description)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
            
            HStack(spacing: 20) {
                if let email = service.contactEmail {
                    Label(email, systemImage: "envelope.fill")
                        .font(.caption)
                        .foregroundStyle(.blue)
                }
                
                if let phone = service.contactPhone {
                    Label(phone, systemImage: "phone.fill")
                        .font(.caption)
                        .foregroundStyle(.blue)
                }
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    NavigationStack {
        ServiceDetailView(serviceType: .interiors)
            .modelContainer(for: Service.self)
    }
}
