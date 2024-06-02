//
//  NavigationRouter.swift
//  AirTickets
//
//  Created by Kristina Grebneva on 02.06.2024.
//

import Foundation
import SwiftUI

class NavigationRouter: ObservableObject {
    public enum Destination: Codable, Hashable {
        case countrySelected
        case allTickets(for: ChosenData)
    }
    
    @Published var path = NavigationPath()
    
    func navigate(to destination: Destination) {
        path.append(destination)
    }
    
    func navigateBack() {
        path.removeLast()
    }
    
    func navigateToRoot() {
        path.removeLast(path.count)
    }
}
