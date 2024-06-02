//
//  SearchBar.swift
//  AirTickets
//
//  Created by Kristina Grebneva on 30.05.2024.
//

import SwiftUI

struct SearchBar: View {
    let barButtonName: String?
    let barButtonAction: (() -> Void)?
    
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
    let arrivalOnSubmitAction: (() -> Void)?
    
    let color: Color
    let dividerColor: Color
    
    var body: some View {
        HStack {
            if let name = barButtonName {
                Button {
                    if let action = barButtonAction {
                        action()
                    }
                } label: {
                    Image(name)
                        .foregroundColor(barButtonAction == nil ? .white : .blue)
                }
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
                       onTapAction: arrivalOnTapAction, onSubmitAction: arrivalOnSubmitAction)
            }
        }
            .padding()
            .background(color)
            .cornerRadius(15)
            .shadow(color: .black, radius: 3, x: 0, y: 3)
            .padding()
    }
    
    init(barButtonName: String? = nil,
         barButtonAction: ( () -> Void)? = nil,
         departure: Binding<String>,
         departureImageName: String? = nil,
         departureButtonAction: ( () -> Void)? = nil,
         arrival: Binding<String>, arrivalImageName: String? = nil,
         arrivalButtonAction: ( () -> Void)? = nil,
         arrivalOnTapAction: ( () -> Void)? = nil,
         arrivalOnSubmitAction: (() -> Void)? = nil,
         color: Color = Colors.grey3,
         dividerColor: Color = Colors.grey5) {
        
        self.barButtonName = barButtonName
        self.barButtonAction = barButtonAction
        
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
        self.arrivalOnSubmitAction = arrivalOnSubmitAction
        
        self.color = color
        self.dividerColor = dividerColor
    }
    
    struct Search: View {
        var destination: Binding<String>
        let imageName: String?
        let placeholder: String
        let action: (() -> Void)?
        let actionIconName: String?
        let onTapAction: (() -> Void)?
        let onSubmitAction: (() -> Void)?
        let hideButton: Bool
        
        var body: some View {
            HStack {
                if let name = imageName {
                    Image(name)
                }
                
                destinationTextField
                
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
        
        var destinationTextField: some View {
            TextField(placeholder, text: destination)
                .font(Font.DesignSystem.title3)
                .onChange(of: destination.wrappedValue) { _, newValue in
                    destination.wrappedValue = filterCyrillic(input: newValue)
                }
                .onTapGesture {
                    if let action = onTapAction {
                        action()
                    }
                }
                .onSubmit {
                    if let action = onSubmitAction {
                        action()
                    }
                }
        }
        
        func filterCyrillic(input: String) -> String {
                let cyrillicCharacters = input.filter { $0.isCyrillic }
                return String(cyrillicCharacters)
            }
        
        init(destination: Binding<String>, 
             imageName: String?,
             placeholder: String,
             action: ( () -> Void)?, 
             actionIconName: String? = nil,
             onTapAction: ( () -> Void )? = nil,
             onSubmitAction: ( () -> Void )? = nil,
             hideButton: Bool = true) {
            
            self.destination = destination
            self.imageName = imageName
            self.placeholder = placeholder
            self.action = action
            self.actionIconName = actionIconName
            self.onTapAction = onTapAction
            self.onSubmitAction = onSubmitAction
            self.hideButton = hideButton
        }
    }
}

extension Character {
    var isCyrillic: Bool {
        return ("А"..."я").contains(self) || self == "ё" || self == "Ё"
    }
}

//#Preview {
//    SearchBar()
//}
