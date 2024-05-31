//
//  TicketsOffers.swift
//  AirTickets
//
//  Created by Kristina Grebneva on 30.05.2024.
//

import Foundation

struct TicketsOffer: Codable, Identifiable {
    var id: Int
    var title: String
    private var time_range: [String]
    
    var timeRange: [String] {
        get { time_range }
        set { time_range = newValue }
    }
    
    var price: Price
    
    struct Price: Codable {
        var value: Int
    }
}

struct TicketOffersResponse: Codable {
    private var tickets_offers: [TicketsOffer]
    
    var ticketOffer: [TicketsOffer] {
        get { tickets_offers }
        set { tickets_offers = newValue }
    }
}
