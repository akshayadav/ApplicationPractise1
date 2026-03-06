//
//  HomeView_Backup.swift
//  NRIOneSample1
//
//  Created by Akshay Yadav on 3/5/26.
//  This is a backup file - NOT USED

import SwiftUI
import SwiftData

// BACKUP FILE - These structs are renamed to avoid conflicts
// The actual HomeView is in ViewsHomeView.swift

struct HomeView_Backup: View {
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
                VStack(spacing: 24) {
                    // Hero Image Section with Event Toggle
                    ZStack(alignment: .bottom) {
                        // Background Image Placeholder - You can replace "heroImage" with your asset name
                        Image("heroImage")
                            .resizable()
                            .scaledToFill()
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                            .clipped()
                            .overlay {
                                // Fallback if image doesn't exist
                                Color.gray.opacity(0.3)
                                    .overlay {
                                        VStack {
                                            Image(systemName: "photo")
                                                .font(.system(size: 40))
                                                .foregroundStyle(.gray)
                                            Text("Add 'heroImage' to Assets")
                                                .font(.caption)
                                                .foregroundStyle(.gray)
                                        }
                                    }
                            }
                        
                        // Subtle overlay for better text readability
                        LinearGradient(
                            colors: [Color.clear, Color.black.opacity(0.3)],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(height: 200)
                        
                        // Event Toggle overlaid on image
                        VStack(spacing: 0) {
                            Spacer()
                            
                            HStack(spacing: 4) {
                                Button {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                        showingOngoing = true
                                    }
                                } label: {
                                    Text("ONGOING")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(showingOngoing ? .white : .primary)
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 14)
                                        .background(
                                            ZStack {
                                                if showingOngoing {
                                                    RoundedRectangle(cornerRadius: 12)
                                                        .fill(Color(red: 0.7, green: 0.2, blue: 0.2))
                                                        .shadow(color: Color(red: 0.7, green: 0.2, blue: 0.2).opacity(0.4), radius: 8, x: 0, y: 4)
                                                }
                                            }
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
                                        .foregroundStyle(!showingOngoing ? .white : .primary)
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 14)
                                        .background(
                                            ZStack {
                                                if !showingOngoing {
                                                    RoundedRectangle(cornerRadius: 12)
                                                        .fill(Color(red: 0.7, green: 0.2, blue: 0.2))
                                                        .shadow(color: Color(red: 0.7, green: 0.2, blue: 0.2).opacity(0.4), radius: 8, x: 0, y: 4)
                                                }
                                            }
                                        )
                                }
                            }
                            .padding(4)
                            .background(Color.white.opacity(0.95))
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                            .padding(.horizontal, 20)
                            .padding(.bottom, 16)
                        }
                    }
                    .frame(height: 200)
                    
                    // Events Carousel
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(filteredEvents) { event in
                                SimpleEventCardView_Backup(event: event)
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                    .padding(.top, 8)
                    
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
                            SimpleServiceTileView_Backup(
                                icon: "house.fill",
                                title: "Buy/Sell",
                                color: .blue,
                                destination: AnyView(PropertyListView(listingType: .buySell))
                            )
                            .frame(maxWidth: .infinity)
                            
                            SimpleServiceTileView_Backup(
                                icon: "calendar.badge.clock",
                                title: "Monthly Deals",
                                color: Color(red: 0.7, green: 0.2, blue: 0.2),
                                destination: AnyView(BonanzaDealsView(dealType: .monthlyMegaDeal))
                            )
                            .frame(maxWidth: .infinity)
                            
                            SimpleServiceTileView_Backup(
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
                            SimpleServiceTileView_Backup(
                                icon: "arrow.triangle.swap",
                                title: "Relocate",
                                color: .blue,
                                destination: AnyView(RelocationView())
                            )
                            .frame(maxWidth: .infinity)
                            
                            SimpleServiceTileView_Backup(
                                icon: "calendar",
                                title: "Weekly Deals",
                                color: Color(red: 0.7, green: 0.2, blue: 0.2),
                                destination: AnyView(BonanzaDealsView(dealType: .weeklyDeal))
                            )
                            .frame(maxWidth: .infinity)
                            
                            SimpleServiceTileView_Backup(
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
                            
                            SimpleServiceTileView_Backup(
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
            .navigationBarTitleDisplayMode(.inline)
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
                title: "NRI Property Expo",
                location: "Danube, Dubai",
                startDate: calendar.date(from: DateComponents(year: 2026, month: 3, day: 14))!,
                endDate: calendar.date(from: DateComponents(year: 2026, month: 3, day: 15))!,
                venueName: "Hotel Indigo",
                venueAddress: "Austin",
                isOngoing: false,
                eventDescription: "Global investment opportunities"
            )
            
            let event3 = Event(
                title: "NRI Property Expo",
                location: "Danube, Dubai",
                startDate: calendar.date(from: DateComponents(year: 2026, month: 3, day: 8))!,
                endDate: calendar.date(from: DateComponents(year: 2026, month: 3, day: 10))!,
                venueName: "The Domain Hotel",
                venueAddress: "Business Bay",
                isOngoing: true,
                eventDescription: "Exclusive property showcase for NRI investors"
            )
            
            modelContext.insert(event1)
            modelContext.insert(event2)
            modelContext.insert(event3)
        }
    }
}

struct SectionHeaderView_Backup: View {
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
struct SimpleServiceTileView_Backup: View {
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

// Simple Event Card - Cleaner Design
struct SimpleEventCardView_Backup: View {
    let event: Event
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Event Image
            ZStack {
                Rectangle()
                    .fill(Color.blue.opacity(0.7))
                    .frame(height: 180)
                
                Image(systemName: "building.2.fill")
                    .font(.system(size: 50))
                    .foregroundStyle(.white.opacity(0.5))
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
                    .background(Color(red: 0.7, green: 0.2, blue: 0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            .padding(16)
        }
        .frame(width: 300)
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.08), radius: 10, x: 0, y: 4)
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
    HomeView_Backup()
        .modelContainer(for: [Event.self, Property.self, Deal.self, Service.self])
}
