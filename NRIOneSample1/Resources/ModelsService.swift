//
//  Service.swift
//  NRIOneSample1
//
//  Created by Akshay Yadav on 3/5/26.
//

import Foundation
import SwiftData

enum ServiceType: String, Codable, CaseIterable {
    case interiors = "Interiors"
    case insurance = "Insurance"
    case homeLoans = "Home Loans"
    case propertyManagement = "Property Management"
    case legalSupport = "Legal Support"
}

@Model
final class Service {
    var id: UUID
    var name: String
    var type: String // ServiceType raw value
    var serviceDescription: String?
    var providerName: String?
    var contactEmail: String?
    var contactPhone: String?
    var isAvailable: Bool
    
    init(
        id: UUID = UUID(),
        name: String,
        type: ServiceType,
        serviceDescription: String? = nil,
        providerName: String? = nil,
        contactEmail: String? = nil,
        contactPhone: String? = nil,
        isAvailable: Bool = true
    ) {
        self.id = id
        self.name = name
        self.type = type.rawValue
        self.serviceDescription = serviceDescription
        self.providerName = providerName
        self.contactEmail = contactEmail
        self.contactPhone = contactPhone
        self.isAvailable = isAvailable
    }
    
    var serviceTypeEnum: ServiceType {
        ServiceType(rawValue: type) ?? .interiors
    }
}
