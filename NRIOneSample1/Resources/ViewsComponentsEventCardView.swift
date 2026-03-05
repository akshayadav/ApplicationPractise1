//
//  EventCardView.swift
//  NRIOneSample1
//
//  Created by Akshay Yadav on 3/5/26.
//

import SwiftUI

struct EventCardView: View {
    let event: Event
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Event Image
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 180)
                
                Image(systemName: "building.2.fill")
                    .font(.system(size: 60))
                    .foregroundStyle(.gray.opacity(0.5))
            }
            
            VStack(alignment: .leading, spacing: 8) {
                // Location
                Text(event.location)
                    .font(.title2)
                    .fontWeight(.bold)
                
                // Dates
                Text(formattedDateRange)
                    .font(.body)
                    .foregroundStyle(.secondary)
                
                // Venue
                Text(event.venueName)
                    .font(.body)
                    .fontWeight(.medium)
                
                Text(event.venueAddress)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                // Register Button
                Button {
                    // Register action
                } label: {
                    Text("Register Now!")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(Color(red: 0.7, green: 0.2, blue: 0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
            .padding(.horizontal, 12)
            .padding(.bottom, 12)
        }
        .frame(width: 280)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
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
    EventCardView(event: Event(
        title: "NRI Property Expo",
        location: "Danube, Dubai",
        startDate: Date(),
        endDate: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
        venueName: "The Domain Hotel",
        venueAddress: "Business Bay"
    ))
    .padding()
}
