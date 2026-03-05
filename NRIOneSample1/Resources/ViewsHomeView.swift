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
                VStack(spacing: 20) {
                    // Event Toggle
                    HStack(spacing: 0) {
                        Button {
                            withAnimation {
                                showingOngoing = true
                            }
                        } label: {
                            Text("ONGOING")
                                .font(.headline)
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .background(showingOngoing ? Color(red: 0.7, green: 0.2, blue: 0.2) : Color.gray.opacity(0.3))
                        }
                        
                        Button {
                            withAnimation {
                                showingOngoing = false
                            }
                        } label: {
                            Text("UPCOMING")
                                .font(.headline)
                                .foregroundStyle(showingOngoing ? .gray : .white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .background(!showingOngoing ? Color(red: 0.7, green: 0.2, blue: 0.2) : Color.gray.opacity(0.3))
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding(.horizontal)
                    
                    // Events Carousel
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(filteredEvents) { event in
                                EventCardView(event: event)
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    // HOME Section
                    SectionHeaderView(title: "HOME")
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ServiceTileView(
                            icon: "house.fill",
                            title: "Buy/Sell",
                            destination: AnyView(PropertyListView(listingType: .buySell))
                        )
                        
                        ServiceTileView(
                            icon: "house.fill",
                            title: "Relocate",
                            destination: AnyView(RelocationView())
                        )
                    }
                    .padding(.horizontal)
                    
                    // BONANZA DEALS Section
                    SectionHeaderView(title: "BONANZA DEALS")
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ServiceTileView(
                            icon: "calendar.badge.clock",
                            title: "Monthly Deals",
                            destination: AnyView(BonanzaDealsView(dealType: .monthlyMegaDeal))
                        )
                        
                        ServiceTileView(
                            icon: "calendar",
                            title: "Weekly Deals",
                            destination: AnyView(BonanzaDealsView(dealType: .weeklyDeal))
                        )
                    }
                    .padding(.horizontal)
                    
                    // SERVICES Section
                    SectionHeaderView(title: "SERVICES")
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ServiceTileView(
                            icon: "sofa.fill",
                            title: "Interiors",
                            destination: AnyView(ServiceDetailView(serviceType: .interiors))
                        )
                        
                        ServiceTileView(
                            icon: "building.columns.fill",
                            title: "Home Loans",
                            destination: AnyView(ServiceDetailView(serviceType: .homeLoans))
                        )
                    }
                    .padding(.horizontal)
                    
                    // Additional Services Row
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ServiceTileView(
                            icon: "dollarsign.circle.fill",
                            title: "Relocate",
                            destination: AnyView(RelocationView())
                        )
                        
                        ServiceTileView(
                            icon: "shield.fill",
                            title: "Insurance",
                            destination: AnyView(ServiceDetailView(serviceType: .insurance))
                        )
                        
                        ServiceTileView(
                            icon: "building.columns.fill",
                            title: "Home Loans",
                            destination: AnyView(ServiceDetailView(serviceType: .homeLoans))
                        )
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                }
            }
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
            
            modelContext.insert(event1)
            modelContext.insert(event2)
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

#Preview {
    HomeView()
        .modelContainer(for: [Event.self, Property.self, Deal.self, Service.self])
}
