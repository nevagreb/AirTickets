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
    var timeRange: [String]
    var price: Price
    
    enum CodingKeys: String, CodingKey {
        case id, title, price
        case timeRange = "time_range"
    }
}

struct TicketOffersResponse: Codable {
    var ticketsOffers: [TicketsOffer]
    
    enum CodingKeys: String, CodingKey {
        case ticketsOffers = "tickets_offers"
    }
}
