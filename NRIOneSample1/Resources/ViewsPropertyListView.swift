//
//  PropertyListView.swift
//  NRIOneSample1
//
//  Created by Akshay Yadav on 3/5/26.
//

import SwiftUI
import SwiftData

enum ListingType {
    case buySell
    case rent
}

struct PropertyListView: View {
    let listingType: ListingType
    @Environment(\.modelContext) private var modelContext
    @Query private var properties: [Property]
    @State private var searchText = ""
    
    var filteredProperties: [Property] {
        if searchText.isEmpty {
            return properties
        }
        return properties.filter {
            $0.title.localizedCaseInsensitiveContains(searchText) ||
            $0.city.localizedCaseInsensitiveContains(searchText) ||
            $0.country.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        List {
            ForEach(filteredProperties) { property in
                NavigationLink {
                    PropertyDetailView(property: property)
                } label: {
                    PropertyRowView(property: property)
                }
            }
        }
        .navigationTitle(listingType == .buySell ? "Buy/Sell Properties" : "Rent Properties")
        .searchable(text: $searchText, prompt: "Search properties")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    addSampleProperty()
                } label: {
                    Label("Add Property", systemImage: "plus")
                }
            }
        }
    }
    
    private func addSampleProperty() {
        let property = Property(
            title: "Luxury Apartment in Downtown",
            location: "Business Bay",
            city: "Dubai",
            country: "UAE",
            price: 1200000,
            currency: "USD",
            propertyType: "Apartment",
            bedrooms: 3,
            bathrooms: 2,
            area: 1800,
            propertyDescription: "Modern luxury apartment with stunning city views",
            developer: "Danube Properties",
            isVerified: true
        )
        modelContext.insert(property)
    }
}

struct PropertyRowView: View {
    let property: Property
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(property.title)
                .font(.headline)
            
            HStack {
                Image(systemName: "location.fill")
                    .font(.caption)
                Text("\(property.city), \(property.country)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            HStack {
                Text("\(property.currency) \(Int(property.price).formatted())")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.blue)
                
                Spacer()
                
                HStack(spacing: 12) {
                    Label("\(property.bedrooms)", systemImage: "bed.double.fill")
                    Label("\(property.bathrooms)", systemImage: "shower.fill")
                    Label("\(Int(property.area)) sq ft", systemImage: "square.fill")
                }
                .font(.caption)
                .foregroundStyle(.secondary)
            }
            
            if property.isVerified {
                HStack {
                    Image(systemName: "checkmark.seal.fill")
                        .foregroundStyle(.green)
                    Text("Verified")
                        .font(.caption)
                        .foregroundStyle(.green)
                }
            }
        }
        .padding(.vertical, 4)
    }
}

struct PropertyDetailView: View {
    let property: Property
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Property Image Placeholder
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 250)
                    .overlay {
                        Image(systemName: "building.2.fill")
                            .font(.system(size: 60))
                            .foregroundStyle(.gray)
                    }
                
                VStack(alignment: .leading, spacing: 16) {
                    Text(property.title)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    HStack {
                        Image(systemName: "location.fill")
                        Text("\(property.location), \(property.city), \(property.country)")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    
                    Text("\(property.currency) \(Int(property.price).formatted())")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(.blue)
                    
                    Divider()
                    
                    HStack(spacing: 30) {
                        VStack {
                            Image(systemName: "bed.double.fill")
                                .font(.title3)
                            Text("\(property.bedrooms) Beds")
                                .font(.caption)
                        }
                        
                        VStack {
                            Image(systemName: "shower.fill")
                                .font(.title3)
                            Text("\(property.bathrooms) Baths")
                                .font(.caption)
                        }
                        
                        VStack {
                            Image(systemName: "square.fill")
                                .font(.title3)
                            Text("\(Int(property.area)) sq ft")
                                .font(.caption)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    
                    Divider()
                    
                    if let description = property.propertyDescription {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Description")
                                .font(.headline)
                            Text(description)
                                .font(.body)
                                .foregroundStyle(.secondary)
                        }
                    }
                    
                    if let developer = property.developer {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Developer")
                                .font(.headline)
                            Text(developer)
                                .font(.body)
                                .foregroundStyle(.secondary)
                        }
                    }
                    
                    Button {
                        // Contact action
                    } label: {
                        Text("Contact Developer")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(red: 0.7, green: 0.2, blue: 0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .padding(.top)
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        PropertyListView(listingType: .buySell)
            .modelContainer(for: Property.self)
    }
}
