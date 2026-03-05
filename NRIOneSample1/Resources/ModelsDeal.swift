//
//  Deal.swift
//  NRIOneSample1
//
//  Created by Akshay Yadav on 3/5/26.
//

import Foundation
import SwiftData

enum DealCategory: String, Codable {
    case monthlyMegaDeal = "Monthly Mega Deal"
    case weeklyDeal = "Weekly Deal"
    case dealOfTheDay = "Deal of the Day"
}

@Model
final class Deal {
    var id: UUID
    var title: String
    var category: String // DealCategory raw value
    var property: Property?
    var discountPercentage: Double
    var originalPrice: Double
    var discountedPrice: Double
    var startDate: Date
    var endDate: Date
    var dealDescription: String?
    var specialFeatures: [String]
    var isActive: Bool
    
    init(
        id: UUID = UUID(),
        title: String,
        category: DealCategory,
        property: Property? = nil,
        discountPercentage: Double,
        originalPrice: Double,
        discountedPrice: Double,
        startDate: Date,
        endDate: Date,
        dealDescription: String? = nil,
        specialFeatures: [String] = [],
        isActive: Bool = true
    ) {
        self.id = id
        self.title = title
        self.category = category.rawValue
        self.property = property
        self.discountPercentage = discountPercentage
        self.originalPrice = originalPrice
        self.discountedPrice = discountedPrice
        self.startDate = startDate
        self.endDate = endDate
        self.dealDescription = dealDescription
        self.specialFeatures = specialFeatures
        self.isActive = isActive
    }
    
    var dealCategoryEnum: DealCategory {
        DealCategory(rawValue: category) ?? .dealOfTheDay
    }
}
