//
//  CountrySelectedSearchView.swift
//  AirTickets
//
//  Created by Kristina Grebneva on 31.05.2024.
//

import SwiftUI

struct CountrySelectedSearchView: View {
    @StateObject var ticketOffers = TicketOffersViewModel()
    @EnvironmentObject var router: NavigationRouter
    
    @Binding var departure: String
    @Binding var arrival: String
    
    @State var departureDate: Date = .now
    @State var returnDate: Date?
    @State private var showDataPickerForDeparture: Bool = false
    @State private var showDataPickerForReturn: Bool = false
    
    @State private var isSubscribed: Bool = false
    
    var body: some View {
        VStack {
            searchBar
            buttons
            flightsList
            allFlightsButton
            subscriptionButton
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            Task {
                await ticketOffers.loadData()
            }
        }
    }
    
    //MARK: - Search bar
    var searchBar: some View {
        SearchBar(
            barButtonName: "arrow",
            barButtonAction: { router.navigateBack() },
            departure: $departure,
            departureButtonAction: { String.swap(&departure, &arrival) },
            arrival: $arrival,
            arrivalButtonAction: { arrival = "" })
    }
    
    //MARK: - Buttons
    var buttons: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                returnDateButton
                departureDateButton
                passengerNumberButton
                filterButton
            }
            .buttonStyle(greyButton())
        }
        .padding(.horizontal)
    }
    
    struct greyButton: ButtonStyle {
        func makeBody(configuration: Self.Configuration) -> some View {
            configuration.label
                .padding(8)
                .background(Capsule().fill(Colors.grey3))
                .font(Font.DesignSystem.title4)
                .foregroundColor(Colors.white)
        }
    }
    
    var filterButton: some View {
        Button(action: {}, label: {
            HStack {
                Image("filter")
                    .resizable()
                    .frame(width: 16, height: 16)
                Text("фильтры")
            }
        })
    }
    
    var passengerNumberButton: some View {
        Button(action: {}, label: {
            HStack {
                Image("human")
                    .resizable()
                    .frame(width: 16, height: 16)
                Text("1,эконом")
            }
        })
    }
    
    var returnDateButton: some View {
        Button(action: {
            showDataPickerForReturn.toggle()
        }, label: {
            if let date = returnDate {
                formattedDateText(from: date)
            } else {
                HStack {
                    Image("plus")
                    Text("обратно")
                }
            }
        })
        .sheet(isPresented: $showDataPickerForReturn) {
            DatePickerView(date: Binding(
                get: { returnDate ?? .now },
                set: { returnDate = $0 }))
        }
    }
    
    var departureDateButton: some View {
        Button(action: {
            showDataPickerForDeparture.toggle()
        }, label: {
            formattedDateText(from: departureDate)
        })
        .sheet(isPresented: $showDataPickerForDeparture) {
            DatePickerView(date: $departureDate)
        }
    }
    
    func formattedDateText(from date: Date) -> some View {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "d MMM, E" // format: 24 mon, wd
        let dateString = dateFormatter.string(from: date).lowercased()
        let components = dateString.split(separator: ",") //this is needed to color the second part of the date
        guard components.count == 2 else {
            return Text(dateString)
        }
        return Text(components[0]) + Text(", " + components[1]).foregroundColor(Colors.grey6)
    }
    
    enum CurrentDate {
        case departureDate
        case returnDate
    }
    
    //MARK: - List
    var flightsList: some View {
        let colorArray: [Color] = [Colors.red, Colors.blue, Colors.white]
        
        return List {
                Text("Прямые рельсы")
                    .font(Font.DesignSystem.title2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ForEach(ticketOffers.offers.indices, id: \.self) {index in
                    HStack {
                        colorArray[index]
                            .clipShape(Circle())
                            .frame(width: 24)
                        FlightItem(offer: ticketOffers.offers[index])
                    }
                }
        }
        .listRowBackground(Colors.grey2)
        .listRowSeparatorTint(Colors.grey5)
    }
    
    struct FlightItem: View {
        let offer: TicketsOffer
        
        var body: some View {
            VStack(alignment: .center) {
                HStack {
                    Text(offer.title)
                        .italic()
                    Spacer()
                    Text("\(offer.price.value.asCurrency()) ₽ >")
                        .foregroundStyle(Colors.blue)
                }
                .font(Font.DesignSystem.title4)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    Text(offer.timeRange.joined(separator: " "))
                        .font(Font.DesignSystem.text2)
                        .lineLimit(1)
                        .truncationMode(.tail)
                }
            }
        }
    }
    
    //MARK: - allFlightsButton
    var allFlightsButton: some View {
        Button {
            router.navigate(to: .allTickets(for: ChosenData(departure: departure, arrival: arrival, date: departureDate)))
        } label: {
            Text("Посмотреть все билеты")
                .font(Font.DesignSystem.buttonText1)
                .italic()
                .foregroundStyle(Colors.white)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Colors.blue)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding()
    }
    
    //MARK: - subscriptionButton
    var subscriptionButton: some View {
        HStack {
            Image("bell")
                .foregroundColor(Colors.blue)
            Text("Подписка на цену")
                .font(Font.DesignSystem.buttonText1)
                .foregroundStyle(Colors.white)
            Toggle("", isOn: $isSubscribed)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Colors.grey2)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding()
    }
}

extension String {
    static func swap(_ a: inout String, _ b: inout String) {
        let temp = a
        a = b
        b = temp
    }
}

//#Preview {
//    var departure = "Moscow"
//    var arrival = "Sochi"
//    
//    return NavigationStack {
//        CountrySelectedSearchView(departure: Binding(get: {departure}, set: {departure = $0}), arrival: Binding(get: {arrival}, set: {arrival = $0}))
//            .preferredColorScheme(.dark)
//    }
//}
