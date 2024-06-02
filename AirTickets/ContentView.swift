//
//  ContentView.swift
//  AirTickets
//
//  Created by Kristina Grebneva on 28.05.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            TicketsSearchView()
                .tabItem {
                        Image("airplane")
                        Text("Авиабилеты")}
            ComingSoonView()
                .tabItem {
                        Image("bed")
                        Text("Отели")}
            ComingSoonView()
                .tabItem {
                        Image("pointer")
                        Text("Короче")}
            ComingSoonView()
                .tabItem {
                        Image("bell")
                        Text("Подписки")}
            ComingSoonView()
                .tabItem {
                        Image("human")
                        Text("Профиль")}
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
