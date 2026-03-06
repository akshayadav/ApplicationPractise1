//
//  BonanzaDealsView.swift
//  NRIOneSample1
//
//  Created by Akshay Yadav on 3/5/26.
//

import SwiftUI
import SwiftData

struct BonanzaDealsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var deals: [Deal]
    let dealType: DealCategory
    
    var filteredDeals: [Deal] {
        deals.filter { $0.category == dealType.rawValue && $0.isActive }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    if filteredDeals.isEmpty {
                        ContentUnavailableView(
                            "No Deals Available",
                            systemImage: "tag.slash",
                            description: Text("Check back later for exciting deals!")
                        )
                    } else {
                        // Carousel showing at least 2 cards
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 16) {
                                ForEach(filteredDeals) { deal in
                                    DealCardView(deal: deal)
                                        .containerRelativeFrame(.horizontal, count: 2, spacing: 16)
                                }
                            }
                            .scrollTargetLayout()
                            .padding(.horizontal, 20)
                        }
                        .scrollTargetBehavior(.viewAligned)
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle(dealType.rawValue)
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        addSampleDeal()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .onAppear {
            addSampleDealsIfNeeded()
        }
    }
    
    private func addSampleDealsIfNeeded() {
        if deals.isEmpty {
            // Add multiple sample deals for better carousel demonstration
            addSampleDeal()
            
            // Add additional deals
            let deal2 = Deal(
                title: "\(dealType.rawValue) - Modern Villa",
                category: dealType,
                discountPercentage: 20,
                originalPrice: 750000,
                discountedPrice: 600000,
                startDate: Date(),
                endDate: Calendar.current.date(byAdding: .day, value: 25, to: Date())!,
                dealDescription: "Stunning villa with pool and garden. Perfect for families looking for luxury living.",
                specialFeatures: ["Pool", "Garden", "Smart Home", "Gated Community"]
            )
            
            let deal3 = Deal(
                title: "\(dealType.rawValue) - Penthouse Suite",
                category: dealType,
                discountPercentage: 18,
                originalPrice: 1200000,
                discountedPrice: 984000,
                startDate: Date(),
                endDate: Calendar.current.date(byAdding: .day, value: 20, to: Date())!,
                dealDescription: "Exclusive penthouse with panoramic city views. Luxurious finishes throughout.",
                specialFeatures: ["Panoramic Views", "Premium Finishes", "Private Elevator"]
            )
            
            modelContext.insert(deal2)
            modelContext.insert(deal3)
        }
    }
    
    private func addSampleDeal() {
        let deal = Deal(
            title: "\(dealType.rawValue) - Luxury Apartment",
            category: dealType,
            discountPercentage: 15,
            originalPrice: 500000,
            discountedPrice: 425000,
            startDate: Date(),
            endDate: Calendar.current.date(byAdding: .day, value: 30, to: Date())!,
            dealDescription: "Exclusive discount on premium properties. Limited time offer for NRI investors.",
            specialFeatures: ["Prime Location", "NRI Friendly Payment Plan", "Verified Developer"]
        )
        
        modelContext.insert(deal)
    }
}

struct DealCardView: View {
    let deal: Deal
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Deal Badge
            HStack {
                Text(deal.category)
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color(red: 0.7, green: 0.2, blue: 0.2))
                    .clipShape(Capsule())
                
                Spacer()
                
                Text("\(Int(deal.discountPercentage))% OFF")
                    .font(.headline)
                    .foregroundStyle(Color(red: 0.7, green: 0.2, blue: 0.2))
            }
            
            // Deal Image
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 200)
                
                Image(systemName: "building.2.fill")
                    .font(.system(size: 60))
                    .foregroundStyle(.gray.opacity(0.5))
            }
            
            // Deal Title
            Text(deal.title)
                .font(.title3)
                .fontWeight(.bold)
            
            // Price
            HStack(alignment: .firstTextBaseline, spacing: 8) {
                Text("$\(Int(deal.discountedPrice).formatted())")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(red: 0.7, green: 0.2, blue: 0.2))
                
                Text("$\(Int(deal.originalPrice).formatted())")
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .strikethrough()
            }
            
            // Description
            if let description = deal.dealDescription {
                Text(description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
            
            // Special Features
            if !deal.specialFeatures.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(deal.specialFeatures, id: \.self) { feature in
                            Text(feature)
                                .font(.caption)
                                .foregroundStyle(.blue)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 4)
                                .background(Color.blue.opacity(0.1))
                                .clipShape(Capsule())
                        }
                    }
                }
            }
            
            // Time Remaining
            HStack {
                Image(systemName: "clock.fill")
                    .foregroundStyle(.orange)
                Text("Ends \(formattedEndDate)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            // CTA Button
            Button {
                // View deal details
            } label: {
                Text("View Details")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(Color(red: 0.7, green: 0.2, blue: 0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
    }
    
    private var formattedEndDate: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: deal.endDate, relativeTo: Date())
    }
}

#Preview {
    BonanzaDealsView(dealType: .monthlyMegaDeal)
        .modelContainer(for: [Deal.self, Property.self])
}
