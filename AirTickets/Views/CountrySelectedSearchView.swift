//
//  CountrySelectedSearchView.swift
//  AirTickets
//
//  Created by Kristina Grebneva on 31.05.2024.
//

import SwiftUI

struct CountrySelectedSearchView: View {
    @State var departure: String = ""
    @State var arrival: String = ""
    
    @State var departureDate: Date = .now
    @State var returnDate: Date?
    @State private var isDatePickerVisible: Bool = false
    
    var body: some View {
        VStack {
            searchBar
            
            buttons
        }
    }
    
    var searchBar: some View {
        SearchBar(
            barImageName: "arrow",
            departure: $departure,
            departureButtonAction: { String.swap(&departure, &arrival) },
            arrival: $arrival,
            arrivalButtonAction: {arrival = ""})
    }

    var buttons: some View {
        ScrollView(.horizontal) {
            HStack {
                returnDateButton
                
                departureDateButton
                
                passengerNumberButton
                
                filterButton
            }
            .buttonStyle(greyButton())
        }
        .padding()
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
        Button() {
            
        } label: {
            HStack {
                Image("filter")
                    .resizable()
                    .frame(width: 16, height: 16)
                Text("фильтры")
            }
        }
    }
    
    var passengerNumberButton: some View {
        Button() {

        } label: {
            HStack {
                Image("human")
                    .resizable()
                    .frame(width: 16, height: 16)
                Text("1,эконом")
            }
        }
    }
    
    @ViewBuilder
    var returnDateButton: some View {
        if let date = returnDate {
            dateButton(of: Binding(
                get: { date },
                set: { newValue in returnDate = newValue }
            ))
        } else {
            Button {
                isDatePickerVisible.toggle()
            } label: {
                HStack {
                    Image("plus")
                    Text("обратно")
                }
            }
            .sheet(isPresented: $isDatePickerVisible) {
                DatePickerView(date: $returnDate, isPresented: $isDatePickerVisible)
            }
        }
    }
    
    var departureDateButton: some View {
        dateButton(of: $departureDate)
    }
    
    func dateButton(of date: Binding<Date>) -> some View {
        VStack {
            Button(action: {
                isDatePickerVisible.toggle()
            }) {
                formattedDateText(from: date.wrappedValue)
            }
            .sheet(isPresented: $isDatePickerVisible) {
                DatePickerView(date: $returnDate, isPresented: $isDatePickerVisible)
            }
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
}

extension String {
    static func swap(_ a: inout String, _ b: inout String) {
        let temp = a
        a = b
        b = temp
    }
}

#Preview {
    CountrySelectedSearchView(departure: "Moscow", arrival: "Sochi")
        .preferredColorScheme(.dark)
}
