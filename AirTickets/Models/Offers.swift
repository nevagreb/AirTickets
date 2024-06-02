//
//  Offers.swift
//  AirTickets
//
//  Created by Kristina Grebneva on 29.05.2024.
//

import Foundation

struct Price: Codable {
    var value: Int
}

struct Offer: Identifiable, Codable {
    var id: Int
    var title: String
    var town: String
    var price: Price
}

struct OffersResponse: Codable {
    var offers: [Offer]
}
