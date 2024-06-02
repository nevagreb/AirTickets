//
//  AllTicketsView.swift
//  AirTickets
//
//  Created by Kristina Grebneva on 31.05.2024.
//

import SwiftUI

struct AllTicketsView: View {
    @ObservedObject var viewModel = TicketsViewModel()
    
    let departure: String
    let arrival: String
    let date: Date
    
    var body: some View {
        destination
            .onAppear {
                Task {
                    await viewModel.loadData()
                }
            }
    }
    
    var destination: some View {
        VStack {
            Text("\(departure)"-"\(arrival)")
            
        }
    }
    
}

#Preview {
    let departure = "Moscow"
    let arrival = "Sochi"
    let date: Date = .now
    return AllTicketsView(departure: departure, arrival: arrival, date: date)
        .preferredColorScheme(.dark)
}
