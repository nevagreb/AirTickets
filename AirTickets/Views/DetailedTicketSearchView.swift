//
//  DetailedTicketSearchView.swift
//  AirTickets
//
//  Created by Kristina Grebneva on 30.05.2024.
//

import SwiftUI

struct DetailedTicketSearchView: View {
    @Binding var departure: String
    @Binding var arrival: String
    @Binding var arrivalIsChosen: Bool
    
    @State private var showPlaceHolder: Bool = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                searchBar
                optionsButtons
                destinations
            }
            .padding(.top)
            .background(Colors.grey2)
            .foregroundColor(Colors.white)
            .navigationDestination(isPresented: $showPlaceHolder) {
                ComingSoonView()
            }
        }
        .presentationDragIndicator(.visible)
    }
    
    //MARK: - searchBar
    var searchBar: some View {
        SearchBar(departure: $departure,
                  departureImageName: "airplane2",
                  arrival: $arrival,
                  arrivalImageName: "search",
                  arrivalButtonAction: { arrival = "" }, arrivalOnSubmitAction: { arrivalIsChosen.toggle(); dismiss() })
    }
    
    //MARK: - optionsButtons
    var optionsButtons: some View {
        HStack(alignment: .top) {
            ActionButton(name: "Сложный маршрут", 
                         color: Colors.green,
                         imageName: "route",
                         action: { showPlaceHolder.toggle() })
            
            ActionButton(name: "Куда угодно", 
                         color: Colors.blue,
                         imageName: "world", 
                         action: {
                            arrival = Destination.cities.randomElement() ?? ""
                            arrivalIsChosen.toggle()
                            dismiss()
                        })
            
            ActionButton(name: "Выходные", 
                         color: Colors.darkBlue,
                         imageName: "calendar",
                         action: { showPlaceHolder.toggle() })
            
            ActionButton(name: "Горячие билеты", 
                         color: Colors.orange,
                         imageName: "fire",
                         action: { showPlaceHolder.toggle() })
        }
    }
    
    struct ActionButton: View {
        let name: String
        let color: Color
        let imageName: String
        
        let action: () -> Void
        
        var body: some View {
            Button {
                action()
            } label: {
                VStack {
                    ZStack{
                        RoundedRectangle(cornerRadius: 8)
                            .fill(color)
                            .frame(width: 48, height: 48)
                        Image(imageName)
                    }
                    Text(name)
                        .font(Font.DesignSystem.text2)
                }
                .padding(.horizontal, 16)
            }
        }
    }
    
    //MARK: - destinations
    var destinations: some View { List {
        ForEach(Destination.examples, id: \.self) { destination in
            HStack {
                Image(destination.imageName)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .cornerRadius(8)
                VStack(alignment: .leading) {
                    Text(destination.name)
                        .font(Font.DesignSystem.buttonText1)
                    Text("Популярное направление")
                        .foregroundStyle(Colors.grey5)
                        .font(Font.DesignSystem.text2)
                }
            }
            .onTapGesture {
                arrival = destination.name
                arrivalIsChosen.toggle()
                dismiss()
            }
        }
        .listRowBackground(Colors.grey3)
        .listRowSeparatorTint(Colors.grey5)
    }
    .scrollContentBackground(.hidden)
    .background(Colors.grey2)
    }
    
    struct Destination: Hashable {
        var name: String
        var imageName: String
        
        static var examples = [
            Destination(name: "Стамбул", imageName: "istanbul"),
            Destination(name: "Сочи", imageName: "sochi"),
            Destination(name: "Пхукет", imageName: "phuket")]
        
        static var cities = [
            "Лондон",
            "Нью-Йорк",
            "Санкт-Петербург",
            "Ростов-на-Дону",
            "Валенсия",
            "Париж"]
    }
}

//#Preview {
//    var departure = ""
//    var arrival = ""
//    var isChosen = false
//    
//    return DetailedTicketSearchView(departure: Binding(get: {departure}, set: {departure = $0}), arrival: Binding(get: {arrival}, set: {arrival = $0}), arrivalIsChosen: Binding(get: {isChosen}, set: {isChosen = $0}))
//        .preferredColorScheme(.dark)
//}
