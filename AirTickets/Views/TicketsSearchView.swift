//
//  TicketsSearchView.swift
//  AirTickets
//
//  Created by Kristina Grebneva on 29.05.2024.
//

import SwiftUI

struct TicketsSearchView: View {
    @StateObject var viewModel = OffersViewModel()
    
    @State private var departure: String = ""
    @State private var arrival: String = ""
    
    @State private var showSheet: Bool = false
    
    var body: some View {
        VStack {
            Text("Поиск дешевых \n авиабилетов")
                .font(Font.DesignSystem.title1)
                .multilineTextAlignment(.center)
            //Spacer()
            
            searchBar
            //Spacer()
            
            Text("Музыкально отлететь")
                .font(Font.DesignSystem.title1)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            scrollOffers
            Spacer()
            Spacer()
        }
        .sheet(isPresented: $showSheet)  {
            DetailedTicketSearchView(departure: departure)
            
        }
        .onAppear {
            Task {
                await viewModel.loadData()
            }
        }
        
    }
    
    var searchBar: some View {
        SearchBar(barImageName: "search",
                  departure: $departure,
                  arrival: $arrival,
                  arrivalOnTapAction: { showSheet = true },
                  color: Colors.grey4,
                  dividerColor: Colors.white)
        .background(Colors.grey3)
        .cornerRadius(15)
        .padding()
    }
    
    var scrollOffers: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(viewModel.offers) {offer in
                    OfferView(offer: offer)
                        .padding(.trailing, 67)
                }
            }
        }
        .scrollIndicators(.hidden)
    }
    
    
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
            Text("от \(offer.price.value) ₽")
        }
    }
    
    var thumbNailImage: some View {
        Image(String(offer.id))
            .imageModifier()
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

#Preview {
    TicketsSearchView()
        .preferredColorScheme(.dark)
}
