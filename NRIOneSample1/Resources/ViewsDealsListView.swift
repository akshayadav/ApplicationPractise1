//
//  DealsListView.swift
//  NRIOneSample1
//
//  Created by Akshay Yadav on 3/5/26.
//

import SwiftUI
import SwiftData

struct DealsListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Deal.startDate, order: .reverse) private var deals: [Deal]
    @State private var selectedCategory: DealCategory?
    
    var filteredDeals: [Deal] {
        if let category = selectedCategory {
            return deals.filter { $0.dealCategoryEnum == category }
        }
        return deals
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        FilterChip(
                            title: "All",
                            isSelected: selectedCategory == nil,
                            action: { selectedCategory = nil }
                        )
                        
                        ForEach([DealCategory.monthlyMegaDeal, .weeklyDeal, .dealOfTheDay], id: \.self) { category in
                            FilterChip(
                                title: category.rawValue,
                                isSelected: selectedCategory == category,
                                action: { selectedCategory = category }
                            )
                        }
                    }
                    .padding()
                }
                
                if filteredDeals.isEmpty {
                    ContentUnavailableView(
                        "No Deals Available",
                        systemImage: "star.fill",
                        description: Text("Check back soon for exclusive deals")
                    )
                } else {
                    List(filteredDeals) { deal in
                        NavigationLink {
                            DealDetailView(deal: deal)
                        } label: {
                            DealCardRow(deal: deal)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("All Deals")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        addSampleDeal()
                    } label: {
                        Label("Add Deal", systemImage: "plus")
                    }
                }
            }
        }
    }
    
    private func addSampleDeal() {
        let deal = Deal(
            title: "Luxury Villa - Early Bird Offer",
            category: .monthlyMegaDeal,
            discountPercentage: 15,
            originalPrice: 2500000,
            discountedPrice: 2125000,
            startDate: Date(),
            endDate: Calendar.current.date(byAdding: .day, value: 30, to: Date())!,
            dealDescription: "Exclusive launch offer for NRI investors. Limited units available.",
            specialFeatures: ["Priority Allocation", "Flexible Payment Plan", "Free Interior Consultation"]
        )
        modelContext.insert(deal)
    }
}

struct FilterChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .fontWeight(isSelected ? .semibold : .regular)
                .foregroundStyle(isSelected ? .white : .primary)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color(red: 0.7, green: 0.2, blue: 0.2) : Color.gray.opacity(0.2))
                .clipShape(Capsule())
        }
    }
}

struct DealCardRow: View {
    let deal: Deal
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(deal.title)
                        .font(.headline)
                    
                    Text(deal.dealCategoryEnum.rawValue)
                        .font(.caption)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color(red: 0.7, green: 0.2, blue: 0.2))
                        .clipShape(Capsule())
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text("\(Int(deal.discountPercentage))%")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(.red)
                    Text("OFF")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(.red)
                }
            }
            
            HStack(alignment: .firstTextBaseline, spacing: 8) {
                Text("$\(Int(deal.discountedPrice).formatted())")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(.green)
                
                Text("$\(Int(deal.originalPrice).formatted())")
                    .font(.subheadline)
                    .strikethrough()
                    .foregroundStyle(.secondary)
            }
            
            if !deal.specialFeatures.isEmpty {
                HStack(spacing: 8) {
                    ForEach(deal.specialFeatures.prefix(2), id: \.self) { feature in
                        Text(feature)
                            .font(.caption)
                            .foregroundStyle(.blue)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.blue.opacity(0.1))
                            .clipShape(Capsule())
                    }
                }
            }
            
            HStack {
                Image(systemName: "clock.fill")
                    .font(.caption)
                Text("Ends \(deal.endDate, style: .relative)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 8)
    }
}

struct DealDetailView: View {
    let deal: Deal
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Deal Banner
                ZStack {
                    Rectangle()
                        .fill(LinearGradient(
                            colors: [Color(red: 0.7, green: 0.2, blue: 0.2), Color(red: 0.5, green: 0.1, blue: 0.1)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                        .frame(height: 200)
                    
                    VStack(spacing: 12) {
                        Text("\(Int(deal.discountPercentage))% OFF")
                            .font(.system(size: 50, weight: .bold))
                            .foregroundStyle(.white)
                        
                        Text(deal.dealCategoryEnum.rawValue)
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                    }
                }
                
                VStack(alignment: .leading, spacing: 16) {
                    Text(deal.title)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    HStack(alignment: .firstTextBaseline) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Special Price")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            Text("$\(Int(deal.discountedPrice).formatted())")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(.green)
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .trailing, spacing: 4) {
                            Text("Original Price")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            Text("$\(Int(deal.originalPrice).formatted())")
                                .font(.title3)
                                .strikethrough()
                                .foregroundStyle(.secondary)
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    Divider()
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Deal Expires")
                            .font(.headline)
                        
                        HStack {
                            Image(systemName: "clock.fill")
                                .foregroundStyle(.red)
                            Text(deal.endDate, style: .date)
                                .fontWeight(.semibold)
                            Text("•")
                            Text(deal.endDate, style: .relative)
                                .foregroundStyle(.secondary)
                        }
                    }
                    
                    if let description = deal.dealDescription {
                        Divider()
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("About This Deal")
                                .font(.headline)
                            Text(description)
                                .font(.body)
                                .foregroundStyle(.secondary)
                        }
                    }
                    
                    if !deal.specialFeatures.isEmpty {
                        Divider()
                        
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Special Features")
                                .font(.headline)
                            
                            ForEach(deal.specialFeatures, id: \.self) { feature in
                                HStack(spacing: 12) {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundStyle(.green)
                                    Text(feature)
                                        .font(.body)
                                }
                            }
                        }
                    }
                    
                    Button {
                        // Claim deal action
                    } label: {
                        Text("Claim This Deal")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(red: 0.7, green: 0.2, blue: 0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
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
        DealsListView()
            .modelContainer(for: Deal.self)
    }
}
