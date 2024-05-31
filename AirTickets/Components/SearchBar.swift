//
//  SearchBar.swift
//  AirTickets
//
//  Created by Kristina Grebneva on 30.05.2024.
//

import SwiftUI

struct SearchBar: View {
    let barImageName: String?
    
    let departure: Binding<String>
    let departureImageName: String?
    let departurePlaceholder: String
    let departureButtonAction: (() -> Void)?
    let departureButtonActionIcon: String
    
    let arrival: Binding<String>
    let arrivalImageName: String?
    let arrivalPlaceholder: String
    let arrivalButtonAction: (() -> Void)?
    let arrivalButtonActionIcon: String
    let arrivalOnTapAction: (() -> Void)?
    
    
    let color: Color
    let dividerColor: Color
    
    var body: some View {
        HStack {
            if let name = barImageName {
                Image(name)
            }
            
            VStack {
                Search(destination: departure, 
                       imageName: departureImageName,
                       placeholder: departurePlaceholder,
                       action: departureButtonAction,
                       actionIconName: departureButtonActionIcon,
                       hideButton: false)
                
                Divider()
                    .background(dividerColor)
                
                Search(destination: arrival, 
                       imageName: arrivalImageName,
                       placeholder: arrivalPlaceholder,
                       action: arrivalButtonAction,
                       actionIconName: arrivalButtonActionIcon,
                       onTapAction: arrivalOnTapAction)
            }
        }
            .padding()
            .background(color)
            .cornerRadius(15)
            .shadow(color: .black, radius: 3, x: 0, y: 3)
            .padding()
    }
    
    init(barImageName: String? = nil, 
         departure: Binding<String>,
         departureImageName: String? = nil,
         departureButtonAction: ( () -> Void)? = nil,
         arrival: Binding<String>, arrivalImageName: String? = nil,
         arrivalButtonAction: ( () -> Void)? = nil,
         arrivalOnTapAction: ( () -> Void)? = nil,
         color: Color = Colors.grey3,
         dividerColor: Color = Colors.grey5) {
        
        self.barImageName = barImageName
        
        self.departure = departure
        self.departureImageName = departureImageName
        self.departurePlaceholder = "Откуда - Москва"
        self.departureButtonAction = departureButtonAction
        self.departureButtonActionIcon = "replace"
        
        self.arrival = arrival
        self.arrivalImageName = arrivalImageName
        self.arrivalPlaceholder = "Куда - Турция"
        self.arrivalButtonAction = arrivalButtonAction
        self.arrivalButtonActionIcon = "closeIcon"
        self.arrivalOnTapAction = arrivalOnTapAction
        
        self.color = color
        self.dividerColor = dividerColor
    }
    
    struct Search: View {
        let destination: Binding<String>
        let imageName: String?
        let placeholder: String
        let action: (() -> Void)?
        let actionIconName: String?
        let onTapAction: (() -> Void)?
        let hideButton: Bool
        
        var body: some View {
            HStack {
                if let name = imageName {
                    Image(name)
                }
                
                TextField(placeholder, text: destination)
                    .bold()
                    .onTapGesture {
                        if let action = onTapAction {
                            action()
                        }
                    }
                
                if let buttonAction = action, let iconName = actionIconName  {
                    Spacer()
                    Button {
                        buttonAction()
                    } label: {
                        Image(iconName)
                    }
                    .opacity(!hideButton || destination.wrappedValue != "" ? 1 : 0)
                }
            }
            .listRowBackground(Colors.grey4)
        }
        
        init(destination: Binding<String>, 
             imageName: String?,
             placeholder: String,
             action: ( () -> Void)?, 
             actionIconName: String? = nil,
             onTapAction: ( () -> Void)? = nil,
             hideButton: Bool = true) {
            
            self.destination = destination
            self.imageName = imageName
            self.placeholder = placeholder
            self.action = action
            self.actionIconName = actionIconName
            self.onTapAction = onTapAction
            self.hideButton = hideButton
        }
    }
}


//#Preview {
//    SearchBar()
//}
