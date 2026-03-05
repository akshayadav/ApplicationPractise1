//
//  Event.swift
//  NRIOneSample1
//
//  Created by Akshay Yadav on 3/5/26.
//

import Foundation
import SwiftData

@Model
final class Event {
    var id: UUID
    var title: String
    var location: String
    var startDate: Date
    var endDate: Date
    var venueName: String
    var venueAddress: String
    var imageURL: String?
    var isOngoing: Bool
    var eventDescription: String?
    
    init(
        id: UUID = UUID(),
        title: String,
        location: String,
        startDate: Date,
        endDate: Date,
        venueName: String,
        venueAddress: String,
        imageURL: String? = nil,
        isOngoing: Bool = true,
        eventDescription: String? = nil
    ) {
        self.id = id
        self.title = title
        self.location = location
        self.startDate = startDate
        self.endDate = endDate
        self.venueName = venueName
        self.venueAddress = venueAddress
        self.imageURL = imageURL
        self.isOngoing = isOngoing
        self.eventDescription = eventDescription
    }
}
