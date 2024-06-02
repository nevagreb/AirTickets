//
//  Tickets.swift
//  AirTickets
//
//  Created by Kristina Grebneva on 31.05.2024.
//

import Foundation

struct Ticket: Codable, Identifiable {
    var id: Int
    var badge: String?
    var price: Price
    var providerName: String?
    var company: String?
    var departure: Destination
    var arrival: Destination
    var hasTransfer: Bool?
    var hasVisaTransfer: Bool?
    var luggage: Luggage?
    var handLuggage: HandLuggage?
    var isReturnable: Bool?
    var isExchangable: Bool?
    
    struct Destination: Codable {
        var town: String
        var oldDate: String
        var airport: String
        
        var date: Date? {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            return dateFormatter.date(from: oldDate)
        }
        
        enum CodingKeys: String, CodingKey {
            case town, airport
            case oldDate = "date"
        }
    }
    
    struct Luggage: Codable {
        var hasLuggage: Bool?
        var price: Price?
        
        enum CodingKeys: String, CodingKey {
            case price
            case hasLuggage = "has_luggage"
        }
    }
    
    struct HandLuggage: Codable {
        var hasHandLuggage: Bool?
        var size: String?
        
        enum CodingKeys: String, CodingKey {
            case size
            case hasHandLuggage = "has_hand_luggage"
        }
    }
    
    var duration: Double? {
        if let departureDate = departure.date, let arrivalDate = arrival.date {
            return arrivalDate.timeIntervalSince(departureDate)
        }
        return nil
    }
    
    enum CodingKeys: String, CodingKey {
        case id, badge, price, company, departure, arrival, luggage
        case providerName = "provider_name"
        case hasTransfer = "has_transfer"
        case hasVisaTransfer = "has_visa_transfer"
        case handLuggage = "hand_luggage"
        case isReturnable = "is_returnable"
        case isExchangable = "is_exchangable"
    }
}

struct TicketsResponse: Codable {
    var tickets: [Ticket]
}

struct ChosenData: Codable, Hashable, Equatable {
    var departure: String
    var arrival: String
    var date: Date
}
