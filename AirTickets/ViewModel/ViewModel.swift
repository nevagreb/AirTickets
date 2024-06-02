//
//  ViewModel.swift
//  AirTickets
//
//  Created by Kristina Grebneva on 29.05.2024.
//


import Foundation
import Combine

class OffersViewModel: ObservableObject {
    @Published var offers: [Offer] = []
    
    init() {}
    
    func loadData() async {
        guard let url = URL(string: "https://run.mocky.io/v3/214a1713-bac0-4853-907c-a1dfc3cd05fd") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode(OffersResponse.self, from: data)
            DispatchQueue.main.async {
                self.offers = decodedResponse.offers
            }
        } catch {
            print("Invalid data: \(error)")
        }
    }
}

class TicketOffersViewModel: ObservableObject {
    @Published var offers: [TicketsOffer] = []
    
    init() {}
    
    func loadData() async {
        guard let url = URL(string: "https://run.mocky.io/v3/7e55bf02-89ff-4847-9eb7-7d83ef884017") else {
            print("Invalid URL")
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode(TicketOffersResponse.self, from: data)
            DispatchQueue.main.async {
                self.offers = decodedResponse.ticketsOffers
            }
        } catch {
            print("Invalid data: \(error)")
        }
    }
}

class TicketsViewModel: ObservableObject {
    @Published var tickets: [Ticket] = []
    
    init() {}
    
    func loadData() async {
        guard let url = URL(string: "https://run.mocky.io/v3/670c3d56-7f03-4237-9e34-d437a9e56ebf") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode(TicketsResponse.self, from: data)
            DispatchQueue.main.async {
                self.tickets = decodedResponse.tickets
            }
        } catch {
            print("Invalid data: \(error)")
        }
    }
}
