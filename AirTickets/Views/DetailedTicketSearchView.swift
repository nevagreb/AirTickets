//
//  DetailedTicketSearchView.swift
//  AirTickets
//
//  Created by Kristina Grebneva on 30.05.2024.
//

import SwiftUI

struct DetailedTicketSearchView: View {
    @State var departure: String = ""
    @State var arrival: String = ""
    
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                searchBar
                
                optionsButtons
                    .navigationDestination(for: String.self) {_ in
                        ComingSoonView()
                    }
                
                destinations
                
            }
            .padding(.top)
            .background(Colors.grey2)
            .foregroundColor(Colors.white)
        }
        .presentationDragIndicator(.visible)
    }
    
    var searchBar: some View {
        SearchBar(departure: $departure,
                  departureImageName: "airplane2",
                  arrival: $arrival,
                  arrivalImageName: "search",
                  arrivalButtonAction: {arrival = ""})
    }
    
    var optionsButtons: some View {
        HStack(alignment: .top) {
            ActionButton(name: "Сложный маршрут", color: Colors.green, imageName: "route", action: { path.append("NewView") })
            
            ActionButton(name: "Куда угодно", color: Colors.blue, imageName: "world", action: { arrival = "Paris" })
            
            ActionButton(name: "Выходные", color: Colors.darkBlue, imageName: "calendar", action: { path.append("NewView") })
            
            ActionButton(name: "Горячие билеты", color: Colors.orange, imageName: "fire", action: { path.append("NewView") })
        }
    }
    
    struct Destination: Hashable {
        var name: String
        var imageName: String
        
        static var examples = [Destination(name: "Стамбул", imageName: "istanbul"), Destination(name: "Сочи", imageName: "sochi"), Destination(name: "Пхукет", imageName: "phuket")]
    }
    
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
            }
        }
        .listRowBackground(Colors.grey3)
        .listRowSeparatorTint(Colors.grey5)
    }
    .scrollContentBackground(.hidden)
    .background(Colors.grey2)
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
            VStack  {
                ZStack{
                    RoundedRectangle(cornerRadius: 8)
                        .fill(color)
                        .frame(width: 48, height: 48)
                    Image(imageName)
                    
                }
                Text(name)
                    .font(Font.DesignSystem.text2)
            }
            .padding(16)
        }
    }
}

#Preview {
    DetailedTicketSearchView()
        .preferredColorScheme(.dark)
}
