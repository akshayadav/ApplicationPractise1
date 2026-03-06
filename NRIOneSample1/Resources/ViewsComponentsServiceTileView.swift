//
//  ServiceTileView.swift
//  NRIOneSample1
//
//  Created by Akshay Yadav on 3/5/26.
//

import SwiftUI

struct ServiceTileView: View {
    let icon: String
    let title: String
    let destination: AnyView
    
    var body: some View {
        NavigationLink {
            destination
        } label: {
            VStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 40))
                    .foregroundStyle(Color(red: 0.2, green: 0.4, blue: 0.6))
                
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(.primary)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 120)
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(color: .black.opacity(0.08), radius: 4, x: 0, y: 2)
        }
    }
}

// Modern Service Tile with Gradients
struct ModernServiceTileView: View {
    let icon: String
    let title: String
    let gradient: [Color]
    let destination: AnyView
    
    var body: some View {
        NavigationLink {
            destination
        } label: {
            VStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 32))
                    .foregroundStyle(.white)
                    .frame(width: 56, height: 56)
                    .background(
                        LinearGradient(
                            colors: gradient,
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    .shadow(color: gradient.first?.opacity(0.3) ?? .clear, radius: 8, x: 0, y: 4)
                
                Text(title)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(.primary)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .minimumScaleFactor(0.8)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .padding(.horizontal, 8)
            .background(Color(.secondarySystemGroupedBackground))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
        }
    }
}

// Modern Event Card with Better Design
struct ModernEventCardView: View {
    let event: Event
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Event Image with Gradient Overlay
            ZStack(alignment: .bottom) {
                Rectangle()
                    .fill(
                        LinearGradient(
                            colors: [Color.blue.opacity(0.6), Color.purple.opacity(0.8)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(height: 180)
                
                Image(systemName: "building.2.fill")
                    .font(.system(size: 50))
                    .foregroundStyle(.white.opacity(0.3))
            }
            .clipShape(
                .rect(
                    topLeadingRadius: 20,
                    topTrailingRadius: 20
                )
            )
            
            VStack(alignment: .leading, spacing: 12) {
                // Location
                Text(event.location)
                    .font(.title3)
                    .fontWeight(.bold)
                
                // Dates
                HStack {
                    Image(systemName: "calendar")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(formattedDateRange)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                
                // Venue
                VStack(alignment: .leading, spacing: 4) {
                    Text(event.venueName)
                        .font(.body)
                        .fontWeight(.medium)
                    
                    HStack {
                        Image(systemName: "mappin.circle.fill")
                            .font(.caption)
                            .foregroundStyle(.blue)
                        Text(event.venueAddress)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                
                // Register Button
                Button {
                    // Register action
                } label: {
                    HStack {
                        Text("Register Now!")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                    }
                    .font(.subheadline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(
                        LinearGradient(
                            colors: [Color(red: 0.8, green: 0.3, blue: 0.3), Color(red: 0.6, green: 0.15, blue: 0.15)],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            .padding(16)
        }
        .frame(width: 300)
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.1), radius: 12, x: 0, y: 6)
    }
    
    private var formattedDateRange: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d"
        
        let startStr = formatter.string(from: event.startDate)
        
        let calendar = Calendar.current
        let startDay = calendar.component(.day, from: event.startDate)
        let endDay = calendar.component(.day, from: event.endDate)
        
        return "\(startStr) – \(endDay)"
    }
}

#Preview {
    ServiceTileView(
        icon: "house.fill",
        title: "Buy/Sell",
        destination: AnyView(Text("Buy/Sell View"))
    )
    .padding()
}
