//
//  AllTicketsView.swift
//  AirTickets
//
//  Created by Kristina Grebneva on 31.05.2024.
//

import SwiftUI

struct AllTicketsView: View {
    @ObservedObject var viewModel = TicketsViewModel()
    @EnvironmentObject var router: NavigationRouter

    let departure: String
    let arrival: String
    let date: Date
    
    var body: some View {
        ZStack {
            VStack {
                destination
                    .padding(.bottom)
                ticketsList
            }
            .padding()
            buttons
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            Task {
                await viewModel.loadData()
            }
        }
    }
    
    //MARK: - destination
    var destination: some View {
        HStack {
            Button {
                router.navigateBack()
            } label: {
                Image("arrow")
            }
            destinationText
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Colors.grey2)
    }
    
    var destinationText: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("\(departure)-\(arrival)")
                .font(Font.DesignSystem.title3)
            Text("\(formatted(date)), 1 пассажир")
                .font(Font.DesignSystem.title4)
                .foregroundStyle(Colors.grey6)
        }
    }
    
    func formatted(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        return dateFormatter.string(from: date).lowercased()
    }

    //MARK: - buttons
    
    var buttons: some View {
        HStack {
            Button(action: {}, label: {
                HStack {
                    Image("filter")
                    Text("Фильтр")
                }
            })
            
            Button(action: {}, label: {
                HStack {
                    Image("graph")
                    Text("График цен")
                }
            }).padding(.leading)
        }
        .padding()
        .modifier(BlueShapeModifier())
        .frame(maxHeight: .infinity, alignment: .bottom)
    }
    
    struct BlueShapeModifier: ViewModifier {
        func body(content: Content) -> some View {
            content
                .font(Font.DesignSystem.title4)
                .foregroundStyle(Colors.white)
                .padding(5)
                .background(Colors.blue)
                .clipShape(Capsule())
        }
    }
    
    //MARK: - ticketsList
    var ticketsList: some View {
        ScrollView {
            ForEach(viewModel.tickets) {ticket in
                ZStack(alignment: .topLeading) {
                    TicketItem(ticket: ticket)
                        .padding(.top)
                    
                    Text(ticket.badge ?? "")
                        .modifier(BlueShapeModifier())
                        .opacity(ticket.badge == nil ? 0 : 1)
                }
            }
        }
    }
    
    struct TicketItem: View {
        var ticket: Ticket
        @State var departureDate: Date?
        var arrivalDate: Date?
        
        var body: some View {
            VStack(alignment: .leading) {
                Text("\(ticket.price.value) ₽")
                    .font(Font.DesignSystem.title1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                ticketDetailes
            }
            .foregroundColor(Colors.white)
            .padding()
            .background(Colors.grey2)
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        
        var ticketDetailes: some View {
            HStack(alignment: .top) {
                airLineSign
                timeAndAiport(of: ticket.departure)
                Text("-")
                timeAndAiport(of: ticket.arrival)
                Text("\(formatted(ticket.duration))ч в пути")
                Text((ticket.hasTransfer ?? true) ? "" : "/ Без пересадок")
            }
            .font(Font.DesignSystem.text2)
        }
        
        var airLineSign: some View {
            Colors.red
                .clipShape(Circle())
                .frame(width: 24)
        }
        
        func timeAndAiport(of destination: Ticket.Destination) -> some View {
            VStack {
                Text(destination.date?.formatted(date: .omitted, time: .shortened) ?? "")
                Text(destination.airport)
                    .foregroundStyle(Colors.grey6)
            }
            .font(Font.DesignSystem.title4)
        }
        
        func formatted(_ duration: TimeInterval?) -> String {
            if let duration = duration {
                let durationInHours = duration/3600
                let roundedDuration = round(durationInHours*2)/2 //rounded rule
                return String(format: "%g", roundedDuration)
            }
            return ""
        }
    }
}

//#Preview {
//    let departure = "Moscow"
//    let arrival = "Sochi"
//    let date: Date = .now
//    return NavigationStack {
//        AllTicketsView(departure: departure, arrival: arrival, date: date)
//            .preferredColorScheme(.dark)
//    }
//}
