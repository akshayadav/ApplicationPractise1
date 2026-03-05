//
//  ContentView.swift
//  NRIOneSample1
//
//  Created by Akshay Yadav on 3/5/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(0)
            
            BonanzaDealsView(dealType: .monthlyMegaDeal)
                .tabItem {
                    Label("BD", systemImage: "calendar.badge.clock")
                }
                .tag(1)
            
            BonanzaDealsView(dealType: .weeklyDeal)
                .tabItem {
                    Label("WD", systemImage: "calendar")
                }
                .tag(2)
            
            BonanzaDealsView(dealType: .dealOfTheDay)
                .tabItem {
                    Label("Monthly", systemImage: "square.grid.2x2")
                }
                .tag(3)
            
            DealsListView()
                .tabItem {
                    Label("Deal", systemImage: "star.fill")
                }
                .tag(4)
        }
        .tint(Color(red: 0.7, green: 0.2, blue: 0.2))
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Event.self, Property.self, Deal.self, Service.self])
}
