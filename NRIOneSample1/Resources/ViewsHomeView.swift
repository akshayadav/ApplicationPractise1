//
//  HomeView.swift
//  NRIOneSample1
//
//  Created by Akshay Yadav on 3/5/26.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var events: [Event]
    @State private var showingOngoing = true
    @State private var showingSearch = false
    @State private var showingMessages = false
    
    var filteredEvents: [Event] {
        events.filter { $0.isOngoing == showingOngoing }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    // Event Toggle - Compact design at top
                    HStack(spacing: 8) {
                        Button {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                showingOngoing = true
                            }
                        } label: {
                            Text("ONGOING")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundStyle(showingOngoing ? .white : Color(red: 0.3, green: 0.3, blue: 0.3))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(showingOngoing ? Color(red: 0.7, green: 0.2, blue: 0.2) : Color(.systemGray5))
                                )
                        }
                        
                        Button {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                showingOngoing = false
                            }
                        } label: {
                            Text("UPCOMING")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundStyle(!showingOngoing ? .white : Color(red: 0.3, green: 0.3, blue: 0.3))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(!showingOngoing ? Color(red: 0.7, green: 0.2, blue: 0.2) : Color(.systemGray5))
                                )
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 8)
                    
                    // Events Carousel - Shows at least 2 cards
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 12) {
                            ForEach(filteredEvents) { event in
                                SimpleEventCardView(event: event)
                                    .containerRelativeFrame(.horizontal, count: 2, spacing: 12)
                            }
                        }
                        .scrollTargetLayout()
                        .padding(.horizontal, 20)
                    }
                    .scrollTargetBehavior(.viewAligned)
                    .padding(.vertical, 8)
                    
                    // Divider
                    Divider()
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                    
                    // Three Column Layout - Simplified Design
                    VStack(spacing: 20) {
                        // Section Headers with Simple Icons
                        HStack(alignment: .center, spacing: 8) {
                            VStack(spacing: 6) {
                                Image(systemName: "house.circle.fill")
                                    .font(.title2)
                                    .foregroundStyle(.blue)
                                Text("HOME")
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.secondary)
                            }
                            .frame(maxWidth: .infinity)
                            
                            VStack(spacing: 6) {
                                Image(systemName: "star.circle.fill")
                                    .font(.title2)
                                    .foregroundStyle(Color(red: 0.7, green: 0.2, blue: 0.2))
                                Text("BONANZA DEALS")
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.secondary)
                                    .minimumScaleFactor(0.7)
                            }
                            .frame(maxWidth: .infinity)
                            
                            VStack(spacing: 6) {
                                Image(systemName: "wrench.and.screwdriver.fill")
                                    .font(.title2)
                                    .foregroundStyle(.purple)
                                Text("SERVICES")
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.secondary)
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 8)
                        
                        // First Row
                        HStack(alignment: .top, spacing: 12) {
                            SimpleServiceTileView(
                                icon: "house.fill",
                                title: "Buy/Sell",
                                color: .blue,
                                destination: AnyView(PropertyListView(listingType: .buySell))
                            )
                            .frame(maxWidth: .infinity)
                            
                            SimpleServiceTileView(
                                icon: "calendar.badge.clock",
                                title: "Monthly Deals",
                                color: Color(red: 0.7, green: 0.2, blue: 0.2),
                                destination: AnyView(BonanzaDealsView(dealType: .monthlyMegaDeal))
                            )
                            .frame(maxWidth: .infinity)
                            
                            SimpleServiceTileView(
                                icon: "sofa.fill",
                                title: "Interiors",
                                color: .purple,
                                destination: AnyView(ServiceDetailView(serviceType: .interiors))
                            )
                            .frame(maxWidth: .infinity)
                        }
                        .padding(.horizontal, 20)
                        
                        // Second Row
                        HStack(alignment: .top, spacing: 12) {
                            SimpleServiceTileView(
                                icon: "arrow.triangle.swap",
                                title: "Relocate",
                                color: .blue,
                                destination: AnyView(RelocationView())
                            )
                            .frame(maxWidth: .infinity)
                            
                            SimpleServiceTileView(
                                icon: "calendar",
                                title: "Weekly Deals",
                                color: Color(red: 0.7, green: 0.2, blue: 0.2),
                                destination: AnyView(BonanzaDealsView(dealType: .weeklyDeal))
                            )
                            .frame(maxWidth: .infinity)
                            
                            SimpleServiceTileView(
                                icon: "building.columns.fill",
                                title: "Home Loans",
                                color: .purple,
                                destination: AnyView(ServiceDetailView(serviceType: .homeLoans))
                            )
                            .frame(maxWidth: .infinity)
                        }
                        .padding(.horizontal, 20)
                        
                        // Third Row
                        HStack(alignment: .top, spacing: 12) {
                            Color.clear
                                .frame(maxWidth: .infinity)
                            
                            Color.clear
                                .frame(maxWidth: .infinity)
                            
                            SimpleServiceTileView(
                                icon: "shield.fill",
                                title: "Insurance",
                                color: .purple,
                                destination: AnyView(ServiceDetailView(serviceType: .insurance))
                            )
                            .frame(maxWidth: .infinity)
                        }
                        .padding(.horizontal, 20)
                    }
                    .padding(.bottom, 24)
                }
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("NRI ONE")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        showingSearch = true
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.primary)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingMessages = true
                    } label: {
                        Image(systemName: "message")
                            .foregroundStyle(.primary)
                    }
                }
            }
            .sheet(isPresented: $showingSearch) {
                SearchView()
            }
            .sheet(isPresented: $showingMessages) {
                MessagesView()
            }
        }
        .onAppear {
            addSampleDataIfNeeded()
        }
    }
    
    private func addSampleDataIfNeeded() {
        if events.isEmpty {
            // Add sample events
            let calendar = Calendar.current
            
            // Ongoing Events (4 events)
            let event1 = Event(
                title: "NRI Property Expo",
                location: "Danube, Dubai",
                startDate: calendar.date(from: DateComponents(year: 2026, month: 3, day: 7))!,
                endDate: calendar.date(from: DateComponents(year: 2026, month: 3, day: 8))!,
                venueName: "The Domain Hotel",
                venueAddress: "Business Bay",
                isOngoing: true,
                eventDescription: "Exclusive property showcase for NRI investors"
            )
            
            let event2 = Event(
                title: "Investment Summit",
                location: "Mumbai, India",
                startDate: calendar.date(from: DateComponents(year: 2026, month: 3, day: 5))!,
                endDate: calendar.date(from: DateComponents(year: 2026, month: 3, day: 7))!,
                venueName: "Grand Hyatt",
                venueAddress: "BKC",
                isOngoing: true,
                eventDescription: "Real estate investment opportunities"
            )
            
            let event3 = Event(
                title: "Property Fair",
                location: "Bangalore, India",
                startDate: calendar.date(from: DateComponents(year: 2026, month: 3, day: 4))!,
                endDate: calendar.date(from: DateComponents(year: 2026, month: 3, day: 6))!,
                venueName: "Convention Center",
                venueAddress: "Whitefield",
                isOngoing: true,
                eventDescription: "Tech city real estate showcase"
            )
            
            let event7 = Event(
                title: "Real Estate Festival",
                location: "Delhi, India",
                startDate: calendar.date(from: DateComponents(year: 2026, month: 3, day: 3))!,
                endDate: calendar.date(from: DateComponents(year: 2026, month: 3, day: 6))!,
                venueName: "Taj Palace",
                venueAddress: "Connaught Place",
                isOngoing: true,
                eventDescription: "Capital city property showcase"
            )
            
            // Upcoming Events (4 events)
            let event4 = Event(
                title: "NRI Property Expo",
                location: "Austin, USA",
                startDate: calendar.date(from: DateComponents(year: 2026, month: 3, day: 14))!,
                endDate: calendar.date(from: DateComponents(year: 2026, month: 3, day: 15))!,
                venueName: "Hotel Indigo",
                venueAddress: "Austin",
                isOngoing: false,
                eventDescription: "Global investment opportunities"
            )
            
            let event5 = Event(
                title: "Real Estate Expo",
                location: "London, UK",
                startDate: calendar.date(from: DateComponents(year: 2026, month: 3, day: 20))!,
                endDate: calendar.date(from: DateComponents(year: 2026, month: 3, day: 21))!,
                venueName: "Excel London",
                venueAddress: "Royal Victoria Dock",
                isOngoing: false,
                eventDescription: "European property showcase"
            )
            
            let event6 = Event(
                title: "Luxury Homes Fair",
                location: "Singapore",
                startDate: calendar.date(from: DateComponents(year: 2026, month: 3, day: 25))!,
                endDate: calendar.date(from: DateComponents(year: 2026, month: 3, day: 26))!,
                venueName: "Marina Bay Sands",
                venueAddress: "Marina Bay",
                isOngoing: false,
                eventDescription: "Premium properties in Asia"
            )
            
            let event8 = Event(
                title: "Property Investment Forum",
                location: "Toronto, Canada",
                startDate: calendar.date(from: DateComponents(year: 2026, month: 3, day: 28))!,
                endDate: calendar.date(from: DateComponents(year: 2026, month: 3, day: 29))!,
                venueName: "Fairmont Royal York",
                venueAddress: "Downtown Toronto",
                isOngoing: false,
                eventDescription: "North American real estate opportunities"
            )
            
            modelContext.insert(event1)
            modelContext.insert(event2)
            modelContext.insert(event3)
            modelContext.insert(event4)
            modelContext.insert(event5)
            modelContext.insert(event6)
            modelContext.insert(event7)
            modelContext.insert(event8)
        }
    }
}

struct SectionHeaderView: View {
    let title: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.title3)
                .fontWeight(.bold)
            Spacer()
        }
        .padding(.horizontal)
        .padding(.top, 8)
    }
}

// Simple Service Tile - No Gradients, Solid Colors
struct SimpleServiceTileView: View {
    let icon: String
    let title: String
    let color: Color
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
                    .background(color)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                
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
            .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
        }
    }
}

// Simple Event Card - Compact Design
struct SimpleEventCardView: View {
    let event: Event
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            // Event Image - More compact
            ZStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                
                // Placeholder for actual image
                Image(systemName: "building.2.fill")
                    .font(.system(size: 50))
                    .foregroundStyle(.gray.opacity(0.4))
            }
            .frame(height: 140)
            .clipShape(
                .rect(
                    topLeadingRadius: 14,
                    topTrailingRadius: 14
                )
            )
            
            VStack(alignment: .center, spacing: 8) {
                // Location - Compact
                Text(event.location)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)
                    .lineLimit(1)
                    .multilineTextAlignment(.center)
                
                // Dates - Compact
                Text(formattedDateRange)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                // Venue Name - Compact
                Text(event.venueName)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(.primary)
                    .lineLimit(1)
                
                // Venue Address - Compact
                Text(event.venueAddress)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
                
                // Register Button - More compact
                Button {
                    // Register action
                } label: {
                    Text("Register Now!")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(Color(red: 0.7, green: 0.2, blue: 0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .padding(.top, 2)
            }
            .padding(14)
        }
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .shadow(color: .black.opacity(0.06), radius: 6, x: 0, y: 2)
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
    HomeView()
        .modelContainer(for: [Event.self, Property.self, Deal.self, Service.self])
}
