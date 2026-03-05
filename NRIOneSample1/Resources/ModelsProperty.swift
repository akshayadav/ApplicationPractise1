//
//  Property.swift
//  NRIOneSample1
//
//  Created by Akshay Yadav on 3/5/26.
//

import Foundation
import SwiftData

@Model
final class Property {
    var id: UUID
    var title: String
    var location: String
    var city: String
    var country: String
    var price: Double
    var currency: String
    var propertyType: String // Apartment, Villa, Commercial
    var bedrooms: Int
    var bathrooms: Int
    var area: Double // in sq ft
    var imageURLs: [String]
    var propertyDescription: String?
    var developer: String?
    var isVerified: Bool
    var createdDate: Date
    
    init(
        id: UUID = UUID(),
        title: String,
        location: String,
        city: String,
        country: String,
        price: Double,
        currency: String = "USD",
        propertyType: String,
        bedrooms: Int,
        bathrooms: Int,
        area: Double,
        imageURLs: [String] = [],
        propertyDescription: String? = nil,
        developer: String? = nil,
        isVerified: Bool = false,
        createdDate: Date = Date()
    ) {
        self.id = id
        self.title = title
        self.location = location
        self.city = city
        self.country = country
        self.price = price
        self.currency = currency
        self.propertyType = propertyType
        self.bedrooms = bedrooms
        self.bathrooms = bathrooms
        self.area = area
        self.imageURLs = imageURLs
        self.propertyDescription = propertyDescription
        self.developer = developer
        self.isVerified = isVerified
        self.createdDate = createdDate
    }
}
