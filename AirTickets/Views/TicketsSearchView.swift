//
//  TicketsSearchView.swift
//  AirTickets
//
//  Created by Kristina Grebneva on 29.05.2024.
//

import SwiftUI

let USER_DEFAULS_KEY = "destination"

struct TicketsSearchView: View {
    @StateObject var viewModel = OffersViewModel()
    @StateObject var router = NavigationRouter()
    
    @State private var departure: String = UserDefaults.standard.string(forKey: USER_DEFAULS_KEY) ?? ""
    @State private var arrival: String = ""
    
    @State private var showSheet: Bool = false
    @State private var arrivalIsChosen: Bool = false
    
    var body: some View {
        NavigationStack(path: $router.path) {
            VStack {
                searchHeader
                searchBar
                offersHeader
                scrollOffers
                Spacer()
            }
            .sheet(isPresented: $showSheet)  {
                DetailedTicketSearchView(departure: $departure, arrival: $arrival, arrivalIsChosen: $arrivalIsChosen)
            }
            .onChange(of: arrivalIsChosen) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    UserDefaults.standard.set(departure, forKey: USER_DEFAULS_KEY)
                    router.navigate(to: .countrySelected)
                }
            }
            .navigationDestination(for: NavigationRouter.Destination.self) { destination in
                switch destination {
                case .countrySelected: CountrySelectedSearchView(departure: $departure, arrival: $arrival)
                case let .allTickets(for: data): AllTicketsView(departure: data.departure, arrival: data.arrival, date: data.date)
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.loadData()
            }
        }
        .environmentObject(router)
    }
    
    //MARK: - searchHeader
    var searchHeader: some View {
        Text("Поиск дешевых \n авиабилетов")
            .font(Font.DesignSystem.title1)
            .multilineTextAlignment(.center)
    }
    
    //MARK: - searchBar
    var searchBar: some View {
        SearchBar(barButtonName: "search",
                  departure: $departure,
                  arrival: $arrival,
                  arrivalOnTapAction: { showSheet = true },
                  color: Colors.grey4,
                  dividerColor: Colors.white)
        .background(Colors.grey3)
        .cornerRadius(15)
        .padding(.top)
    }
    
    //MARK: - offersHeader
    var offersHeader: some View {
        Text("Музыкально отлететь")
            .font(Font.DesignSystem.title1)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top)
    }
    
    //MARK: - scrollOffers
    var scrollOffers: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(viewModel.offers) {offer in
                    OfferView(offer: offer)
                        .padding(.trailing)
                }
            }
        }
        .scrollIndicators(.hidden)
    }
    
    struct OfferView: View {
        let offer: Offer
        
        var body: some View {
            VStack(alignment: .leading, spacing: 4) {
                Image(String(offer.id))
                    .imageModifier()
                Text(offer.title)
                    .font(Font.DesignSystem.title3)
                Text(offer.town)
                    .font(Font.DesignSystem.text2)
                offerPrice
                    .font(Font.DesignSystem.text2)
            }
        }
        
        var offerPrice: some View {
            HStack {
                Image("airplane")
                    .foregroundColor(Colors.grey6)
                Text("от \(offer.price.value.asCurrency()) ₽")
            }
        }
        
        var thumbNailImage: some View {
            Image(String(offer.id))
                .imageModifier()
        }
    }
}

extension Image {
    func imageModifier() -> some View {
        self
            .resizable()
            .scaledToFit()
            .frame(width: 132, height: 133)
            .cornerRadius(16)
            .clipped()
    }
}

extension Int {
    func asCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        formatter.maximumFractionDigits = 0
        formatter.locale = Locale(identifier: "ru_RU")
        if let formattedValue = formatter.string(from: NSNumber(value: self)) {
            return formattedValue
        } else {
            return "\(self)"
        }
    }
}

//#Preview {
//    TicketsSearchView()
//        .preferredColorScheme(.dark)
//}
