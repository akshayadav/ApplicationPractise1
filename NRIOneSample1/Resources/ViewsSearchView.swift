//
//  SearchView.swift
//  NRIOneSample1
//
//  Created by Akshay Yadav on 3/5/26.
//

import SwiftUI
import SwiftData

struct SearchView: View {
    @Environment(\.dismiss) private var dismiss
    @Query private var properties: [Property]
    @Query private var deals: [Deal]
    @State private var searchText = ""
    @State private var selectedTab = 0
    
    var filteredProperties: [Property] {
        if searchText.isEmpty {
            return properties
        }
        return properties.filter {
            $0.title.localizedCaseInsensitiveContains(searchText) ||
            $0.city.localizedCaseInsensitiveContains(searchText) ||
            $0.country.localizedCaseInsensitiveContains(searchText) ||
            ($0.developer?.localizedCaseInsensitiveContains(searchText) ?? false)
        }
    }
    
    var filteredDeals: [Deal] {
        if searchText.isEmpty {
            return deals
        }
        return deals.filter {
            $0.title.localizedCaseInsensitiveContains(searchText) ||
            ($0.property?.city.localizedCaseInsensitiveContains(searchText) ?? false)
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Picker("Search Type", selection: $selectedTab) {
                    Text("Properties").tag(0)
                    Text("Deals").tag(1)
                }
                .pickerStyle(.segmented)
                .padding()
                
                if selectedTab == 0 {
                    if filteredProperties.isEmpty {
                        ContentUnavailableView(
                            "No Properties Found",
                            systemImage: "magnifyingglass",
                            description: Text("Try adjusting your search")
                        )
                    } else {
                        List(filteredProperties) { property in
                            NavigationLink {
                                PropertyDetailView(property: property)
                            } label: {
                                PropertyRowView(property: property)
                            }
                        }
                    }
                } else {
                    if filteredDeals.isEmpty {
                        ContentUnavailableView(
                            "No Deals Found",
                            systemImage: "magnifyingglass",
                            description: Text("Try adjusting your search")
                        )
                    } else {
                        List(filteredDeals) { deal in
                            DealRowView(deal: deal)
                        }
                    }
                }
            }
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText, prompt: "Search properties, deals, locations...")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct DealRowView: View {
    let deal: Deal
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(deal.title)
                    .font(.headline)
                
                Spacer()
                
                Text("\(Int(deal.discountPercentage))% OFF")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.red)
                    .clipShape(Capsule())
            }
            
            Text(deal.dealCategoryEnum.rawValue)
                .font(.caption)
                .foregroundStyle(.secondary)
            
            HStack {
                Text("$\(Int(deal.discountedPrice).formatted())")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.green)
                
                Text("$\(Int(deal.originalPrice).formatted())")
                    .font(.caption)
                    .strikethrough()
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    SearchView()
        .modelContainer(for: [Property.self, Deal.self])
}
